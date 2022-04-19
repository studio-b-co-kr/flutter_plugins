import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

export 'package:dio/dio.dart';

part 'restful_api/api_service.dart';
part 'restful_api/auth_interceptor.dart';
part 'restful_api/dio_builder.dart';
part 'restful_api/dio_request.dart';
part 'restful_api/http_error.dart';
part 'restful_api/i_dto.dart';

Map<String, Uri> _baseUrls = {};

class RemediNet {
  // provide some key
  static const String keyBaseUrl = 'key_base_url';
  static const String keyBaseWebUrl = 'key_base_web_url';

  static setBaseUrls(Map<String, String> urls) {
    urls.forEach((key, value) {
      try {
        var uri = Uri.parse(value);
        if (!uri.isAbsolute) {
          throw Exception('this uri is not valid\n${uri.toString()}');
        }
        _baseUrls.addAll({key: uri});
      } catch (e) {
        assert(false);
      }
    });
  }

  static Uri url(String key) {
    var uri = _baseUrls[key];
    return uri!;
  }
}
