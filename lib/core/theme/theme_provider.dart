import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_pallete.dart';

enum AppThemeMode { system, light, dark }

class ThemeProvider with ChangeNotifier {
  AppThemeMode _themeMode = AppThemeMode.system; // Default to system mode
  AppPaletteMain _appPalette = AppPaletteLightTheme();

  AppThemeMode get themeMode => _themeMode;

  AppPaletteMain get appPalette => _appPalette;

  ThemeProvider() {
    loadTheme();
    _listenToSystemThemeChanges();
  }

  /// Automatically update if system mode is selected
  void _listenToSystemThemeChanges() {
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = () {
      if (_themeMode == AppThemeMode.system) {
        setTheme(AppThemeMode.system);
        notifyListeners();
      }
    };
  }

  void setTheme(AppThemeMode mode) async {
    _themeMode = mode;
    _updateThemeColors();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme_mode', mode.toString()); // Save selected theme
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    String? storedMode = prefs.getString('theme_mode');

    if (storedMode != null) {
      _themeMode = AppThemeMode.values.firstWhere(
            (e) => e.toString() == storedMode,
        orElse: () => AppThemeMode.system,
      );
    } else {
      _themeMode = AppThemeMode.system; // Set to system mode if null
      await prefs.setString('theme_mode', _themeMode.toString()); // Save default mode
    }

      _updateThemeColors();
      notifyListeners();
  }

  /// Update theme colors based on the selected theme
  void _updateThemeColors() {
    switch (_themeMode) {
      case AppThemeMode.light:
        _appPalette = AppPaletteLightTheme();
        break;
      case AppThemeMode.dark:
        _appPalette = AppPaletteDarkTheme();
        break;
      case AppThemeMode.system:
      default:
      // Use system brightness to decide
        _appPalette = WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark
            ? AppPaletteDarkTheme()
            : AppPaletteLightTheme();
        break;
    }
    // updateUI();
    _updateStatusBarColor();
    notifyListeners();
  }

  /// Get actual theme mode for MaterialApp
  ThemeMode get materialThemeMode {
    switch (_themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
      default:
        return ThemeMode.system;
    }
  }

  ThemeMode get lightOrDarkMode {
    switch (_themeMode) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
      default:
        return WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
    }
  }

  IconData get getThemeIcon {
    switch (_themeMode) {
      case AppThemeMode.light:
        return Icons.light_mode;
      case AppThemeMode.dark:
        return Icons.dark_mode;
      case AppThemeMode.system:
      default:
      return WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark ? Icons.dark_mode : Icons.light_mode;
    }
  }


  void _updateStatusBarColor() {
    switch (_themeMode) {
      case AppThemeMode.light:
        _setStatusBarColorForLightMode();
        break;
      case AppThemeMode.dark:
        _setStatusBarColorForDarkMode();
        break;
      case AppThemeMode.system:
      default:
      // Use system brightness to decide
        WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark
            ? _setStatusBarColorForDarkMode()
            : _setStatusBarColorForLightMode();
        break;
    }
  }

  _setStatusBarColorForDarkMode() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // update status bar color
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppPalette.backgroundColor,
        systemNavigationBarColor: AppPalette.backgroundColor, // navigation bar color
        statusBarIconBrightness: Brightness.light, // For Android status bar text color
        statusBarBrightness: Brightness.dark, // For iOS status bar text color
      ));
    });
  }

  _setStatusBarColorForLightMode() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // update status bar color
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppPalette.backgroundColor,
        systemNavigationBarColor: AppPalette.backgroundColor, // navigation bar color
        statusBarIconBrightness: Brightness.dark, // For Android status bar text color
        statusBarBrightness: Brightness.light, // For iOS status bar text color
      ));
    });
  }
}


/*

 static const MethodChannel _themeChannel = MethodChannel('app.theme');
    // Update iOS UserDefaults
    if (Platform.isIOS) {
      try {
        await _themeChannel.invokeMethod('updateTheme', {'theme': prefs.getString('theme_mode')});
      } catch (e) {
        print('Error updating iOS theme: $e');
      }
    }
 */