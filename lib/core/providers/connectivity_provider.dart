import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Emits `true` when connectivity is available (wifi/cellular), `false` otherwise.
final connectivityProvider = StreamProvider<bool>((ref) {
  final connectivity = Connectivity();
  return connectivity.onConnectivityChanged.map(
    (result) => result != ConnectivityResult.none,
  );
});
