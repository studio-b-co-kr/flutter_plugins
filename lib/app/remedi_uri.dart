part of 'app.dart';

class RouteUri {
  final String name;
  final Map<String, dynamic> data;

  RouteUri(this.name, this.data);

  Uri get uri {
    return Uri(path: name, queryParameters: data);
  }

  String get routeName => name;
}
