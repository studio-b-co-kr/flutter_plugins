part of 'remedi_restful_api.dart';

abstract class ApiService<T> {
  static const String methodGet = 'GET';
  static const String methodPost = 'POST';
  static const String methodPut = 'PUT';
  static const String methodHead = 'HEAD';
  static const String methodDelete = 'DELETE';
  static const String methodPatch = 'PATCH';

  DioRequest get client;

  Future<dynamic> _request({
    required String method,
    String? path,
    Map<String, dynamic>? queries,
    dynamic data,
  }) async {
    var response = await client.request(
        method: method, path: path, queries: queries, data: data);
    if (response is HttpError) {
      return response;
    }
    return fromJson((response as Response).data);
  }

  Future<dynamic> requestGet(
      {String? path, Map<String, dynamic>? queries}) async {
    return await _request(
      method: methodGet,
      path: path ?? "",
      queries: queries,
    );
  }

  Future<dynamic> requestPost(
      {String? path, Map<String, dynamic>? queries, data}) async {
    return await _request(
      method: methodPost,
      path: path ?? "",
      data: data,
      queries: queries,
    );
  }

  Future<dynamic> requestPut(
      {String? path, Map<String, dynamic>? queries, data}) async {
    return await _request(
      method: methodPut,
      path: path ?? "",
      data: data,
      queries: queries,
    );
  }

  Future<dynamic> requestHead(
      {String? path, Map<String, dynamic>? queries, data}) async {
    return await _request(
      method: methodHead,
      path: path ?? "",
      data: data,
      queries: queries,
    );
  }

  Future<dynamic> requestDelete(
      {String? path, Map<String, dynamic>? queries, data}) async {
    return await _request(
      method: methodDelete,
      path: path ?? "",
      data: data,
      queries: queries,
    );
  }

  Future<dynamic> requestPatch(
      {String? path, Map<String, dynamic>? queries, data}) async {
    return await _request(
      method: methodPatch,
      path: path ?? "",
      data: data,
      queries: queries,
    );
  }

  T? fromJson(dynamic json);

  cancel() {
    client.cancel();
  }
}
