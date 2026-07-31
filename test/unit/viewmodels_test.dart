// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:handmade_crafts/features/auth/domain/usecases/login_usecase.dart';
// import 'package:handmade_crafts/features/auth/domain/usecases/register_usecase.dart';
// import 'package:handmade_crafts/features/auth/domain/usecases/logout_usecase.dart';
// import 'package:handmade_crafts/features/auth/domain/usecases/get_current_user_usecase.dart';
// import 'package:handmade_crafts/features/auth/domain/usecases/update_profile_usecase.dart';
// import 'package:handmade_crafts/features/auth/presentation/viewmodel/auth_viewmodel.dart';
// import 'package:handmade_crafts/features/onboarding/presentation/viewmodel/onboarding_viewmodel.dart';
// import 'package:handmade_crafts/features/splash/presentation/viewmodel/splash_viewmodel.dart';
// import 'package:handmade_crafts/features/dashboard/presentation/viewmodel/dashboard_viewmodel.dart';
// import 'package:handmade_crafts/features/dashboard/presentation/viewmodel/profile_viewmodel.dart';
// import 'package:handmade_crafts/features/auth/data/models/auth_hive_model.dart';

// // Mocks
// class MockLoginUseCase extends Mock implements LoginUseCase {}
// class MockRegisterUseCase extends Mock implements RegisterUseCase {}
// class MockLogoutUseCase extends Mock implements LogoutUseCase {}
// class MockGetCurrentUserUseCase extends Mock implements GetCurrentUserUseCase {}
// class MockUpdateProfileUseCase extends Mock implements UpdateProfileUseCase {}

// void main() {
//   group('ViewModel Tests', () {
//     late AuthViewModel authViewModel;
//     late MockLoginUseCase mockLoginUseCase;
//     late MockRegisterUseCase mockRegisterUseCase;
//     late MockLogoutUseCase mockLogoutUseCase;
//     late MockGetCurrentUserUseCase mockGetCurrentUserUseCase;
//     late MockUpdateProfileUseCase mockUpdateProfileUseCase;
//     late OnboardingViewModel onboardingViewModel;
//     late SplashViewModel splashViewModel;
//     late DashboardViewModel dashboardViewModel;
//     late ProfileViewModel profileViewModel;

//     final testUser = AuthHiveModel(
//       authId: '123',
//       email: 'test@test.com',
//       password: 'password123',
//       fullName: 'Test User',
//       username: 'testuser',
//       phoneNumber: '+1234567890',
//     );

//     setUp(() {
//       mockLoginUseCase = MockLoginUseCase();
//       mockRegisterUseCase = MockRegisterUseCase();
//       mockLogoutUseCase = MockLogoutUseCase();
//       mockGetCurrentUserUseCase = MockGetCurrentUserUseCase();
//       mockUpdateProfileUseCase = MockUpdateProfileUseCase();
//       authViewModel = AuthViewModel(
//         loginUseCase: mockLoginUseCase,
//         registerUseCase: mockRegisterUseCase,
//         logoutUseCase: mockLogoutUseCase,
//         getCurrentUserUseCase: mockGetCurrentUserUseCase,
//         updateProfileUseCase: mockUpdateProfileUseCase,
//       );
//       onboardingViewModel = OnboardingViewModel();
//       splashViewModel = SplashViewModel();
//       dashboardViewModel = DashboardViewModel();
//       profileViewModel = ProfileViewModel();
//     });

//     group('AuthViewModel Tests', () {
//       test('initial state is AuthState.initial', () {
//         expect(authViewModel.state, AuthState.initial);
//       });

//       test('login transitions to loading then authenticated on success', () async {
//         when(() => mockLoginUseCase('test@test.com', 'password123'))
//             .thenAnswer((_) async => testUser);

//         expect(authViewModel.state, AuthState.initial);
//         final future = authViewModel.login('test@test.com', 'password123');
//         expect(authViewModel.state, AuthState.loading);
//         await future;
//         expect(authViewModel.state, AuthState.authenticated);
//         expect(authViewModel.currentUser, testUser);
//       });

//       test('login transitions to loading then error on failure', () async {
//         when(() => mockLoginUseCase('wrong@test.com', 'wrong'))
//             .thenAnswer((_) async => null);

//         expect(authViewModel.state, AuthState.initial);
//         final future = authViewModel.login('wrong@test.com', 'wrong');
//         expect(authViewModel.state, AuthState.loading);
//         await future;
//         expect(authViewModel.state, AuthState.error);
//       });
//     });

//     group('OnboardingViewModel Tests', () {
//       test('initial page is 0', () {
//         expect(onboardingViewModel.currentPage, 0);
//       });

//       test('setPage changes current page', () {
//         onboardingViewModel.setPage(2);
//         expect(onboardingViewModel.currentPage, 2);
//       });

//       test('nextPage increments current page', () {
//         onboardingViewModel.setPage(0);
//         onboardingViewModel.nextPage();
//         expect(onboardingViewModel.currentPage, 1);
//       });

//       test('isLastPage is true when on last page', () {
//         onboardingViewModel.setPage(2);
//         expect(onboardingViewModel.isLastPage, true);
//       });
//     });

//     group('SplashViewModel Tests', () {
//       test('initial state is SplashState.initial', () {
//         expect(splashViewModel.state, SplashState.initial);
//       });

//       test('startSplash transitions through states', () async {
//         expect(splashViewModel.state, SplashState.initial);
//         final future = splashViewModel.startSplash();
//         expect(splashViewModel.state, SplashState.loading);
//         await future;
//         expect(splashViewModel.state, SplashState.completed);
//       });
//     });

//     group('DashboardViewModel Tests', () {
//       test('initial tab is DashboardTab.home', () {
//         expect(dashboardViewModel.currentTab, DashboardTab.home);
//       });

//       test('setTab changes current tab', () {
//         dashboardViewModel.setTab(DashboardTab.cart);
//         expect(dashboardViewModel.currentTab, DashboardTab.cart);
//       });
//     });

//     group('ProfileViewModel Tests', () {
//       test('initial state is false', () {
//         expect(profileViewModel.state, false);
//       });
//     });
//   });
// }
