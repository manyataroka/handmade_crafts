// import 'package:hive_flutter/hive_flutter.dart';

// import '../../../features/auth/data/models/auth_hive_model.dart';

// class HiveService {
//   static const String authBoxName = 'authBox';
//   static bool _initialized = false;

//   HiveService();

//   static Future<void> init() async {
//     if (_initialized) return;
//     await Hive.initFlutter();
//     if (!Hive.isBoxOpen(authBoxName)) {
//       await Hive.openBox(authBoxName);
//     }
//     _initialized = true;
//   }

//   Box get authBox => Hive.box(authBoxName);

//   Future<void> register(AuthHiveModel user) async {
//     await authBox.put(user.authId, user.toMap());
//   }

//   AuthHiveModel? login(String email, String password) {
//     for (final raw in authBox.values) {
//       if (raw is Map && raw['email'] == email && raw['password'] == password) {
//         return AuthHiveModel.fromMap(Map<String, dynamic>.from(raw));
//       }
//     }
//     return null;
//   }

//   AuthHiveModel? getUserById(String authId) {
//     final raw = authBox.get(authId);
//     if (raw is Map) {
//       return AuthHiveModel.fromMap(Map<String, dynamic>.from(raw));
//     }
//     return null;
//   }

//   AuthHiveModel? getUserByEmail(String email) {
//     for (final raw in authBox.values) {
//       if (raw is Map && raw['email'] == email) {
//         return AuthHiveModel.fromMap(Map<String, dynamic>.from(raw));
//       }
//     }
//     return null;
//   }

//   Future<bool> updateUser(AuthHiveModel user) async {
//     if (!authBox.containsKey(user.authId)) {
//       return false;
//     }
//     await authBox.put(user.authId, user.toMap());
//     return true;
//   }

//   Future<void> deleteUser(String authId) async {
//     await authBox.delete(authId);
//   }
// }
