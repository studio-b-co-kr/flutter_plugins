/// IApiService is base class for restful api service.
///
/// C is Client in charge of http request/response. like Dio, Retrofit and etc.
/// R is Response of api request.
abstract class IApiService {
  final IClientBuilder clientBuilder;

  IApiService({required this.clientBuilder});

  String get path;

  Future<dynamic> requestPost({
    String? path,
    dynamic data,
    Map<String, dynamic>? query,
    Function(dynamic)? onSuccess,
    Function(dynamic)? onFail,
    Function(dynamic)? onError,
  });

  Future<dynamic> requestGet({
    String? path,
    dynamic data,
    Map<String, dynamic>? query,
    Function(dynamic)? onSuccess,
    Function(dynamic)? onFail,
    Function(dynamic)? onError,
  });

  Future<dynamic> requestPatch({
    String? path,
    dynamic data,
    Map<String, dynamic>? query,
    Function(dynamic)? onSuccess,
    Function(dynamic)? onFail,
    Function(dynamic)? onError,
  });

  Future<dynamic> requestDelete({
    String? path,
    dynamic data,
    Map<String, dynamic>? query,
    Function(dynamic)? onSuccess,
    Function(dynamic)? onFail,
    Function(dynamic)? onError,
  });
}

enum Method { post, get, patch, delete }

/// Factory create a http client instance.
/// C is should be dio or other http clients.

abstract class IClientBuilder<C> {
  final String baseUrl;

  IClientBuilder({required this.baseUrl});

  C build();

  Future<dynamic> post(String? path, {IDto? data, Map<String, dynamic>? query});

  Future<dynamic> get(String? path, {Map<String, dynamic>? query});

  Future<dynamic> patch(String? path,
      {IDto? data, Map<String, dynamic>? query});

  Future<dynamic> delete(String? path,
      {IDto? data, Map<String, dynamic>? query});
}

/// Data transfer object.
abstract class IDto {
  IDto();

  dynamic get toJson;
}
