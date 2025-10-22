import 'package:dio/dio.dart';

class NetworkManager {
  late Dio _dio;

  NetworkManager() {
    _dio = Dio();

    // Menambahkan interceptor untuk memonitor request dan response
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('Request: ${options.method} ${options.uri}');
        print('Headers: ${options.headers}');
        print('Body: ${options.data}');
        return handler.next(options);  // Melanjutkan request
      },
      onResponse: (response, handler) {
        print('Response: ${response.statusCode} ${response.requestOptions.uri}');
        print('Response Body: ${response.data}');
        return handler.next(response);  // Melanjutkan response
      },
      onError: (DioException e, handler) {
        print('Error: ${e.message}');
        if (e.response != null) {
          print('Error Response: ${e.response?.statusCode} ${e.response?.data}');
        }
        return handler.next(e);  // Melanjutkan error
      },
    ));
  }

  // Fungsi untuk melakukan GET request
  Future<void> getData() async {
    try {
      final response = await _dio.get('https://jsonplaceholder.typicode.com/posts');
      print('GET Response: ${response.statusCode} ${response.data}');
    } catch (error) {
      print('Error during GET request: $error');
    }
  }

  // Fungsi untuk melakukan POST request
  Future<void> postData(Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        'https://jsonplaceholder.typicode.com/posts',
        data: data,
      );
      print('POST Response: ${response.statusCode} ${response.data}');
    } catch (error) {
      print('Error during POST request: $error');
    }
  }
}