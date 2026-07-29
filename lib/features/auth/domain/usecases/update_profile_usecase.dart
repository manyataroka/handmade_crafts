import '../../data/datasources/local/auth_local_datasource.dart';
import '../../data/models/auth_hive_model.dart';

class UpdateProfileUseCase {
  final AuthLocalDatasource localDatasource;

  UpdateProfileUseCase({required this.localDatasource});

  Future<bool> call(AuthHiveModel user) async {
    return await localDatasource.updateUser(user);
  }
}
