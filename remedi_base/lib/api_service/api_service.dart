/// IApiService is base class for restful api service.
///
/// C is Client in charge of http request/response. like Dio, Retrofit and etc.
/// R is Response of api request.
abstract class IApiService<C, R> {
  final IClientFactory clientFactory;

  /// url path.
  String get path;

  // request body
  final dynamic body;

  //request queries
  final Map<String, dynamic>? query;

  IApiService(this.clientFactory, {this.body, this.query});

  Future<R?> request({
    Function(dynamic) onSuccess,
    Function(dynamic) onFail,
    Function(dynamic) onError,
  });
}

/// Factory create a http client instance.
/// C is should be dio or other http clients.

abstract class IClientFactory<C> {
  final String baseUrl;

  IClientFactory({required this.baseUrl});

  C build();
}

/// Data transfer object.
abstract class IDto {
  IDto();

  // factory IDto.fromJson(dynamic? jsonMap);

  Map<String, dynamic>? get toJson;
}
