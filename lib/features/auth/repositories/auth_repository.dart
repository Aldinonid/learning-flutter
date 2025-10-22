import 'package:dio/dio.dart';
import 'package:flutter_module_1/core/constants/api_constants.dart';
import 'package:flutter_module_1/core/models/user_model.dart';
import 'package:flutter_module_1/core/network/network_logger.dart';

class AuthRepository {
  final Dio _dio = Dio()..interceptors.add(NetworkLoggerInterceptor());  // Inisialisasi Dio

  // Fungsi login
  Future<UserModel> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '${ApiConstants.baseUrl}/c/c664-4fae-4632-a98b',
        data: {
          'username': username,
          'password': password,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      // Jika berhasil, kembalikan data response
      return UserModel.fromJson(response.data);
    } catch (e) {
      // Tangani error jika terjadi
      if (e is DioException) {
        throw Exception('Gagal login: ${e.response?.data ?? e.message}');
      }
      rethrow;  // Rethrow error jika bukan DioError
    }
  }
}
