import 'package:dio/dio.dart';
import 'package:flutter_module_1/core/constants/api_constants.dart';
import 'package:flutter_module_1/core/network/network_logger.dart';

class AuthRepository {
  final Dio _dio = Dio()..interceptors.add(NetworkLoggerInterceptor());  // Inisialisasi Dio

  // Fungsi login
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}/c/b205-9b70-4a7b-8fb2',
        data: {
          'username': username,
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
      if (e is DioException) {
        throw Exception('Gagal login: ${e.response?.data ?? e.message}');
      }
      rethrow;  // Rethrow error jika bukan DioError
    }
  }
}
