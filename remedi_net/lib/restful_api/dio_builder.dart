part of 'remedi_restful_api.dart';

/// This class build a Dio using build() method
/// This class build some env. to requesting [headers], [contentType], [connectTimeout], [baseUrl] and [enableLogging]
class DioBuilder {
  final String baseUrl;
  final String contentType;
  int connectTimeout;
  Map<String, dynamic>? headers;
  bool enableLogging;
  Map<String, Future<dynamic>>? futureHeaders;

  DioBuilder._({
    required this.baseUrl,
    required this.contentType,
    this.connectTimeout = 1500,
    this.headers,
    this.enableLogging = false,
    this.futureHeaders,
  });

  Future<Dio> build() async {
    Dio dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = connectTimeout;
    dio.options.contentType = contentType;
    if (headers?.isNotEmpty ?? false) {
      dio.options.headers.addAll(headers!);
    }

    if (futureHeaders?.isNotEmpty ?? false) {
      Map<String, dynamic> extraHeaders = {};
      for (String element in futureHeaders!.keys) {
        extraHeaders.addAll({element: await futureHeaders![element]});
      }

      if (extraHeaders.isNotEmpty) {
        dio.options.headers.addAll(extraHeaders);
      }
    }

    dio.interceptors.add(LogInterceptor(
      request: enableLogging,
      requestBody: enableLogging,
      requestHeader: enableLogging,
      responseBody: enableLogging,
      responseHeader: enableLogging,
      error: enableLogging,
    ));

    return dio;
  }

  factory DioBuilder.json({
    required String baseUrl,
    int connectTimeout = 1500,
    Map<String, dynamic>? headers,
    bool enableLogging = false,
    Map<String, Future<dynamic>>? futureHeaders,
  }) {
    return DioBuilder._(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      headers: headers,
      contentType: Headers.jsonContentType,
      enableLogging: enableLogging,
      futureHeaders: futureHeaders,
    );
  }

  factory DioBuilder.fromUrl({
    required String baseUrl,
    int connectTimeout = 1500,
    Map<String, dynamic>? headers,
    bool enableLogging = false,
    Map<String, Future<dynamic>>? futureHeaders,
  }) {
    return DioBuilder._(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      headers: headers,
      contentType: Headers.formUrlEncodedContentType,
      enableLogging: enableLogging,
      futureHeaders: futureHeaders,
    );
  }

  factory DioBuilder.textPain({
    required String baseUrl,
    int connectTimeout = 1500,
    Map<String, dynamic>? headers,
    bool enableLogging = false,
    Map<String, Future<dynamic>>? futureHeaders,
  }) {
    return DioBuilder._(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      headers: headers,
      contentType: Headers.textPlainContentType,
      enableLogging: enableLogging,
      futureHeaders: futureHeaders,
    );
  }
}
