part of 'remedi_restful_api.dart';

class AuthHeaderInterceptor extends Interceptor {
  final AuthType authType;

  final Future<String?> token;

  AuthHeaderInterceptor({required this.authType, required this.token});

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    options.headers.addAll({
      "Authorization": "$prefix${await token}",
    });
    return super.onRequest(options, handler);
  }

  String get prefix {
    String ret;
    switch (authType) {
      case AuthType.basic:
        ret = 'Basic ';
        break;
      case AuthType.bearer:
        ret = 'Bearer ';
        break;
    }
    return ret;
  }
}

enum AuthType { basic, bearer }
