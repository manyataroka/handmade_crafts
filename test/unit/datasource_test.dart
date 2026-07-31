// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:handmade_crafts/features/auth/data/datasources/local/auth_local_datasource.dart';
// import 'package:handmade_crafts/features/auth/data/models/auth_hive_model.dart';
// import 'package:handmade_crafts/core/services/hive/hive_service.dart';
// import 'package:handmade_crafts/core/services/storage/user_session_service.dart';

// class MockHiveService extends Mock implements HiveService {}

// class MockUserSessionService extends Mock implements UserSessionService {}

// void main() {
//   group('AuthLocalDatasource Tests', () {
//     late AuthLocalDatasource datasource;
//     late MockHiveService mockHiveService;
//     late MockUserSessionService mockUserSessionService;

//     final testUser = AuthHiveModel(
//       authId: '123',
//       email: 'test@test.com',
//       password: 'password123',
//       fullName: 'Test User',
//       username: 'testuser',
//       phoneNumber: '+1234567890',
//     );

//     setUp(() {
//       mockHiveService = MockHiveService();
//       mockUserSessionService = MockUserSessionService();
//       datasource = AuthLocalDatasource(
//         hiveService: mockHiveService,
//         userSessionService: mockUserSessionService,
//       );
//     });

//     test('register returns true on success', () async {
//       when(() => mockHiveService.register(testUser)).thenAnswer((_) async {});

//       final result = await datasource.register(testUser);

//       expect(result, true);
//       verify(() => mockHiveService.register(testUser)).called(1);
//     });

//     test('register returns false on exception', () async {
//       when(
//         () => mockHiveService.register(testUser),
//       ).thenThrow(Exception('Storage error'));

//       final result = await datasource.register(testUser);

//       expect(result, false);
//     });

//     test('login returns user on success and saves session', () async {
//       when(
//         () => mockHiveService.login('test@test.com', 'password123'),
//       ).thenReturn(testUser);
//       when(
//         () => mockUserSessionService.saveUserSession(
//           userId: any(named: 'userId'),
//           email: any(named: 'email'),
//           fullName: any(named: 'fullName'),
//           username: any(named: 'username'),
//           phoneNumber: any(named: 'phoneNumber'),
//           batchId: any(named: 'batchId'),
//           profilePicture: any(named: 'profilePicture'),
//         ),
//       ).thenAnswer((_) async {});

//       final result = await datasource.login('test@test.com', 'password123');

//       expect(result, testUser);
//       verify(
//         () => mockHiveService.login('test@test.com', 'password123'),
//       ).called(1);
//       verify(
//         () => mockUserSessionService.saveUserSession(
//           userId: testUser.authId,
//           email: testUser.email,
//           fullName: testUser.fullName,
//           username: testUser.username,
//           phoneNumber: testUser.phoneNumber,
//           batchId: any(named: 'batchId'),
//           profilePicture: any(named: 'profilePicture'),
//         ),
//       ).called(1);
//     });

//     test('login returns null when hive login returns null', () async {
//       when(
//         () => mockHiveService.login('unknown@test.com', 'wrong'),
//       ).thenReturn(null);

//       final result = await datasource.login('unknown@test.com', 'wrong');

//       expect(result, null);
//       verifyNever(
//         () => mockUserSessionService.saveUserSession(
//           userId: any(named: 'userId'),
//           email: any(named: 'email'),
//           fullName: any(named: 'fullName'),
//           username: any(named: 'username'),
//           phoneNumber: any(named: 'phoneNumber'),
//           batchId: any(named: 'batchId'),
//           profilePicture: any(named: 'profilePicture'),
//         ),
//       );
//     });

//     test('login returns null on exception', () async {
//       when(
//         () => mockHiveService.login('test@test.com', 'password123'),
//       ).thenThrow(Exception('DB error'));

//       final result = await datasource.login('test@test.com', 'password123');

//       expect(result, null);
//     });

//     test('getCurrentUser returns user when logged in', () async {
//       when(() => mockUserSessionService.isLoggedIn()).thenReturn(true);
//       when(() => mockUserSessionService.getCurrentUserId()).thenReturn('123');
//       when(() => mockHiveService.getUserById('123')).thenReturn(testUser);

//       final result = await datasource.getCurrentUser();

//       expect(result, testUser);
//       verify(() => mockUserSessionService.isLoggedIn()).called(1);
//       verify(() => mockUserSessionService.getCurrentUserId()).called(1);
//       verify(() => mockHiveService.getUserById('123')).called(1);
//     });

//     test('getCurrentUser returns null when not logged in', () async {
//       when(() => mockUserSessionService.isLoggedIn()).thenReturn(false);

//       final result = await datasource.getCurrentUser();

//       expect(result, null);
//       verifyNever(() => mockUserSessionService.getCurrentUserId());
//       verifyNever(() => mockHiveService.getUserById(any()));
//     });

//     test('logout calls clearSession', () async {
//       when(
//         () => mockUserSessionService.clearSession(),
//       ).thenAnswer((_) async => true);

//       final result = await datasource.logout();

//       expect(result, true);
//       verify(() => mockUserSessionService.clearSession()).called(1);
//     });

//     test('getUserById returns user from hive', () async {
//       when(() => mockHiveService.getUserById('123')).thenReturn(testUser);

//       final result = await datasource.getUserById('123');

//       expect(result, testUser);
//     });

//     test('getUserByEmail returns user from hive', () async {
//       when(
//         () => mockHiveService.getUserByEmail('test@test.com'),
//       ).thenReturn(testUser);

//       final result = await datasource.getUserByEmail('test@test.com');

//       expect(result, testUser);
//     });

//     test('updateUser returns true on success', () async {
//       when(
//         () => mockHiveService.updateUser(testUser),
//       ).thenAnswer((_) async => true);

//       final result = await datasource.updateUser(testUser);

//       expect(result, true);
//     });

//     test('deleteUser returns true on success', () async {
//       when(() => mockHiveService.deleteUser('123')).thenAnswer((_) async {});

//       final result = await datasource.deleteUser('123');

//       expect(result, true);
//     });
//   });
// }
