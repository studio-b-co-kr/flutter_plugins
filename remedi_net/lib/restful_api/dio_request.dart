part of 'remedi_restful_api.dart';

/// this class request to server something using [DioBuilder].
/// before requesting to remote, should make a dio instance from [createDio].
class DioRequest {
  final DioBuilder dioBuilder;
  Dio? dio;

  DioRequest(this.dioBuilder);

  _createDio() async {
    dio = await dioBuilder.build();
  }

  requestGet({String? path, Map<String, dynamic>? queries}) async {
    assert(dio == null);
    await _createDio();
    return dio?.get(
      path ?? "",
      queryParameters: queries,
    );
  }

  requestPost({String? path, Map<String, dynamic>? queries, data}) async {
    assert(dio == null);
    await _createDio();
    return dio?.post(
      path ?? "",
      data: data,
      queryParameters: queries,
    );
  }

  requestPut({String? path, Map<String, dynamic>? queries, data}) async {
    assert(dio == null);
    await _createDio();
    return dio?.put(
      path ?? "",
      data: data,
      queryParameters: queries,
    );
  }

  requestHead({String? path, Map<String, dynamic>? queries, data}) async {
    assert(dio == null);
    await _createDio();
    return dio?.head(
      path ?? "",
      data: data,
      queryParameters: queries,
    );
  }

  requestDelete({String? path, Map<String, dynamic>? queries, data}) async {
    assert(dio == null);
    await _createDio();
    return dio?.delete(
      path ?? "",
      data: data,
      queryParameters: queries,
    );
  }

  requestPatch({String? path, Map<String, dynamic>? queries, data}) async {
    assert(dio == null);
    await _createDio();
    return dio?.patch(
      path ?? "",
      data: data,
      queryParameters: queries,
    );
  }

  cancel() {
    dio?.close();
    dio?.clear();
  }
}
