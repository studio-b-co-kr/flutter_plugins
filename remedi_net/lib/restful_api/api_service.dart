part of 'remedi_restful_api.dart';

abstract class ApiService<T> {
  DioRequest get client;

  Future<dynamic> requestGet(
      {String? path, Map<String, dynamic>? queries}) async {
    return client.requestGet(
      path: path ?? "",
      queries: queries,
    );
  }

  Future<dynamic> requestPost(
      {String? path, Map<String, dynamic>? queries, data}) async {
    return client.requestPost(
      path: path ?? "",
      data: data,
      queries: queries,
    );
  }

  Future<dynamic> requestPut(
      {String? path, Map<String, dynamic>? queries, data}) async {
    return client.requestPut(
      path: path ?? "",
      data: data,
      queries: queries,
    );
  }

  Future<dynamic> requestHead(
      {String? path, Map<String, dynamic>? queries, data}) async {
    return client.requestHead(
      path: path ?? "",
      data: data,
      queries: queries,
    );
  }

  Future<dynamic> requestDelete(
      {String? path, Map<String, dynamic>? queries, data}) async {
    return client.requestDelete(
      path: path ?? "",
      data: data,
      queries: queries,
    );
  }

  Future<dynamic> requestPatch(
      {String? path, Map<String, dynamic>? queries, data}) async {
    return client.requestPatch(
      path: path ?? "",
      data: data,
      queries: queries,
    );
  }

  cancel() {
    client.cancel();
  }
}
