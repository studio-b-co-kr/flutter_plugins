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

  Future<dynamic> request({
    required String method,
    String? path,
    Map<String, dynamic>? queries,
    dynamic data,
  }) async {
    assert(dio == null);
    try {
      await _createDio();
      var response = await dio!.request(
        path ?? "",
        data: data,
        options: Options(method: method),
        queryParameters: queries,
      );
      return response;
    } on DioError catch (e) {
      return HttpError.fromDioError(e);
    }
  }

  cancel() {
    dio?.close();
    dio?.clear();
  }
}
