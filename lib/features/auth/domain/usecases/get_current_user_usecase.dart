import '../../data/datasources/local/auth_local_datasource.dart';
import '../../data/models/auth_hive_model.dart';

class GetCurrentUserUseCase {
  final AuthLocalDatasource localDatasource;

  GetCurrentUserUseCase({required this.localDatasource});

  Future<AuthHiveModel?> call() async {
    return await localDatasource.getCurrentUser();
  }
}
