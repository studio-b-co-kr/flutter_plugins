import 'dart:developer' as dev;

import 'package:kakao_login/kakao_login.dart';
// ignore: implementation_imports
import 'package:kakao_login/src/client_error.dart';
import 'package:remedi_auth/model/app_credential.dart';
import 'package:remedi_auth/model/apple_credential.dart';
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

      var ret = await repository.loginWithApple(appleCredential);

      if (ret is AppCredential) {
        await Future.wait([
          repo.writeUserId(ret.userId),
          repo.writeAccessToken(ret.accessToken),
          repo.writeRefreshToken(ret.refreshToken)
        ]);

        update(state: LoginViewState.Success);
        return;
      }

      if (ret is AuthError) {
        this.error = ret;
        update(state: LoginViewState.Error);
      }

      if (ret == null) {
        this.error = AuthError(
          title: AppStrings.loginError,
          code: AppStrings.codeLoginError,
          message: AppStrings.messageAuthError,
        );
        update(state: LoginViewState.Error);
      }
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

    final KakaoLogin kakaoSignIn = KakaoLogin.instance;
    await kakaoSignIn.init(kakaoAppId);

    final String hashKey = await (kakaoSignIn.hashKey);
    dev.log(hashKey, name: "Kakao HASH");
    String kakaoAccessToken;
    int kakaoId;
    try {
      final login = await kakaoSignIn.logIn();
      login.when(() => null, success: (token) {
        dev.log("$token", name: "Kakao Login Success");
        kakaoAccessToken = token.accessToken;
      }, fail: (error) {
        dev.log("$error", name: "Kakao Login Fail");
        this.error = AuthError(
            title: AppStrings.codeKakaoLoginError,
            code: AppStrings.codeKakaoLoginError,
            message: AppStrings.messageAuthError,
            error: error);
      });

      if (login.isError) {
        if (error.error is ClientErrorCancelled) {
          update(state: LoginViewState.Idle);
          return;
        }

        update(state: LoginViewState.Error);
        return;
      }

      final result = await kakaoSignIn.currentUser;
      result.when(() => null, success: (value) {
        dev.log("$value", name: "Kakao Login Success");
        kakaoId = value.id;
      }, fail: (error) {
        dev.log("$error", name: "Kakao Login Fail");
        this.error = AuthError(
            title: AppStrings.codeKakaoLoginError,
            code: AppStrings.codeKakaoLoginError,
            message: AppStrings.messageAuthError,
            error: error);
      });

      if (result.isValue) {
        var ret = await repository.loginWithKakao(
            KakaoCredential(accessToken: kakaoAccessToken, id: kakaoId));

        if (ret is AppCredential) {
          await Future.wait([
            repo.writeUserId(ret.userId),
            repo.writeAccessToken(ret.accessToken),
            repo.writeRefreshToken(ret.refreshToken)
          ]);
          update(state: LoginViewState.Success);
          return;
        }

        if (ret is AuthError) {
          this.error = ret;
          update(state: LoginViewState.Error);
          return;
        }
      } else {
        this.error = AuthError(
            title: AppStrings.loginError,
            code: AppStrings.codeLoginError,
            message: AppStrings.messageAuthError);
        update(state: LoginViewState.Error);
        return;
      }
    } catch (error) {
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
