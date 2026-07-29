import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:handmade_crafts/features/auth/domain/usecases/login_usecase.dart';
import 'package:handmade_crafts/features/auth/domain/usecases/register_usecase.dart';
import 'package:handmade_crafts/features/auth/domain/usecases/logout_usecase.dart';
import 'package:handmade_crafts/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:handmade_crafts/features/auth/domain/usecases/update_profile_usecase.dart';
import 'package:handmade_crafts/features/auth/data/repositories/auth_repository.dart';
import 'package:handmade_crafts/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:handmade_crafts/features/auth/data/models/auth_hive_model.dart';

// Mocks
class MockAuthRepository extends Mock implements AuthRepository {}
class MockAuthLocalDatasource extends Mock implements AuthLocalDatasource {}

void main() {
  group('Auth Use Cases Tests', () {
    late LoginUseCase loginUseCase;
    late RegisterUseCase registerUseCase;
    late LogoutUseCase logoutUseCase;
    late GetCurrentUserUseCase getCurrentUserUseCase;
    late UpdateProfileUseCase updateProfileUseCase;
    late MockAuthRepository mockAuthRepository;
    late MockAuthLocalDatasource mockAuthLocalDatasource;

    final testUser = AuthHiveModel(
      authId: '123',
      email: 'test@test.com',
      password: 'password123',
      fullName: 'Test User',
      username: 'testuser',
      phoneNumber: '+1234567890',
    );

    setUp(() {
      mockAuthRepository = MockAuthRepository();
      mockAuthLocalDatasource = MockAuthLocalDatasource();
      loginUseCase = LoginUseCase(repository: mockAuthRepository);
      registerUseCase = RegisterUseCase(repository: mockAuthRepository);
      logoutUseCase = LogoutUseCase(repository: mockAuthRepository);
      getCurrentUserUseCase = GetCurrentUserUseCase(localDatasource: mockAuthLocalDatasource);
      updateProfileUseCase = UpdateProfileUseCase(localDatasource: mockAuthLocalDatasource);
    });

    test('LoginUseCase returns user when login is successful', () async {
      when(() => mockAuthRepository.login('test@test.com', 'password123'))
          .thenAnswer((_) async => testUser);

      final result = await loginUseCase('test@test.com', 'password123');

      expect(result, testUser);
      verify(() => mockAuthRepository.login('test@test.com', 'password123')).called(1);
    });

    test('LoginUseCase returns null when login fails', () async {
      when(() => mockAuthRepository.login('wrong@test.com', 'wrongpass'))
          .thenAnswer((_) async => null);

      final result = await loginUseCase('wrong@test.com', 'wrongpass');

      expect(result, null);
      verify(() => mockAuthRepository.login('wrong@test.com', 'wrongpass')).called(1);
    });

    test('RegisterUseCase returns true when registration is successful', () async {
      when(() => mockAuthRepository.register(testUser, email: 'test@test.com'))
          .thenAnswer((_) async => true);

      final result = await registerUseCase(testUser, email: 'test@test.com');

      expect(result, true);
      verify(() => mockAuthRepository.register(testUser, email: 'test@test.com')).called(1);
    });

    test('LogoutUseCase calls repository logout', () async {
      when(() => mockAuthRepository.logout()).thenAnswer((_) async {});

      await logoutUseCase();

      verify(() => mockAuthRepository.logout()).called(1);
    });

    test('GetCurrentUserUseCase returns user when available', () async {
      when(() => mockAuthLocalDatasource.getCurrentUser())
          .thenAnswer((_) async => testUser);

      final result = await getCurrentUserUseCase();

      expect(result, testUser);
      verify(() => mockAuthLocalDatasource.getCurrentUser()).called(1);
    });

    test('UpdateProfileUseCase returns true when update is successful', () async {
      when(() => mockAuthLocalDatasource.updateUser(testUser))
          .thenAnswer((_) async => true);

      final result = await updateProfileUseCase(testUser);

      expect(result, true);
      verify(() => mockAuthLocalDatasource.updateUser(testUser)).called(1);
    });
  });
}
