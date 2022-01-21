import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:remedi_net/remedi_net.dart';

void main() {
  group('Test restful api', () {
    // test('get', () async {
    //   final dio = Dio(BaseOptions());
    //   final dioAdapter = DioAdapter(dio: dio);
    //
    //   const path = 'https://example.com';
    //
    //   dioAdapter.onGet(
    //     path,
    //     (server) => server.reply(200, {'message': 'Success!'}),
    //   );
    //
    //   final response = await dio.get(path);
    //
    //   print(response.data);
    // });
    test('get', () async {
      TestApiService testApiService = TestApiService();
      final dioAdapter = DioAdapter(dio: testApiService.dio);

      dioAdapter.onGet("http://test.com", (server) {
        server.reply(200, {'message': 'Success!'});
      });

      var ret = await testApiService.get();
      expect(ret, ret is TestResponse);
    });
  });
}

class TestApiService extends ApiService<TestResponse> {
  get() async {
    return await requestGet();
  }

  @override
  DioRequest get request => DioRequest(
        DioBuilder.json(
          baseUrl: "http://test.com",
          enableLogging: true,
        ),
      );

  @override
  TestResponse? fromJson(json) {
    return TestResponse.fromJson(json);
  }
}

class TestResponse extends IDto {
  final String message;

  TestResponse({
    required this.message,
  });

  factory TestResponse.fromJson(json) {
    return TestResponse(message: json['message']);
  }

  Map<String, dynamic> get toJson => {
        'message': message,
      };
}

class TestApiHttpClientAdapter extends HttpClientAdapter {
  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(RequestOptions options,
      Stream<Uint8List>? requestStream, Future? cancelFuture) async {
    var ret = {'message': "This is test response."};
    return ResponseBody.fromBytes(utf8.encode(jsonEncode(ret)), 200);
  }
}
