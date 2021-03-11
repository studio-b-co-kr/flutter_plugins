import 'dart:developer' as dev;

// ignore: implementation_imports
import 'package:flutter/services.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:remedi_auth/auth_repository.dart';
import 'package:remedi_auth/model/apple_credential.dart';
import 'package:remedi_auth/model/i_app_credential.dart';
import 'package:remedi_auth/model/kakao_credential.dart';
import 'package:remedi_auth/repository/i_login_repository.dart';
import 'package:remedi_auth/resources/app_strings.dart';
import 'package:remedi_auth/viewmodel/i_login_viewmodel.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../auth_error.dart';

class LoginViewModel extends ILoginViewModel {
  final String kakaoAppId;

  LoginViewModel({ILoginRepository repo, this.kakaoAppId})
      : assert(repo != null),
        super(repo: repo);

  @override
  LoginViewState get initState => LoginViewState.Idle;

  @override
  loginWithApple() async {
    update(state: LoginViewState.Loading);
    bool isAvailable = await SignInWithApple.isAvailable();
    if (!isAvailable) {
      this.error = AuthError(
          title: AppStrings.loginError,
          code: AppStrings.codeAppleLoginError,
          message: AppStrings.invalidVersionAppleLogin);
      update(state: LoginViewState.Error);
      return;
    }

    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      AppleCredential appleCredential = AppleCredential(
          userIdentifier: credential.userIdentifier,
          identityToken: credential.identityToken,
          authorizationCode: credential.authorizationCode,
          email: credential.email);

      ICredential appCredential =
          await repository.loginWithApple(appleCredential);

      if (appCredential.isError) {
        this.error = appCredential.error;
        update(state: LoginViewState.Error);
        return;
      }

      await Future.wait([
        AuthRepository.instance.writeUserId(appCredential.userId),
        AuthRepository.instance.writeAccessToken(appCredential.accessToken),
        AuthRepository.instance.writeRefreshToken(appCredential.refreshToken)
      ]);

      update(state: LoginViewState.Success);
      return;
    } catch (e) {
      if (e.toString().contains('AuthorizationErrorCode.canceled')) {
        update(state: LoginViewState.Idle);
      } else {
        this.error = AuthError(
            title: AppStrings.loginError,
            code: AppStrings.codeAppleLoginError,
            message: AppStrings.messageAuthError,
            error: e);
        update(state: LoginViewState.Error);
      }
    }
  }

  @override
  loginWithKakao() async {
    assert(kakaoAppId != null);
    update(state: LoginViewState.Loading);

    final FlutterKakaoLogin kakaoSignIn = FlutterKakaoLogin();
    await kakaoSignIn.init(kakaoAppId);

    final String hashKey = await (kakaoSignIn.hashKey);
    dev.log(hashKey, name: "Kakao HASH");
    String kakaoAccessToken;
    String kakaoId;
    try {
      var login = await kakaoSignIn.logIn();

      switch (login.status) {
        case KakaoLoginStatus.loggedIn:
          dev.log("${login.token.accessToken}", name: "Kakao Login Success");
          kakaoAccessToken = login.token.accessToken;
          login = await kakaoSignIn.getUserMe();
          await kakaoSignIn.logOut();
          break;
        case KakaoLoginStatus.loggedOut:
        case KakaoLoginStatus.unlinked:
          this.error = AuthError(
              title: AppStrings.codeKakaoLoginError,
              code: AppStrings.codeKakaoLoginError,
              message: AppStrings.messageAuthError);
          update(state: LoginViewState.Error);
          return;
      }

      kakaoId = login.account.userID;

      int id = 0;
      try {
        id = int.tryParse(kakaoId);
      } catch (e) {
        this.error = AuthError(
            title: AppStrings.codeKakaoLoginError,
            code: AppStrings.codeKakaoLoginError,
            message: AppStrings.messageAuthError);
        update(state: LoginViewState.Error);
        return;
      }

      ICredential credential = await repository.loginWithKakao(
          KakaoCredential(accessToken: kakaoAccessToken, id: id));

      if (credential.isError) {
        this.error = credential.error;
        update(state: LoginViewState.Error);
        return;
      }

      await Future.wait([
        AuthRepository.instance.writeUserId(credential.userId),
        AuthRepository.instance.writeAccessToken(credential.accessToken),
        AuthRepository.instance.writeRefreshToken(credential.refreshToken)
      ]);
      update(state: LoginViewState.Success);
      return;
    } catch (error) {
      if (error is PlatformException) {
        if (error.details == '/oauth/authorize cancelled.') {
          update(state: LoginViewState.Idle);
          return;
        }
      }
      this.error = AuthError(
          title: AppStrings.codeKakaoLoginError,
          code: AppStrings.codeKakaoLoginError,
          message: AppStrings.messageAuthError,
          error: error);
      update(state: LoginViewState.Error);
      return;
    }
  }
}
