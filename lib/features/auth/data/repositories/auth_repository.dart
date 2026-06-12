import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:handmade_crafts/core/providers/connectivity_provider.dart';
import 'package:handmade_crafts/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:handmade_crafts/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:handmade_crafts/features/auth/data/models/auth_hive_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final local = ref.watch(authLocalDatasourceProvider);
  final remote = ref.watch(authRemoteDatasourceProvider);
  final conn = ref.watch(connectivityProvider);
  return AuthRepository(
    localDatasource: local,
    remoteDatasource: remote,
    connectivity: conn,
  );
});

class AuthRepository {
  final AuthLocalDatasource _local;
  final AuthRemoteDatasource _remote;
  final AsyncValue<bool> _connectivityStream;

  AuthRepository({
    required AuthLocalDatasource localDatasource,
    required AuthRemoteDatasource remoteDatasource,
    required AsyncValue<bool> connectivity,
  }) : _local = localDatasource,
       _remote = remoteDatasource,
       _connectivityStream = connectivity;

  Future<bool> register(AuthHiveModel user, {required String email}) async {
    final isOnline = _connectivityStream.valueOrNull ?? false;
    if (isOnline) {
      final remoteResult = await _remote.register(user);
      if (remoteResult) {
        // persist locally as a cache
        await _local.register(user);
        return true;
      }
      return false;
    } else {
      // offline: store locally and return true (will sync when online)
      await _local.register(user);
      return true;
    }
  }

  Future<AuthHiveModel?> login(String email, String password) async {
    final isOnline = _connectivityStream.valueOrNull ?? false;
    if (isOnline) {
      final remoteUser = await _remote.login(email, password);
      if (remoteUser != null) {
        // update local cache
        await _local.register(remoteUser);
        return remoteUser;
      }
      // fallback to local if remote fails
      return await _local.login(email, password);
    } else {
      return await _local.login(email, password);
    }
  }

  Future<void> logout() async {}

  Future<Object?> isLoggedIn() async {}
}
