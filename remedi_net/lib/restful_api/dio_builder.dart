part of 'remedi_restful_api.dart';

class DioBuilder {
  final String baseUrl;
  final String contentType;
  int connectTimeout;
  Map<String, dynamic>? headers;
  bool enableLogging;

  DioBuilder._({
    required this.baseUrl,
    required this.contentType,
    this.connectTimeout = 1500,
    this.headers = const {},
    this.enableLogging = false,
  });

  Future<Dio> build() async {
    Dio dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = connectTimeout;
    dio.options.contentType = contentType;
    if (headers?.isNotEmpty ?? false) {
      dio.options.headers.addAll(headers!);
    }
    return dio;
  }

  factory DioBuilder.json({
    required String baseUrl,
    int connectTimeout = 1500,
    Map<String, dynamic>? headers = const {},
    bool enableLogging = false,
  }) {
    return DioBuilder._(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      headers: headers,
      contentType: Headers.jsonContentType,
      enableLogging: enableLogging,
    );
  }

  factory DioBuilder.fromUrl({
    required String baseUrl,
    int connectTimeout = 1500,
    Map<String, dynamic>? headers = const {},
    bool enableLogging = false,
  }) {
    return DioBuilder._(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      headers: headers,
      contentType: Headers.formUrlEncodedContentType,
      enableLogging: enableLogging,
    );
  }

  factory DioBuilder.textPain({
    required String baseUrl,
    int connectTimeout = 1500,
    Map<String, dynamic>? headers = const {},
    bool enableLogging = false,
  }) {
    return DioBuilder._(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      headers: headers,
      contentType: Headers.textPlainContentType,
      enableLogging: enableLogging,
    );
  }
}
