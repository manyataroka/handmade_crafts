import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:handmade_crafts/core/api/api_client.dart';

/// Reads `API_BASE_URL` from environment with a sensible fallback.
/// Update `.env` for different targets or set env vars per environment.
final apiBaseUrlProvider = Provider<String>((ref) {
  final envBase = dotenv.env['API_BASE_URL'];
  if (envBase != null && envBase.isNotEmpty) return envBase;
  // default for Android emulator
  return 'http://10.0.2.2:5000/';
});

final apiClientProvider = Provider<ApiClient>((ref) {
  final base = ref.watch(apiBaseUrlProvider);
  return ApiClient(baseUrl: base);
});
