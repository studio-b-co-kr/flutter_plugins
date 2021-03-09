
/// IApiService is base class for restful api service.
///
/// C is Client in charge of http request/response. like Dio, Retrofit and etc.
/// R is Response of api request.
abstract class IApiService<C, R> {
  C _client;

  C get client => _client;

  /// url path.
  String get path;

  // request body
  final dynamic body;
  //request queries
  final Map<String, dynamic> query;

  IApiService(IClientFactory clientFactory, {this.body, this.query}) {
    _client = clientFactory.build();
  }

  Future<R> request({
    Function(dynamic) onSuccess,
    Function(dynamic) onFail,
    Function(dynamic) onError,
  });
}

/// Factory create a http client instance.
/// C is should be dio or other http clients.

abstract class IClientFactory<C> {
  final String baseUrl;

  IClientFactory({this.baseUrl});

  C build();
}

/// Data transfer object.
abstract class IDto {
  IDto();

  IDto.fromJson(Map<dynamic, dynamic> jsonMap);

  Map<dynamic, dynamic> toJson();
}
