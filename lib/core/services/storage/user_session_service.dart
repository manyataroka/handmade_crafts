import 'storage_service.dart';

class UserSessionService {
  static const String _userIdKey = 'user_id';
  static const String _emailKey = 'user_email';
  static const String _fullNameKey = 'user_full_name';
  static const String _usernameKey = 'user_username';
  static const String _phoneNumberKey = 'user_phone_number';
  static const String _batchIdKey = 'user_batch_id';
  static const String _profilePictureKey = 'user_profile_picture';

  final StorageService _storageService;

  UserSessionService({required StorageService storageService})
    : _storageService = storageService;

  Future<void> saveUserSession({
    required String userId,
    required String email,
    required String fullName,
    required String username,
    required String phoneNumber,
    String? batchId,
    String? profilePicture,
  }) async {
    await _storageService.setString(_userIdKey, userId);
    await _storageService.setString(_emailKey, email);
    await _storageService.setString(_fullNameKey, fullName);
    await _storageService.setString(_usernameKey, username);
    await _storageService.setString(_phoneNumberKey, phoneNumber);
    if (batchId != null) {
      await _storageService.setString(_batchIdKey, batchId);
    }
    if (profilePicture != null) {
      await _storageService.setString(_profilePictureKey, profilePicture);
    }
  }

  bool isLoggedIn() => _storageService.containsKey(_userIdKey);

  String? getCurrentUserId() => _storageService.getString(_userIdKey);

  Future<bool> clearSession() async {
    await _storageService.remove(_userIdKey);
    await _storageService.remove(_emailKey);
    await _storageService.remove(_fullNameKey);
    await _storageService.remove(_usernameKey);
    await _storageService.remove(_phoneNumberKey);
    await _storageService.remove(_batchIdKey);
    await _storageService.remove(_profilePictureKey);
    return true;
  }
}
