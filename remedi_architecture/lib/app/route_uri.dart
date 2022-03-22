part of 'app.dart';

class RouteUri {
  final String authority;
  final String path;
  final Map<String, dynamic>? data;

  const RouteUri({
    required this.authority,
    required this.path,
    this.data,
  });

  static RouteUri? _fromSettings(RouteSettings settings) {
    if (settings.name == null) {
      return null;
    }
    Uri uri = Uri.parse(settings.name!);

    Map<String, dynamic>? data;
    if (settings.arguments != null) {}
    return RouteUri(authority: uri.authority, path: uri.path, data: data);
  }

  String get name {
    Uri _uri = uri;
    return _uri.scheme + '://' + _uri.authority + _uri.path;
  }

  Uri get uri => Uri.https(authority, path, data);
}
