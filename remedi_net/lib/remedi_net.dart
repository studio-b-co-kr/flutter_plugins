export 'package:dio/dio.dart';
export 'package:remedi_net/restful_api/remedi_restful_api.dart';

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
