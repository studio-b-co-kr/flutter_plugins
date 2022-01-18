import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:remedi_net/remedi_net.dart';

void main() {
  group('fetchAlbum', () {
    test('returns an Album if the http call completes successfully', () async {
      try {
        var ret = await TestApiService().get();
        int i = 0;
      } on DioError catch (e) {
        // that falls out of the range of 2xx and is also not 304.
        if (e.response != null) {
          int i = 0;
        } else {
          // Something happened in setting up or sending the request that triggered an Error
          int i = 0;
        }
      }
    });
  });
}

class TestApiService extends ApiService {
  get() async {
    return requestGet();
  }

  @override
  DioRequest get client => DioRequest(DioBuilder.json(
      baseUrl: "https://test.test.com",
      httpClientAdapter: SuccessHttpClientAdapter()));
}

class SuccessHttpClientAdapter extends HttpClientAdapter {
  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<Uint8List>? requestStream, Future? cancelFuture) async {
    Map<String, dynamic> ret = {'value': 900};
    return ResponseBody.fromString(jsonEncode(ret), 400);
  }
}
