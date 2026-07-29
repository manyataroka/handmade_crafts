import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handmade_crafts/core/providers/api_client_provider.dart';
import 'package:handmade_crafts/features/auth/data/models/auth_hive_model.dart';

final authRemoteDatasourceProvider = Provider<AuthRemoteDatasource>((ref) {
  final api = ref.watch(apiClientProvider);
  return AuthRemoteDatasource(apiClient: api);
});

class AuthRemoteDatasource {
  final dynamic apiClient;

  AuthRemoteDatasource({required this.apiClient});

  /// Attempts to register on remote. Returns true on success.
  Future<bool> register(AuthHiveModel user) async {
    try {
      final data = user.toMap();
      await apiClient.post('/register', data: data);
      return true;
    } catch (_) {
      return false;
    }
  }

  /// Attempts remote login and returns an AuthHiveModel on success.
  Future<AuthHiveModel?> login(String email, String password) async {
    try {
      final resp = await apiClient.post(
        '/login',
        data: {'email': email, 'password': password},
      );
      if (resp is Map<String, dynamic>) {
        return AuthHiveModel.fromMap(resp);
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
