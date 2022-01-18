part of 'remedi_restful_api.dart';

class DioRequest {
  final DioBuilder dioBuilder;
  late Dio dio;

  DioRequest(this.dioBuilder);

  createDio() async {
    dio = await dioBuilder.build();
    return this;
  }

  requestGet({String? path, Map<String, dynamic>? queries}) async {
    return dio.get(
      path ?? "",
      queryParameters: queries,
    );
  }

  requestPost({String? path, Map<String, dynamic>? queries, data}) async {
    return dio.post(
      path ?? "",
      data: data,
      queryParameters: queries,
    );
  }

  requestPut({String? path, Map<String, dynamic>? queries, data}) async {
    return dio.put(
      path ?? "",
      data: data,
      queryParameters: queries,
    );
  }

  requestHead({String? path, Map<String, dynamic>? queries, data}) async {
    return dio.head(
      path ?? "",
      data: data,
      queryParameters: queries,
    );
  }

  requestDelete({String? path, Map<String, dynamic>? queries, data}) async {
    return dio.delete(
      path ?? "",
      data: data,
      queryParameters: queries,
    );
  }

  requestPatch({String? path, Map<String, dynamic>? queries, data}) async {
    return dio.patch(
      path ?? "",
      data: data,
      queryParameters: queries,
    );
  }

  cancel() {
    dio.close();
    dio.clear();
  }
}
