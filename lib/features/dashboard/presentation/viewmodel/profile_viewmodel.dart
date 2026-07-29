import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewModel extends StateNotifier<bool> {
  ProfileViewModel() : super(false);

  String? name;
  String? email;
  int favoritesCount = 0;
  String? imagePath;

  Future<void> loadProfile() async {
    state = true;
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('username');
    email = prefs.getString('email');
    favoritesCount = prefs.getStringList('favorites')?.length ?? 0;
    imagePath = prefs.getString('profile_image_path');
    state = false;
  }
}
