import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/auth_hive_model.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/update_profile_usecase.dart';

enum AuthState { initial, loading, authenticated, unauthenticated, error }

class AuthViewModel extends StateNotifier<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final UpdateProfileUseCase updateProfileUseCase;

  AuthViewModel({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
    required this.updateProfileUseCase,
  }) : super(AuthState.initial);

  AuthHiveModel? currentUser;
  String? errorMessage;

  Future<void> login(String email, String password) async {
    state = AuthState.loading;
    errorMessage = null;
    try {
      final user = await loginUseCase(email, password);
      if (user != null) {
        currentUser = user;
        state = AuthState.authenticated;
      } else {
        errorMessage = 'Invalid email or password';
        state = AuthState.error;
      }
    } catch (e) {
      errorMessage = e.toString();
      state = AuthState.error;
    }
  }

  Future<void> register(AuthHiveModel user, {required String email}) async {
    state = AuthState.loading;
    errorMessage = null;
    try {
      final success = await registerUseCase(user, email: email);
      if (success) {
        state = AuthState.unauthenticated;
      } else {
        errorMessage = 'Registration failed';
        state = AuthState.error;
      }
    } catch (e) {
      errorMessage = e.toString();
      state = AuthState.error;
    }
  }

  Future<void> logout() async {
    state = AuthState.loading;
    errorMessage = null;
    try {
      await logoutUseCase();
      currentUser = null;
      state = AuthState.unauthenticated;
    } catch (e) {
      errorMessage = e.toString();
      state = AuthState.error;
    }
  }

  Future<void> checkCurrentUser() async {
    state = AuthState.loading;
    errorMessage = null;
    try {
      final user = await getCurrentUserUseCase();
      if (user != null) {
        currentUser = user;
        state = AuthState.authenticated;
      } else {
        state = AuthState.unauthenticated;
      }
    } catch (e) {
      errorMessage = e.toString();
      state = AuthState.error;
    }
  }

  Future<void> updateProfile(AuthHiveModel user) async {
    state = AuthState.loading;
    errorMessage = null;
    try {
      final success = await updateProfileUseCase(user);
      if (success) {
        currentUser = user;
        state = AuthState.authenticated;
      } else {
        errorMessage = 'Update failed';
        state = AuthState.error;
      }
    } catch (e) {
      errorMessage = e.toString();
      state = AuthState.error;
    }
  }
}
