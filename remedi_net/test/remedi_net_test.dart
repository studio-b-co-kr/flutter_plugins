import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:remedi_net/remedi_net.dart';

void main() {
  group('fetchAlbum', () {
    test('returns an Album if the http call completes successfully', () async {
      var ret = await TestApiService().get();
    });
  });
}

class TestApiService extends ApiService<TestResponse> {
  get() async {
    return requestGet();
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
