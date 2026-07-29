import '../../data/models/auth_hive_model.dart';
import '../../data/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  Future<bool> call(AuthHiveModel user, {required String email}) async {
    return await repository.register(user, email: email);
  }
}
