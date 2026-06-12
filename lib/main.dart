import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:handmade_crafts/app/app.dart';
import 'package:handmade_crafts/core/data/database/local_hive_database.dart';
import 'package:handmade_crafts/core/providers/hive_service_provider.dart';
import 'package:handmade_crafts/core/providers/shared_prefs_provider.dart';
import 'package:handmade_crafts/core/providers/user_session_provider.dart';
import 'package:handmade_crafts/core/services/hive/hive_service.dart';
import 'package:handmade_crafts/core/services/storage/storage_service.dart';
import 'package:handmade_crafts/core/services/storage/user_session_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Global error handlers so runtime exceptions print to console instead of
  // failing silently with a blank/black screen.
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };

  await runZonedGuarded(
    () async {
      // Load environment variables from .env (if present).
      await dotenv.load(fileName: '.env');
      await LocalHiveDatabase.init();
      await HiveService.init();

      final sharedPreferences = await SharedPreferences.getInstance();
      final storageService = StorageService(prefs: sharedPreferences);
      final userSessionService = UserSessionService(
        storageService: storageService,
      );

      runApp(
        ProviderScope(
          overrides: [
            storageServiceProvider.overrideWithValue(storageService),
            userSessionServiceProvider.overrideWithValue(userSessionService),
            hiveServiceProvider.overrideWithValue(HiveService()),
          ],
          child: const App(),
        ),
      );
    },
    (error, stack) {
      // Print any uncaught errors during initialization or runtime.
      // The verbose logs will appear in the `flutter run` console.
      print('Uncaught error: $error');
      print(stack);
    },
  );
}
