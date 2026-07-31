import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:handmade_crafts/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:handmade_crafts/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:handmade_crafts/features/auth/data/repositories/auth_repository.dart';
import 'package:handmade_crafts/features/auth/data/models/auth_hive_model.dart';

class MockAuthLocalDatasource extends Mock implements AuthLocalDatasource {}

class MockAuthRemoteDatasource extends Mock implements AuthRemoteDatasource {}

void main() {
  late AuthRepository repository;
  late MockAuthLocalDatasource mockLocal;
  late MockAuthRemoteDatasource mockRemote;
  late AsyncValue<bool> connectivityOnline;
  late AsyncValue<bool> connectivityOffline;

  final testUser = AuthHiveModel(
    authId: '123',
    email: 'test@test.com',
    password: 'password123',
    fullName: 'Test User',
    username: 'testuser',
    phoneNumber: '+1234567890',
  );

  setUpAll(() {
    registerFallbackValue(testUser);
  });

  setUp(() {
    mockLocal = MockAuthLocalDatasource();
    mockRemote = MockAuthRemoteDatasource();
    connectivityOnline = const AsyncValue.data(true);
    connectivityOffline = const AsyncValue.data(false);
  });

  group('AuthRepository Tests', () {
    test('register online success stores remotely and locally', () async {
      repository = AuthRepository(
        localDatasource: mockLocal,
        remoteDatasource: mockRemote,
        connectivity: connectivityOnline,
      );

      when(() => mockRemote.register(testUser)).thenAnswer((_) async => true);
      when(() => mockLocal.register(testUser)).thenAnswer((_) async => true);

      final result = await repository.register(
        testUser,
        email: 'test@test.com',
      );

      expect(result, true);
      verify(() => mockRemote.register(testUser)).called(1);
      verify(() => mockLocal.register(testUser)).called(1);
    });

    test('register online failure returns false', () async {
      repository = AuthRepository(
        localDatasource: mockLocal,
        remoteDatasource: mockRemote,
        connectivity: connectivityOnline,
      );

      when(() => mockRemote.register(testUser)).thenAnswer((_) async => false);
      // Don't mock local register since it shouldn't be called

      final result = await repository.register(
        testUser,
        email: 'test@test.com',
      );

      expect(result, false);
      verify(() => mockRemote.register(testUser)).called(1);
      verifyNever(() => mockLocal.register(any()));
    });

    test('register offline stores locally only', () async {
      repository = AuthRepository(
        localDatasource: mockLocal,
        remoteDatasource: mockRemote,
        connectivity: connectivityOffline,
      );

      when(() => mockLocal.register(testUser)).thenAnswer((_) async => true);

      final result = await repository.register(
        testUser,
        email: 'test@test.com',
      );

      expect(result, true);
      verify(() => mockLocal.register(testUser)).called(1);
      verifyNever(() => mockRemote.register(any()));
    });

    test('login online with remote success returns remote user', () async {
      repository = AuthRepository(
        localDatasource: mockLocal,
        remoteDatasource: mockRemote,
        connectivity: connectivityOnline,
      );

      when(
        () => mockRemote.login('test@test.com', 'password123'),
      ).thenAnswer((_) async => testUser);
      when(() => mockLocal.register(testUser)).thenAnswer((_) async => true);

      final result = await repository.login('test@test.com', 'password123');

      expect(result, testUser);
      verify(() => mockRemote.login('test@test.com', 'password123')).called(1);
      verify(() => mockLocal.register(testUser)).called(1);
    });

    test('login online with remote failure falls back to local', () async {
      repository = AuthRepository(
        localDatasource: mockLocal,
        remoteDatasource: mockRemote,
        connectivity: connectivityOnline,
      );

      when(
        () => mockRemote.login('test@test.com', 'password123'),
      ).thenAnswer((_) async => null);
      when(
        () => mockLocal.login('test@test.com', 'password123'),
      ).thenAnswer((_) async => testUser);

      final result = await repository.login('test@test.com', 'password123');

      expect(result, testUser);
      verify(() => mockRemote.login('test@test.com', 'password123')).called(1);
      verify(() => mockLocal.login('test@test.com', 'password123')).called(1);
    });

    test('login offline uses local datasource only', () async {
      repository = AuthRepository(
        localDatasource: mockLocal,
        remoteDatasource: mockRemote,
        connectivity: connectivityOffline,
      );

      when(
        () => mockLocal.login('test@test.com', 'password123'),
      ).thenAnswer((_) async => testUser);

      final result = await repository.login('test@test.com', 'password123');

      expect(result, testUser);
      verify(() => mockLocal.login('test@test.com', 'password123')).called(1);
      verifyNever(() => mockRemote.login(any(), any()));
    });

    test('logout calls local logout only', () async {
      repository = AuthRepository(
        localDatasource: mockLocal,
        remoteDatasource: mockRemote,
        connectivity: connectivityOnline,
      );

      when(() => mockLocal.logout()).thenAnswer((_) async => true);

      await repository.logout();

      verify(() => mockLocal.logout()).called(1);
      verifyNever(() => mockRemote.register(any()));
    });
  });
}
