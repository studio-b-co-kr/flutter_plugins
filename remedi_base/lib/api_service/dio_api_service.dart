import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:remedi_base/remedi_base.dart';
import 'dart:developer' as dev;

/// Post Api
abstract class DioPostApiService<R extends IDto> extends IApiService<Dio, R>
    with _TransFormer<R> {
  final IDto? data;
  final Map<String, dynamic>? query;

  DioPostApiService(IClientFactory clientFactory, {this.data, this.query})
      : super(clientFactory);

  @override
  Future<R> request({Function(Response)? onSuccess,
    Function(dynamic)? onFail,
    Function(dynamic)? onError}) async {
    var res = await client.post<Map<String, dynamic>>(path,
        data: data?.toJson, queryParameters: query);
    return handleResponse(res,
        onSuccess: onSuccess, onError: onError, onFail: onFail);
  }
}

/// Get Api
abstract class DioGetApiService<R> extends IApiService<Dio, R>
    with _TransFormer<R> {
  final Map<String, dynamic>? query;

  DioGetApiService(IClientFactory clientFactory, {this.query})
      : super(clientFactory);

  @override
  Future<R> request({Function(Response)? onSuccess,
    Function(dynamic)? onFail,
    Function(dynamic)? onError}) async {
    var res;
    try {
      res = await client.get<dynamic>(path, queryParameters: query);
    } catch (e) {}
    return handleResponse(res,
        onSuccess: onSuccess, onError: onError, onFail: onFail);
  }
}

/// Patch Api
abstract class DioPatchApiService<R extends IDto> extends IApiService<Dio, R>
    with _TransFormer<R> {
  final IDto? data;
  final Map<String, dynamic>? query;

  DioPatchApiService(IClientFactory clientFactory, {this.data, this.query})
      : super(clientFactory);

  @override
  Future<R> request({Function(Response)? onSuccess,
    Function(dynamic)? onFail,
    Function(dynamic)? onError}) async {
    var res = await client.patch<Map<String, dynamic>>(path,
        data: data?.toJson, queryParameters: query);
    return handleResponse(res,
        onSuccess: onSuccess, onError: onError, onFail: onFail);
  }
}

/// Delete Api
abstract class DioDeleteApiService<R extends IDto> extends IApiService<Dio, R>
    with _TransFormer<R> {
  final IDto? data;
  final Map<String, dynamic>? query;

  DioDeleteApiService(IClientFactory clientFactory, {this.data, this.query})
      : super(clientFactory);

  @override
  Future<R> request({Function(Response response)? onSuccess,
    Function(dynamic)? onFail,
    Function(dynamic)? onError}) async {
    var res = await client.delete<Map<String, dynamic>>(path,
        data: data?.toJson, queryParameters: query);
    return handleResponse(res,
        onSuccess: onSuccess, onError: onError, onFail: onFail);
  }
}

class File extends IDto {
  final String path;

  File({required this.path});

  @override
  Map<String, dynamic>? get toJson => null;
}

/// File Download Api
class FileDownloadApiService extends IApiService<Dio, File> {
  final url;
  final IDto? data;
  final String savePath;

  FileDownloadApiService(IClientFactory clientFactory,
      this.url,
      this.savePath, {
        this.data,
      }) : super(clientFactory);

  @override
  Future<File?> request({Function(Response response)? onSuccess,
    Function(dynamic)? onFail,
    Function(dynamic)? onError}) async {
    try {
      await client.download(url, savePath, data: data?.toJson);
      return File(path: savePath);
    } catch (error) {
      return null;
    }
  }

  @override
  String get path => "";
}

abstract class _TransFormer<R> {
  /// json should be map<string,dynamic> or int, string, bool
  R jsonTo(dynamic json);

  handleResponse(Response res, {
    Function(Response response)? onSuccess,
    Function(dynamic)? onFail,
    Function(dynamic)? onError,
  }) {
    if (res is DioError) {
      if (onFail != null) onFail(res);
      return null;
    }

    if (!"${res.statusCode}".startsWith("20")) {
      if (onError != null) onError(res);
      return null;
    }

    if (onSuccess != null) {
      onSuccess(res);
    }

    return jsonTo(res.data);
  }
}

class DioFactory extends IClientFactory<Dio> {
  final String baseUrl;
  final String? accessToken;
  final bool enableLogging;
  final String? userAgent;
  final String? appVersion;
  final List<Interceptor>? interceptors;

  // final bool enableFirebasePerformance;

  DioFactory._(this.baseUrl,
      {this.accessToken,
        this.enableLogging = false,
        this.userAgent,
        this.appVersion,
        this.interceptors})
      : super(baseUrl: baseUrl);

  factory DioFactory.auth(String baseUrl, String accessToken,
      {bool enableLogging = false,
        String? userAgent,
        String? appVersion,
        List<Interceptor>? interceptors}) =>
      DioFactory._(baseUrl,
          accessToken: accessToken,
          enableLogging: enableLogging,
          userAgent: userAgent,
          appVersion: appVersion,
          interceptors: interceptors);

  factory DioFactory.noneAuth(String baseUrl,
      {bool enableLogging = false,
        String? userAgent,
        String? appVersion,
        List<Interceptor>? interceptors}) =>
      DioFactory._(baseUrl,
          enableLogging: enableLogging,
          userAgent: userAgent,
          appVersion: appVersion,
          interceptors: interceptors);

  @override
  Dio build() {
    Dio http = Dio();
    http.options.baseUrl = baseUrl;
    http.transformer = FlutterTransformer();

    http.interceptors.add(LogInterceptor(
        requestBody: enableLogging,
        responseBody: enableLogging,
        requestHeader: enableLogging,
        responseHeader: enableLogging));

    http.interceptors
        .add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers['Accept'] = 'application/json';
      if (accessToken != null)
        options.headers["Authorization"] = "Bearer $accessToken";
      if (userAgent != null) options.headers['User-Agent'] = userAgent;
      if (appVersion != null) options.headers['App-Version'] = appVersion;
      // return options;
    }, onResponse: (Response<dynamic> response, handler) {
      dev.log("onResponse", name: "DIO");
    }, onError: (DioError error, handler) {
      dev.log("onError", name: "DIO");
    }));

    interceptors?.map((interceptor) {
      http.interceptors.add(interceptor);
    });

    return http;
  }
}

class FlutterTransformer extends DefaultTransformer {
  FlutterTransformer() : super(jsonDecodeCallback: _parseJson);
}

// Must be top-level function
_parseAndDecode(String response) {
  return jsonDecode(response);
}

_parseJson(String text) {
  return compute(_parseAndDecode, text);
}
