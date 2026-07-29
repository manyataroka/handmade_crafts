// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:handmade_crafts/features/onboarding/presentation/pages/onboarding_view.dart';
// import 'package:handmade_crafts/features/splash/presentation/pages/splash_view.dart';
// import 'package:handmade_crafts/features/auth/presentation/pages/login_view.dart';
// import 'package:handmade_crafts/features/auth/presentation/pages/signup_view.dart';
// import 'package:handmade_crafts/features/dashboard/presentation/pages/dashboard_view.dart';
// import 'package:handmade_crafts/features/dashboard/presentation/pages/profile_view.dart';
// import 'package:handmade_crafts/features/auth/data/datasources/local/auth_local_datasource.dart';
// import 'package:handmade_crafts/features/auth/data/repositories/auth_repository.dart';
// import 'package:handmade_crafts/features/auth/data/models/auth_hive_model.dart';

// // Mocks
// class MockAuthLocalDatasource extends Mock implements AuthLocalDatasource {}
// class MockAuthRepository extends Mock implements AuthRepository {}

// void main() {
//   setUpAll(() {
//     registerFallbackValue(AuthHiveModel(
//       authId: '',
//       email: '',
//       password: '',
//       fullName: '',
//       username: '',
//       phoneNumber: '',
//     ));
//   });

//   group('Widget Tests', () {
//     testWidgets('SplashView shows logo and CraftyBee text',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(
//         ProviderScope(
//           child: MaterialApp(home: SplashView()),
//         ),
//       );

//       expect(find.byType(Image), findsWidgets);
//       expect(find.text('CraftyBee'), findsOneWidget);
//     });

//     testWidgets('OnboardingView shows first page initially',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(
//         ProviderScope(
//           child: MaterialApp(home: OnboardingView()),
//         ),
//       );

//       expect(find.text('Crafted with Love & Soul'), findsOneWidget);
//       expect(find.text('Continue'), findsOneWidget);
//     });

//     testWidgets('OnboardingView continues to next page when Continue is pressed',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(
//         ProviderScope(
//           child: MaterialApp(home: OnboardingView()),
//         ),
//       );

//       await tester.tap(find.text('Continue'));
//       await tester.pumpAndSettle();

//       expect(find.text('Support Local Creators'), findsOneWidget);
//     });

//     testWidgets('LoginView has email and password fields',
//         (WidgetTester tester) async {
//       final mockLocalDatasource = MockAuthLocalDatasource();
//       when(() => mockLocalDatasource.login(any(), any())).thenAnswer((_) async => null);

//       await tester.pumpWidget(
//         ProviderScope(
//           overrides: [
//             authLocalDatasourceProvider.overrideWith((ref) => mockLocalDatasource),
//           ],
//           child: MaterialApp(home: LoginView()),
//         ),
//       );

//       expect(find.widgetWithText(TextField, 'Email Address'), findsOneWidget);
//       expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
//       expect(find.text('LOGIN'), findsOneWidget);
//     });

//     testWidgets('LoginView shows error snackbar when fields are empty',
//         (WidgetTester tester) async {
//       final mockLocalDatasource = MockAuthLocalDatasource();
//       when(() => mockLocalDatasource.login(any(), any())).thenAnswer((_) async => null);

//       await tester.pumpWidget(
//         ProviderScope(
//           overrides: [
//             authLocalDatasourceProvider.overrideWith((ref) => mockLocalDatasource),
//           ],
//           child: MaterialApp(home: LoginView()),
//         ),
//       );

//       await tester.tap(find.text('LOGIN'));
//       await tester.pump();

//       expect(find.text('Please enter email and password'), findsOneWidget);
//     });

//     testWidgets('SignupView has username, email and password fields',
//         (WidgetTester tester) async {
//       final mockRepo = MockAuthRepository();
//       when(() => mockRepo.register(any(), email: any(named: 'email')))
//           .thenAnswer((_) async => true);

//       await tester.pumpWidget(
//         ProviderScope(
//           overrides: [
//             authRepositoryProvider.overrideWith((ref) => mockRepo),
//           ],
//           child: MaterialApp(home: SignupView()),
//         ),
//       );

//       expect(find.widgetWithText(TextField, 'Username'), findsOneWidget);
//       expect(find.widgetWithText(TextField, 'Email Address'), findsOneWidget);
//       expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
//       expect(find.widgetWithText(TextField, 'Confirm Password'), findsOneWidget);
//     });

//     testWidgets('SignupView shows error snackbar when fields are empty',
//         (WidgetTester tester) async {
//       final mockRepo = MockAuthRepository();
//       when(() => mockRepo.register(any(), email: any(named: 'email')))
//           .thenAnswer((_) async => true);

//       await tester.pumpWidget(
//         ProviderScope(
//           overrides: [
//             authRepositoryProvider.overrideWith((ref) => mockRepo),
//           ],
//           child: MaterialApp(home: SignupView()),
//         ),
//       );

//       await tester.tap(find.text('REGISTER'));
//       await tester.pump();

//       expect(find.text('Please fill all fields'), findsOneWidget);
//     });

//     testWidgets('DashboardScreenView shows bottom navigation bar',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(
//         ProviderScope(
//           child: MaterialApp(home: DashboardScreenView()),
//         ),
//       );

//       expect(find.byIcon(Icons.home_outlined), findsOneWidget);
//       expect(find.byIcon(Icons.menu), findsOneWidget);
//       expect(find.byIcon(Icons.shopping_cart_outlined), findsOneWidget);
//       expect(find.byIcon(Icons.person_outlined), findsOneWidget);
//     });

//     testWidgets('DashboardScreenView switches to Profile tab',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(
//         ProviderScope(
//           child: MaterialApp(home: DashboardScreenView()),
//         ),
//       );

//       await tester.tap(find.byIcon(Icons.person_outlined));
//       await tester.pumpAndSettle();

//       expect(find.text('Profile'), findsOneWidget);
//     });

//     testWidgets('ProfileView shows Log out button',
//         (WidgetTester tester) async {
//       await tester.pumpWidget(
//         ProviderScope(
//           child: MaterialApp(home: ProfileScreen()),
//         ),
//       );

//       expect(find.text('Log out'), findsOneWidget);
//       expect(find.text('Favorites'), findsOneWidget);
//     });
//   });
// }
