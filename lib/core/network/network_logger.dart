import 'dart:ui';
import 'package:dio/dio.dart';

class NetworkLog {
  final String method;
  final String url;
  final int? statusCode;
  final String? requestBody;
  final String? responseBody;
  final DateTime timestamp;

  NetworkLog({
    required this.method,
    required this.url,
    this.statusCode,
    this.requestBody,
    this.responseBody,
  }) : timestamp = DateTime.now();
}

class NetworkLogger {
  static final NetworkLogger _instance = NetworkLogger._internal();
  factory NetworkLogger() => _instance;
  NetworkLogger._internal();

  final List<NetworkLog> _logs = [];
  final List<VoidCallback> _listeners = [];

  List<NetworkLog> get logs => List.unmodifiable(_logs);

  void addLog(NetworkLog log) {
    _logs.insert(0, log); // newest first
    for (final l in _listeners) {
      l();
    }
  }

  void clear() => _logs.clear();

  void addListener(VoidCallback listener) => _listeners.add(listener);
  void removeListener(VoidCallback listener) => _listeners.remove(listener);
}

class NetworkLoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    NetworkLogger().addLog(NetworkLog(
      method: options.method,
      url: options.uri.toString(),
      requestBody: options.data?.toString(),
    ));
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    NetworkLogger().addLog(NetworkLog(
      method: response.requestOptions.method,
      url: response.requestOptions.uri.toString(),
      statusCode: response.statusCode,
      responseBody: response.data.toString(),
    ));
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    NetworkLogger().addLog(NetworkLog(
      method: err.requestOptions.method,
      url: err.requestOptions.uri.toString(),
      statusCode: err.response?.statusCode,
      responseBody: err.response?.data?.toString(),
    ));
    handler.next(err);
  }
}
