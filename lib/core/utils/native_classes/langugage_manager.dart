import 'package:flutter/services.dart';

class LanguageManager {
  static const MethodChannel _channel = MethodChannel('app.language/settings');

  /// Get the current preferred language
  static Future<String> getPreferredLanguage() async {
    try {
      final String languageCode = await _channel.invokeMethod('getPreferredLanguage');
      return languageCode;
    } on PlatformException catch (e) {
      print("Failed to get preferred language: ${e.message}");
      return 'en'; // Default language
    }
  }

  /// Set the preferred language
  static Future<void> setPreferredLanguage(String languageCode) async {
    try {
      await _channel.invokeMethod('setPreferredLanguage', {'languageCode': languageCode});
    } on PlatformException catch (e) {
      print("Failed to set preferred language: ${e.message}");
    }
  }
}
