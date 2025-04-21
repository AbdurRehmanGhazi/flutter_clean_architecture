import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../entities/user.dart';

enum SecureStoreKey {
  token,
  userData,
  mobileNumber,
  password,
}

class SecureStorage {
  // Create a private constructor
  SecureStorage._internal();

  // Singleton instance
  static final SecureStorage _instance = SecureStorage._internal();

  // Getter for the singleton instance
  factory SecureStorage() {
    return _instance;
  }

  // Static instance of FlutterSecureStorage initialized once
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: _androidOptions,
    iOptions: _iosOptions,
  );

  // Android and iOS options initialized once
  static const AndroidOptions _androidOptions = AndroidOptions(
    encryptedSharedPreferences: true, // Enables AES encryption using Keystore
  );

  static const IOSOptions _iosOptions = IOSOptions(
    accessibility: KeychainAccessibility.first_unlock, // Data accessible after first unlock
  );

  // Save data securely
  static Future<void> saveSecureData(SecureStoreKey key, String value) async {
    await _secureStorage.write(
      key: key.name, // Use the enum's name for the key
      value: value,
    );
  }

  // Retrieve secure data
  static Future<String?> getSecureData(SecureStoreKey key) async {
    return await _secureStorage.read(
      key: key.name, // Use the enum's name for the key
    );
  }

  // Delete secure data
  static Future<void> deleteSecureData(SecureStoreKey key) async {
    await _secureStorage.delete(
      key: key.name, // Use the enum's name for the key
    );
  }

  // Delete all secure data
  static Future<void> deleteAllSecureData() async {
    await _secureStorage.deleteAll();
  }


  // Save user object securely
  static Future<void> saveUser(User? user) async {
    String userJson = user?.toRawJson() ?? ''; // Serialize the user object
    await saveSecureData(SecureStoreKey.userData, userJson);
  }

  // Retrieve user object securely
  static Future<User?> getUser() async {
    String? userJson = await getSecureData(SecureStoreKey.userData); // Retrieve the user JSON string
    if (userJson != null && userJson.isNotEmpty) {
      return User.fromRawJson(userJson); // Deserialize into User object
    }
    return null; // Return null if no user data found
  }

  // Retrieve token
  static Future<String?> getToken() async {
    // final user = await SecureStore.getUser();
    // return user?.token;
    return '';
  }

  // Save Password securely
  static Future<void> savePassword(String value) async {
    SecureStorage.saveSecureData(SecureStoreKey.password, value);
  }

  // Retrieve Password data
  static Future<String?> getPassword() {
    return SecureStorage.getSecureData(SecureStoreKey.password);
  }

  // Delete Password data
  static Future<void> deletePassword() async {
    await SecureStorage.deleteSecureData(SecureStoreKey.password);
  }

}
