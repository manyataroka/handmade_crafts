class AuthHiveModel {
  final String authId;
  final String email;
  final String password;
  final String fullName;
  final String username;
  final String phoneNumber;
  final String? batchId;
  final String? profilePicture;

  AuthHiveModel({
    required this.authId,
    required this.email,
    required this.password,
    required this.fullName,
    required this.username,
    required this.phoneNumber,
    this.batchId,
    this.profilePicture,
  });

  Map<String, dynamic> toMap() {
    return {
      'authId': authId,
      'email': email,
      'password': password,
      'fullName': fullName,
      'username': username,
      'phoneNumber': phoneNumber,
      'batchId': batchId,
      'profilePicture': profilePicture,
    };
  }

  factory AuthHiveModel.fromMap(Map<String, dynamic> map) {
    return AuthHiveModel(
      authId: map['authId'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      fullName: map['fullName'] as String,
      username: map['username'] as String,
      phoneNumber: map['phoneNumber'] as String,
      batchId: map['batchId'] as String?,
      profilePicture: map['profilePicture'] as String?,
    );
  }
}
