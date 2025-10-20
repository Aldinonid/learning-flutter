import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_module_1/core/constants/api_constants.dart';

class AuthRepository {
  final Dio _dio = Dio();  // Inisialisasi Dio

  AuthRepository() {
    // Tambahkan interceptor untuk log request dan response
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('Request: ${options.method} ${options.uri}');
        print('Headers: ${options.headers}');
        print('Body: ${options.data}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        print('Response: ${response.statusCode} ${response.requestOptions.uri}');
        print('Response Body: ${response.data}');
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        print('Error: ${e.message}');
        if (e.response != null) {
          print('Error Response: ${e.response?.statusCode} ${e.response?.data}');
        }
        return handler.next(e);
      },
    ));
  }

  // Fungsi login
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        ApiConstants.baseUrl + ApiConstants.login,
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      // Jika berhasil, kembalikan data response
      return response.data;
    } catch (e) {
      // Tangani error jika terjadi
      if (e is DioError) {
        throw Exception('Gagal login: ${e.response?.data ?? e.message}');
      }
      rethrow;  // Rethrow error jika bukan DioError
    }
  }
}
