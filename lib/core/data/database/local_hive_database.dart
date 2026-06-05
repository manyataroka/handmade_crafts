// import 'package:hive_flutter/hive_flutter.dart';

// class LocalHiveDatabase {
//   static const String boxName = 'localBox';

//   static Future<void> init() async {
//     await Hive.initFlutter();
//     if (!Hive.isBoxOpen(boxName)) {
//       await Hive.openBox(boxName);
//     }
//   }

//   static Box get box => Hive.box(boxName);

//   static Future<void> put(String key, dynamic value) async {
//     await box.put(key, value);
//   }

//   static dynamic get(String key, {dynamic defaultValue}) {
//     return box.get(key, defaultValue: defaultValue);
//   }

//   static Future<void> delete(String key) async {
//     await box.delete(key);
//   }

//   static Future<void> clear() async {
//     await box.clear();
//   }
// }
