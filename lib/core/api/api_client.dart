import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiClient {
  final Dio _dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  ApiClient({required String baseUrl})
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            contentType: 'application/json',
          ),
        ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Attach token to every request if available
          final token = await _storage.read(key: 'auth_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        },
      ),
    );
  }

  // ───── Token helpers ─────
  Future<void> saveToken(String token) async {
    await _storage.write(key: 'auth_token', value: token);
  }

  Future<void> clearToken() async {
    await _storage.delete(key: 'auth_token');
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  // ───── GET ─────
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final resp = await _dio.get(path, queryParameters: queryParameters);
      return resp.data;
    } on DioException catch (e) {
      throw _wrapDioError(e);
    }
  }

  // ───── POST ─────
  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final resp = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return resp.data;
    } on DioException catch (e) {
      throw _wrapDioError(e);
    }
  }

  // ───── PUT ─────
  Future<dynamic> put(
    String path, {
    dynamic data,
  }) async {
    try {
      final resp = await _dio.put(path, data: data);
      return resp.data;
    } on DioException catch (e) {
      throw _wrapDioError(e);
    }
  }

  // ───── DELETE ─────
  Future<dynamic> delete(String path) async {
    try {
      final resp = await _dio.delete(path);
      return resp.data;
    } on DioException catch (e) {
      throw _wrapDioError(e);
    }
  }

  // ───── Error wrapper ─────
  Exception _wrapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timed out. Check your internet.');

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        final message = e.response?.data?['message'] ?? e.response?.statusMessage;
        return Exception(message ?? 'Request failed: $statusCode');

      case DioExceptionType.connectionError:
        return Exception('No internet connection.');

      case DioExceptionType.cancel:
        return Exception('Request was cancelled.');

      default:
        return Exception(e.message ?? 'Something went wrong.');
    }
  }
}