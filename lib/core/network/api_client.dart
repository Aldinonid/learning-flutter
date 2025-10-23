import 'package:dio/dio.dart';
import 'package:flutter_module_1/core/constants/api_constants.dart';
import 'package:flutter_module_1/core/network/network_logger.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  final Dio dio;

  factory ApiClient() {
    return _instance;
  }
// .interceptors.add(NetworkLoggerInterceptor())
  ApiClient._internal() : dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl))..interceptors.add(NetworkLoggerInterceptor());

  Future<Response> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      // Tangani error Dio spesifik
      throw _handleDioError(e);
    } catch (e) {
      // Error lain
      throw Exception('Unexpected error: $e');
    }
  }

  Future<Response> post(
    String endpoint, {
    dynamic data,
    Options? options,
  }) async {
    try {
      final response = await dio.post(
        endpoint,
        data: data,
        options: options,
      );
      return response;
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Exception _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      return Exception('Connection Timeout');
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return Exception('Receive Timeout');
    } else if (e.type == DioExceptionType.badResponse) {
      // Misal API balikan error dengan kode tertentu
      final statusCode = e.response?.statusCode;
      final message = e.response?.statusMessage ?? 'Unknown error';
      return Exception('Error $statusCode: $message');
    } else if (e.type == DioExceptionType.cancel) {
      return Exception('Request was cancelled');
    } else {
      return Exception('Unexpected error: ${e.message}');
    }
  }
}