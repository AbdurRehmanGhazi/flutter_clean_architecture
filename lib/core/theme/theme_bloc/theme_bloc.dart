import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_pallete.dart';

part 'theme_event.dart';
part 'theme_state.dart';

// Theme Mode Enum
enum AppThemeMode { system, light, dark }

// Bloc Implementation
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc()
      : super(_getInitialThemeState()) {
    on<LoadThemeEvent>(_onLoadTheme);
    on<SetThemeEvent>(_onSetTheme);
    add(LoadThemeEvent()); // Automatically load theme on Bloc initialization
    _listenToSystemThemeChanges();
  }

  static ThemeState _getInitialThemeState() {
    return _getThemeState(AppThemeMode.system);
  }

  Future<void> _onLoadTheme(LoadThemeEvent event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    String? storedMode = prefs.getString('theme_mode');
    AppThemeMode mode = storedMode != null
        ? AppThemeMode.values.firstWhere(
          (e) => e.toString() == storedMode,
      orElse: () => AppThemeMode.system,
    )
        : AppThemeMode.system;
    emit(_getThemeState(mode));
  }

  Future<void> _onSetTheme(SetThemeEvent event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', event.mode.toString());
    emit(_getThemeState(event.mode));
  }

  void _listenToSystemThemeChanges() {
    WidgetsBinding.instance.platformDispatcher.onPlatformBrightnessChanged = () {
      if (state.themeMode == AppThemeMode.system) {
        add(SetThemeEvent(AppThemeMode.system));
      }
    };
  }

  static ThemeState _getThemeState(AppThemeMode mode) {
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final isDark = brightness == Brightness.dark;

    ThemeMode materialMode;
    IconData themeIcon;
    Color statusBarColor;
    Brightness statusBarIconBrightness;
    Brightness statusBarBrightness;
    AppPaletteMain appPalette;

    switch (mode) {
      case AppThemeMode.light:
        materialMode = ThemeMode.light;
        themeIcon = Icons.light_mode;
        statusBarColor = Colors.white;
        statusBarIconBrightness = Brightness.dark;
        statusBarBrightness = Brightness.light;
        appPalette = AppPaletteLightTheme();
        break;
      case AppThemeMode.dark:
        materialMode = ThemeMode.dark;
        themeIcon = Icons.dark_mode;
        statusBarColor = Colors.black;
        statusBarIconBrightness = Brightness.light;
        statusBarBrightness = Brightness.dark;
        appPalette = AppPaletteDarkTheme();
        break;
      case AppThemeMode.system:
      default:
        materialMode = ThemeMode.system;
        themeIcon = isDark ? Icons.dark_mode : Icons.light_mode;
        statusBarColor = isDark ? Colors.black : Colors.white;
        statusBarIconBrightness = isDark ? Brightness.light : Brightness.dark;
        statusBarBrightness = isDark ? Brightness.dark : Brightness.light;
        appPalette = isDark ? AppPaletteDarkTheme() : AppPaletteLightTheme();
        break;
    }

    _updateStatusBar(statusBarColor, statusBarIconBrightness, statusBarBrightness);
    return ThemeState(
      themeMode: mode,
      materialThemeMode: materialMode,
      themeIcon: themeIcon,
      statusBarColor: statusBarColor,
      statusBarIconBrightness: statusBarIconBrightness,
      statusBarBrightness: statusBarBrightness,
      appPalette: appPalette,
    );
  }

  static void _updateStatusBar(Color color, Brightness iconBrightness, Brightness brightness) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: color,
        systemNavigationBarColor: color,
        statusBarIconBrightness: iconBrightness,
        statusBarBrightness: brightness,
      ));
    });
  }
}
