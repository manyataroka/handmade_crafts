// import 'dart:async';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// enum SplashState { initial, loading, completed }

// class SplashViewModel extends StateNotifier<SplashState> {
//   SplashViewModel() : super(SplashState.initial);

//   Future<void> startSplash() async {
//     state = SplashState.loading;
//     await Future.delayed(const Duration(seconds: 2));
//     state = SplashState.completed;
//   }
// }
