import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:remedi_net/remedi_net.dart';

void main() {
  group('', () {
    test('', () async {
      TestApiService testApiService = TestApiService();
      Dio? dio = await testApiService.testDio();
      int i = 0;
      DioAdapter dioAdapter = DioAdapter(dio: dio!);

      var ret = await testApiService.get();
      int i2 = 0;
    });
  });

  // group('fetchAlbum', () {
  //   test('returns an Album if the http call completes successfully', () async {
  //     TestApiService testApiService = TestApiService();
  //     Dio? dio = await testApiService.testDio();
  //     var ret = await testApiService.get();
  //     int i = 0;
  //   });
  // });
}

class TestApiService extends ApiService<TestResponse> {
  get() async {
    return await requestGet();
  }

  @override
  DioRequest get client => DioRequest(DioBuilder.json(
      baseUrl: "https://test.test.com",
      httpClientAdapter: SuccessHttpClientAdapter()));

  @override
  TestResponse? fromJson(json) {}
}

class SuccessHttpClientAdapter extends HttpClientAdapter {
  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<Uint8List>? requestStream, Future? cancelFuture) async {
    Map<String, dynamic> ret = {'value': 900};
    return ResponseBody.fromString(jsonEncode(ret), 200);
  }
}

class TestResponse extends IDto {
  @override
  TestResponse fromJson(json) {
    return TestResponse();
  }
}
