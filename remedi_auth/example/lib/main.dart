import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:remedi_auth/feature/login/login_page.dart';
import 'package:remedi_auth/feature/login/login_viewmodel.dart';
import 'package:remedi_auth/feature/phone_verification/phone_verification_page.dart';
import 'package:remedi_auth/feature/phone_verification/phone_verification_repository.dart';
import 'package:remedi_auth/feature/phone_verification/phone_verification_viewmodel.dart';
import 'package:remedi_auth/remedi_auth.dart';

void main() {
  AuthManager.init(
      storage: MyStorage(),
      enableKakao: true,
      kakaoAppId: "2d097d3c402c32951f7cb13e87f63b8c",
      enableApple: true,
      enableEmailPassword: false);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: MyHomePage.ROUTE_NAME,
      onGenerateRoute: (settings) {
        Route? ret;
        switch (settings.name) {
          case MyHomePage.ROUTE_NAME:
            ret = MaterialPageRoute(builder: (context) => MyHomePage());
            break;
          case LoginPage.ROUTE_NAME_SPLASH:
            ret = MaterialPageRoute(
                settings: settings,
                builder: (context) {
                  return LoginPage(
                    routeBackTo: '/',
                    viewModel: LoginViewModel(
                        repository: LoginRepository(),
                        kakaoAppId: AuthManager.kakaoAppId),
                  );
                });
            break;
          case LoginPage.ROUTE_NAME:
            ret = MaterialPageRoute(
                settings: settings,
                builder: (context) {
                  return LoginPage(
                    viewModel: LoginViewModel(
                        repository: LoginRepository(),
                        kakaoAppId: AuthManager.kakaoAppId),
                  );
                });
            break;
          case PhoneVerificationPage.routeName:
            ret = MaterialPageRoute(
                settings: settings,
                builder: (context) {
                  return PhoneVerificationPage(
                    information: "서비스를 사용하기 위해 전화번호를 인증해주세요.",
                    viewModel: PhoneVerificationViewModel(
                        repository: PhoneVerificationRepository()),
                  );
                });
            break;
        }
        return ret;
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  static const ROUTE_NAME = "/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LoginExample"),
      ),
      body: SafeArea(
        child: Container(
          child: Column(children: [
            Expanded(
                child: Center(
              child: Text("Home page."),
            )),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: MaterialButton(
                  minWidth: double.infinity,
                  height: 48,
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(LoginPage.ROUTE_NAME);
                  },
                  child: Text("Push & Replace LoginPage")),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: MaterialButton(
                  height: 48,
                  color: Colors.green,
                  minWidth: double.infinity,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pushNamed(LoginPage.ROUTE_NAME);
                  },
                  child: Text("Push LoginPage")),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: MaterialButton(
                  height: 48,
                  color: Colors.red,
                  minWidth: double.infinity,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(PhoneVerificationPage.routeName);
                  },
                  child: Text("Phone Verification")),
            ),
          ]),
        ),
      ),
    );
  }
}

class MyAppCredential extends ICredential {
  MyAppCredential({
    required String userId,
    required String accessToken,
    String? refreshToken,
    AuthError? error,
  }) : super(
          userId: userId,
          accessToken: accessToken,
          refreshToken: refreshToken,
          error: error,
        );

  @override
  Map<String, dynamic>? get toJson => null;
}

class MyStorage extends IStorage {
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  @override
  Future delete({required String key}) async {
    await _storage.delete(key: key);
  }

  @override
  Future<String?> read({required String key}) async {
    return await _storage.read(key: key);
  }

  @override
  Future<void> write({required String key, required String value}) async {
    return await _storage.write(key: key, value: value);
  }
}

class LoginRepository extends ILoginRepository {
  @override
  Future<ICredential> loginWithApple(AppleCredential appleCredential) async {
    await Future.delayed(Duration(seconds: 1));
    return MyAppCredential(
        accessToken: "123", refreshToken: "123", userId: "123");
  }

  @override
  Future<ICredential> loginWithKakao(KakaoCredential credential) async {
    await Future.delayed(Duration(seconds: 1));
    return MyAppCredential(
        accessToken: "123", refreshToken: "123", userId: "123");
  }
}
