import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/classes/rect_slider_thumb_shape.dart';
import 'app_pallete.dart';

// class AppTheme {
//   static _border([Color color = AppPalette.borderColor]) => OutlineInputBorder(
//         borderSide: BorderSide(
//           color: color,
//           width: 3,
//         ),
//         borderRadius: BorderRadius.circular(10),
//       );
//   static final darkThemeMode = ThemeData.dark().copyWith(
//     scaffoldBackgroundColor: AppPalette.backgroundColor,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: AppPalette.backgroundColor,
//     ),
//     chipTheme: const ChipThemeData(
//       color: WidgetStatePropertyAll(
//         AppPalette.backgroundColor,
//       ),
//       side: BorderSide.none,
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       contentPadding: const EdgeInsets.all(22),
//       border: _border(),
//       enabledBorder: _border(),
//       focusedBorder: _border(AppPalette.gradient2),
//       errorBorder: _border(AppPalette.errorColor),
//     ),
//   );
// }


class AppTheme {
  static String? customFontFamily = GoogleFonts.inter().fontFamily;

  static _border({required Color color}) => UnderlineInputBorder(
    borderSide: BorderSide(color: color, width: 4),
  );

  static textTheme(AppPaletteMain AppPalette) => TextTheme(
    bodyLarge: TextStyle(color: AppPalette.textFieldTitleColor, fontFamily: customFontFamily),
    bodyMedium: TextStyle(color: AppPalette.primaryTextColor, fontFamily: customFontFamily),
    // displayLarge: TextStyle(color: AppPallete.primaryTextColor, fontFamily: customFontFamily),
    // displayMedium: TextStyle(color: AppPallete.primaryTextColor, fontFamily: customFontFamily),
    // displaySmall: TextStyle(color: AppPallete.primaryTextColor, fontFamily: customFontFamily),
    // headlineLarge: TextStyle(color: AppPallete.primaryTextColor, fontFamily: customFontFamily),
    // headlineMedium: TextStyle(color: AppPallete.primaryTextColor, fontFamily: customFontFamily),
    // headlineSmall: TextStyle(color: AppPallete.primaryTextColor, fontFamily: customFontFamily),
    // titleLarge: TextStyle(color: AppPallete.primaryTextColor, fontFamily: customFontFamily),
    // titleMedium: TextStyle(color: AppPallete.primaryTextColor, fontFamily: customFontFamily),
    // titleSmall: TextStyle(color: AppPallete.primaryTextColor, fontFamily: customFontFamily),
    // bodySmall: TextStyle(color: AppPallete.primaryTextColor, fontFamily: customFontFamily),
    labelLarge: TextStyle(color: AppPalette.primaryTextColor, fontFamily: customFontFamily),
    // labelMedium: TextStyle(color: AppPallete.primaryTextColor, fontFamily: customFontFamily),
    // labelSmall: TextStyle(color: AppPallete.primaryTextColor, fontFamily: customFontFamily),
  );

  static const titleStyle = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
  );

  static darkMode(AppPaletteMain AppPalette) => ThemeData.dark().copyWith(
      colorScheme: ColorScheme.dark(
        primary: AppPalette.primaryColor,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: AppPalette.backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppPalette.backgroundColor,
        surfaceTintColor: Colors.transparent, // Prevents color changes on scroll
        elevation: 0,
        titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppPalette.primaryTextColor,),
        systemOverlayStyle: SystemUiOverlayStyle( // Setting status bar icons color for iPhone X and older
          statusBarColor: AppPalette.backgroundColor,
          systemNavigationBarColor: AppPalette.backgroundColor, // navigation bar color
          statusBarIconBrightness: Brightness.light, // For Android status bar text color
          statusBarBrightness: Brightness.dark, // For iOS status bar text color
        ),
        iconTheme: IconThemeData(color: AppPalette.primaryTextColor),
        shape: Border(
          bottom: BorderSide(
            color: AppPalette.secondaryBackgroundColor, // Line color
            width: 2, // Line thickness
          ),
        ),// Light icons for AppBar
      ),
      textTheme: textTheme(AppPalette),
      sliderTheme: SliderThemeData(
        overlayShape: SliderComponentShape.noOverlay,
        trackShape: const RectangularSliderTrackShape(),
        thumbShape: const RectSliderThumbShape(width: 5),
      ),
      inputDecorationTheme: InputDecorationTheme(
        // contentPadding: EdgeInsets.symmetric(vertical: 8),
        filled: true,
        fillColor: AppPalette.textFieldBGColor,
        labelStyle: TextStyle(color: AppPalette.textFieldHintColor),
        // hintStyle: TextStyle(color: AppPallete.warningColor),
        enabledBorder: _border(color: AppPalette.primaryBorderColor),
        focusedBorder: _border(color: AppPalette.primaryBorderColor),
        disabledBorder: _border(color: AppPalette.primaryBorderColor),
        errorBorder: _border(color: AppPalette.warningColor),
        focusedErrorBorder: _border(color: AppPalette.warningColor),
      ));

  static lightMode(AppPaletteMain AppPalette) => ThemeData.light().copyWith(
      colorScheme: ColorScheme.dark(
        primary: AppPalette.primaryColor,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppPalette.backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppPalette.backgroundColor,
        surfaceTintColor: Colors.transparent, // Prevents color changes on scroll
        elevation: 0,
        titleTextStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppPalette.primaryTextColor,),
        systemOverlayStyle: SystemUiOverlayStyle( // Setting status bar icons color for iPhone X and older
          statusBarColor: AppPalette.backgroundColor,
          systemNavigationBarColor: AppPalette.backgroundColor, // navigation bar color
          statusBarIconBrightness: Brightness.dark, // For Android status bar text color
          statusBarBrightness: Brightness.light, // For iOS status bar text color
        ),
        iconTheme: IconThemeData(color: AppPalette.primaryTextColor),
        shape: Border(
          bottom: BorderSide(
            color: AppPalette.secondaryBackgroundColor, // Line color
            width: 2, // Line thickness
          ),
        ),// Light icons for AppBar
      ),
      textTheme: textTheme(AppPalette),
      sliderTheme: SliderThemeData(
        overlayShape: SliderComponentShape.noOverlay,
        trackShape: const RectangularSliderTrackShape(),
        thumbShape: const RectSliderThumbShape(width: 5),
      ),
      inputDecorationTheme: InputDecorationTheme(
        // contentPadding: EdgeInsets.symmetric(vertical: 8),
        filled: true,
        fillColor: AppPalette.textFieldBGColor,
        labelStyle: TextStyle(color: AppPalette.textFieldHintColor),
        // hintStyle: TextStyle(color: AppPallete.warningColor),
        enabledBorder: _border(color: AppPalette.primaryBorderColor),
        focusedBorder: _border(color: AppPalette.primaryBorderColor),
        disabledBorder: _border(color: AppPalette.primaryBorderColor),
        errorBorder: _border(color: AppPalette.warningColor),
        focusedErrorBorder: _border(color: AppPalette.warningColor),
      ));
}
