import 'dart:ui';
import 'package:dio/dio.dart';

class NetworkLog {
  final String id;
  final String url;
  final String method;
  final dynamic requestData;
  dynamic responseData;
  int? statusCode;
  DateTime requestTime;
  DateTime? responseTime;

  NetworkLog({
    required this.id,
    required this.url,
    required this.method,
    required this.requestData,
    required this.requestTime,
    this.responseData,
    this.statusCode,
    this.responseTime,
  });
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
    final id = DateTime.now().microsecondsSinceEpoch.toString();

    options.extra['log_id'] = id;

    final log = NetworkLog(
      id: id,
      url: options.uri.toString(),
      method: options.method,
      requestData: options.data,
      requestTime: DateTime.now(),
    );

    NetworkLogger().addLog(log);

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final logId = response.requestOptions.extra['log_id'];
    final logs = NetworkLogger().logs;

    NetworkLog? log;
    try {
      log = logs.firstWhere((l) => l.id == logId);
    } catch (_) {
      log = null;
    }

    if (log != null) {
      log.responseData = response.data;
      log.statusCode = response.statusCode;
      log.responseTime = DateTime.now();
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final logId = err.requestOptions.extra['log_id'];
    final logs = NetworkLogger().logs;

    NetworkLog? log;
    try {
      log = logs.firstWhere((l) => l.id == logId);
    } catch (_) {
      log = null;
    }

    if (log != null) {
      log.responseData = err.message;
      log.statusCode = err.response?.statusCode;
      log.responseTime = DateTime.now();
    }

    super.onError(err, handler);
  }
}
