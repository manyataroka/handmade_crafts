# Testing Migration Todo

## Goal
- Add 32 new mocktail tests (28 existing → 60 total)
- Remove all mockito usage (none found, already using mocktail)

## Steps

### 1. Create `test/unit/datasource_test.dart` — AuthLocalDatasource
- [X] Mock HiveService and UserSessionService with mocktail
- [X] Test register success
- [X] Test register failure
- [X] Test login success
- [X] Test login failure
- [X] Test getCurrentUser when logged in
- [X] Test logout
= 6 tests

### 2. Create `test/unit/repository_test.dart` — AuthRepository
- [X] Mock local + remote datasources + connectivity with mocktail
- [X] Test register online success
- [X] Test register online failure
- [X] Test register offline
- [X] Test login online success
- [X] Test login fallback to local
- [X] Test logout
= 6 tests

### 3. Create `test/unit/services_test.dart` — Services
- [X] Mock Hive Box, SharedPreferences, StorageService with mocktail
- [X] Test HiveService register
- [X] Test HiveService login success
- [X] Test HiveService login failure
- [X] Test HiveService getUserById
- [X] Test HiveService updateUser success
- [X] Test UserSessionService saveUserSession
- [X] Test StorageService getString/setString
- [X] Test StorageService containsKey/remove
= 8 tests

### 4. Create `test/unit/chatbot_service_test.dart` — ChatbotService
- [ ] Test greeting response
- [ ] Test price query under ₹600
- [ ] Test category query (earrings)
- [ ] Test birthday gift recommendation
- [ ] Test black dress outfit matching
- [ ] Test fallback response
= 6 tests

### 5. Create `test/unit/models_test.dart` — Model Tests
- [ ] Test AuthHiveModel toMap/fromMap roundtrip
- [ ] Test AuthHiveModel equality
- [ ] Test JewelryItem fromJson/toJson
- [ ] Test CartItem totalPrice calculation
- [ ] Test CartItem toJson/fromJson
- [ ] Test JewelryItem default isFavorited
= 6 tests

## Summary
- Existing: 28 tests
- New: 32 tests
- Total: 60 tests
- Framework: mocktail only (zero mockito)

