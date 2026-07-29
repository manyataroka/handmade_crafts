import '../../data/models/auth_hive_model.dart';
import '../../data/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  Future<AuthHiveModel?> call(String email, String password) async {
    return await repository.login(email, password);
  }
}
