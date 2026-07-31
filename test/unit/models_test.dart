import 'package:flutter_test/flutter_test.dart';
import 'package:handmade_crafts/features/auth/data/models/auth_hive_model.dart';

// Import JewelryItem and CartItem from dashboard_view where they're defined
// Since they're not exported, we'll test the models via their serialization methods
void main() {
  group('AuthHiveModel Tests', () {
    final testUser = AuthHiveModel(
      authId: '123',
      email: 'test@test.com',
      password: 'password123',
      fullName: 'Test User',
      username: 'testuser',
      phoneNumber: '+1234567890',
    );

    test('toMap returns correct map representation', () {
      final map = testUser.toMap();

      expect(map['authId'], '123');
      expect(map['email'], 'test@test.com');
      expect(map['password'], 'password123');
      expect(map['fullName'], 'Test User');
      expect(map['username'], 'testuser');
      expect(map['phoneNumber'], '+1234567890');
      expect(map['batchId'], null);
      expect(map['profilePicture'], null);
    });

    test('fromMap creates correct AuthHiveModel', () {
      final map = {
        'authId': '456',
        'email': 'user@example.com',
        'password': 'securepass',
        'fullName': 'John Doe',
        'username': 'johndoe',
        'phoneNumber': '+9876543210',
        'batchId': 'batch1',
        'profilePicture': 'assets/images/profile.jpg',
      };

      final user = AuthHiveModel.fromMap(map);

      expect(user.authId, '456');
      expect(user.email, 'user@example.com');
      expect(user.password, 'securepass');
      expect(user.fullName, 'John Doe');
      expect(user.username, 'johndoe');
      expect(user.phoneNumber, '+9876543210');
      expect(user.batchId, 'batch1');
      expect(user.profilePicture, 'assets/images/profile.jpg');
    });

    test('toMap/fromMap roundtrip preserves all fields', () {
      final user = AuthHiveModel(
        authId: '789',
        email: 'roundtrip@test.com',
        password: 'testpass',
        fullName: 'Round Trip',
        username: 'roundtrip',
        phoneNumber: '+1111111111',
        batchId: 'batch2',
        profilePicture: null,
      );

      final map = user.toMap();
      final reconstructed = AuthHiveModel.fromMap(map);

      expect(reconstructed.authId, user.authId);
      expect(reconstructed.email, user.email);
      expect(reconstructed.password, user.password);
      expect(reconstructed.fullName, user.fullName);
      expect(reconstructed.username, user.username);
      expect(reconstructed.phoneNumber, user.phoneNumber);
      expect(reconstructed.batchId, user.batchId);
      expect(reconstructed.profilePicture, user.profilePicture);
    });

    test('AuthHiveModel supports optional fields being null', () {
      final user = AuthHiveModel(
        authId: '101',
        email: 'nullable@test.com',
        password: 'pass',
        fullName: 'Nullable Fields',
        username: 'nullable',
        phoneNumber: '+2222222222',
      );

      expect(user.batchId, null);
      expect(user.profilePicture, null);
    });

    test('AuthHiveModel fromMap handles missing optional fields', () {
      final map = {
        'authId': '102',
        'email': 'nooptionals@test.com',
        'password': 'pass',
        'fullName': 'No Optionals',
        'username': 'nooptionals',
        'phoneNumber': '+3333333333',
      };

      final user = AuthHiveModel.fromMap(map);

      expect(user.authId, '102');
      expect(user.batchId, null);
      expect(user.profilePicture, null);
    });

    test('AuthHiveModel fromMap handles null optional fields', () {
      final map = {
        'authId': '103',
        'email': 'nullopt@test.com',
        'password': 'pass',
        'fullName': 'Null Opt',
        'username': 'nullopt',
        'phoneNumber': '+4444444444',
        'batchId': null,
        'profilePicture': null,
      };

      final user = AuthHiveModel.fromMap(map);

      expect(user.authId, '103');
      expect(user.batchId, null);
      expect(user.profilePicture, null);
    });
  });
}
