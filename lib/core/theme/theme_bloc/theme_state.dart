part of 'theme_bloc.dart';

// Theme State
class ThemeState {
  final AppThemeMode themeMode;
  final ThemeMode materialThemeMode;
  final IconData themeIcon;
  final Color statusBarColor;
  final Brightness statusBarIconBrightness;
  final Brightness statusBarBrightness;
  final AppPaletteMain appPalette;

  ThemeState({
    required this.themeMode,
    required this.materialThemeMode,
    required this.themeIcon,
    required this.statusBarColor,
    required this.statusBarIconBrightness,
    required this.statusBarBrightness,
    required this.appPalette,
  });
}
