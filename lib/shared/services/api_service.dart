import 'package:dio/dio.dart';
import '../../core/errors/app_exception.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://your-api-base-url.com',
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  ApiService() {
    _dio.interceptors.add(LogInterceptor(responseBody: true));
  }

  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  Future<dynamic> post(String path, dynamic data) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } on DioException catch (e) {
      _handleError(e);
    }
  }

  void _handleError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw FetchDataException('Connection timeout', e.requestOptions.path);
      case DioExceptionType.badResponse:
        switch (e.response?.statusCode) {
          case 400:
            throw BadRequestException(e.response?.statusMessage, e.requestOptions.path);
          case 401:
          case 403:
            throw UnauthorizedException(e.response?.statusMessage, e.requestOptions.path);
          case 404:
            throw NotFoundException(e.response?.statusMessage, e.requestOptions.path);
          case 500:
            throw FetchDataException('Server error', e.requestOptions.path);
        }
        break;
      default:
        throw FetchDataException('Network error occurred', e.requestOptions.path);
    }
  }
}
