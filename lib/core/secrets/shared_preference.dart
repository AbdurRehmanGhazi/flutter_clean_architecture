import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  // Keys for different preferences
  static const String _rememberMeKey = "remember_me";
  static const String _usernameKey = "username";
  static const String _isLogin = "isLogin";

  // Save boolean preference like "Remember Me"
  static Future<void> setRememberMe(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_rememberMeKey, value);
  }

  // Retrieve the boolean preference
  static Future<bool> getRememberMe() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_rememberMeKey) ?? false;
  }

  // Save boolean preference like "is Login"
  static Future<void> saveLogin(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLogin, value);
  }

  // Retrieve the boolean preference "is Login"
  static Future<bool> isLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLogin) ?? false;
  }

  // Save String preference like Username
  static Future<void> setUsername(String username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
  }

  // Retrieve the String preference
  static Future<String?> getUsername() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  // Clear all saved preferences
  static Future<void> clearPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Clear all saved preferences
  static String getCurrencySymbol() {
    return "\$";
  }
}
