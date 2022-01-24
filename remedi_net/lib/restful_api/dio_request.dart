part of 'remedi_restful_api.dart';

/// this class request to server something using [DioBuilder].
/// before requesting to remote, should make a dio instance from [createDio].
class DioRequest {
  final DioBuilder builder;

  DioRequest({required this.builder});

  Future<dynamic> request({
    required String method,
    String? path,
    Map<String, dynamic>? queries,
    dynamic data,
  }) async {
    try {
      var response = await dio.request(
        path ?? "",
        data: data,
        queryParameters: queries,
      );
      return response;
    } on DioError catch (e) {
      return HttpError.fromDioError(e);
    }
  }

  cancel() {
    dio.close();
    dio.clear();
  }

  Dio get dio => builder.dio;
}
