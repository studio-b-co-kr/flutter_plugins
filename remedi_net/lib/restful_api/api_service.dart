part of 'remedi_restful_api.dart';

abstract class ApiService<T> {
  DioRequest get client;

  Future<dynamic> requestGet(
      {String? path, Map<String, dynamic>? queries}) async {
    await client.createDio();
    return client.dio.get(
      path ?? "",
      queryParameters: queries,
    );
  }

  Future<dynamic> requestPost(
      {String? path, Map<String, dynamic>? queries, data}) async {
    await client.createDio();
    return client.dio.post(
      path ?? "",
      data: data,
      queryParameters: queries,
    );
  }

  Future<dynamic> requestPut(
      {String? path, Map<String, dynamic>? queries, data}) async {
    await client.createDio();
    return client.dio.put(
      path ?? "",
      data: data,
      queryParameters: queries,
    );
  }

  Future<dynamic> requestHead(
      {String? path, Map<String, dynamic>? queries, data}) async {
    await client.createDio();
    return client.dio.head(
      path ?? "",
      data: data,
      queryParameters: queries,
    );
  }

  Future<dynamic> requestDelete(
      {String? path, Map<String, dynamic>? queries, data}) async {
    await client.createDio();
    return client.dio.delete(
      path ?? "",
      data: data,
      queryParameters: queries,
    );
  }

  Future<dynamic> requestPatch(
      {String? path, Map<String, dynamic>? queries, data}) async {
    await client.createDio();
    return client.dio.patch(
      path ?? "",
      data: data,
      queryParameters: queries,
    );
  }

  cancel() {
    client.dio.close();
    client.dio.clear();
  }
}
