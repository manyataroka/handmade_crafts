import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/storage/user_session_service.dart';

final userSessionServiceProvider = Provider<UserSessionService>((ref) {
  throw UnimplementedError('userSessionServiceProvider must be overridden');
});
