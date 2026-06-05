import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/hive/hive_service.dart';

final hiveServiceProvider = Provider<HiveService>((ref) {
  throw UnimplementedError('hiveServiceProvider must be overridden');
});
