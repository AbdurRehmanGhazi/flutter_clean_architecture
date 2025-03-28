import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/core/utils/sdp.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/classes/rect_slider_thumb_shape.dart';
import 'app_colors.dart';

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

  static textTheme(AppColorsMain AppPalette) => TextTheme(
    // **1. AppBar Title**
    titleLarge: TextStyle(
      color: AppPalette.primaryTextColor,
      fontFamily: customFontFamily,
      fontSize: 20.sdp,
      fontWeight: FontWeight.bold,
    ),

    // **2. Main Page Titles (Big Titles)**
    headlineLarge: TextStyle(
      // color: AppPalette.primaryTextColor,
      fontFamily: customFontFamily,
      fontSize: 28.sdp,
      fontWeight: FontWeight.w500,
    ),

    // **3. Section Titles (Card Titles, Headers)**
    titleMedium: TextStyle(
      color: AppPalette.primaryTextColor,
      fontFamily: customFontFamily,
      fontSize: 18.sdp,
      fontWeight: FontWeight.w600,
    ),

    // **4. TextField (Normal Content, Paragraphs)**
    bodyLarge: TextStyle(
      color: AppPalette.textFieldTitleColor,
      fontFamily: customFontFamily,
      fontSize: 16.sdp,
      fontWeight: FontWeight.normal,
    ),

    // **4. Body Text (Normal Content, Paragraphs)**
    bodyMedium: TextStyle(
      color: AppPalette.primaryTextColor,
      fontFamily: customFontFamily,
      fontSize: 14.sdp,
      fontWeight: FontWeight.normal,
    ),

    // **6. Labels (Tags, Chips, Small Labels)**
    labelLarge: TextStyle(
      color: AppPalette.primaryTextColor,
      fontFamily: customFontFamily,
      fontSize: 14.sdp,
      fontWeight: FontWeight.w500,
    ),

    labelMedium: TextStyle(
      color: AppPalette.primaryTextColor,
      fontFamily: customFontFamily,
      fontSize: 12.sdp,
      fontWeight: FontWeight.w500,
    ),

    labelSmall: TextStyle(
      color: AppPalette.primaryTextColor,
      fontFamily: customFontFamily,
      fontSize: 10.sdp,
      fontWeight: FontWeight.w400,
    ),
    // titleLarge: TextStyle(color: AppPalette.primaryTextColor, fontFamily: customFontFamily),
    // titleMedium: TextStyle(color: AppPalette.primaryTextColor, fontFamily: customFontFamily),
    titleSmall: TextStyle(color: AppPalette.primaryTextColor, fontFamily: customFontFamily),
    displayLarge: TextStyle(color: AppPalette.primaryTextColor, fontFamily: customFontFamily),
    displayMedium: TextStyle(color: AppPalette.primaryTextColor, fontFamily: customFontFamily),
    displaySmall: TextStyle(color: AppPalette.primaryTextColor, fontFamily: customFontFamily),
    // headlineLarge: TextStyle(color: AppPalette.primaryTextColor, fontFamily: customFontFamily),
    headlineMedium: TextStyle(color: AppPalette.primaryTextColor, fontFamily: customFontFamily),
    headlineSmall: TextStyle(color: AppPalette.primaryTextColor, fontFamily: customFontFamily),
    // bodyLarge: TextStyle(color: AppPalette.textFieldTitleColor, fontFamily: customFontFamily),
    // bodyMedium: TextStyle(color: AppPalette.primaryTextColor, fontFamily: customFontFamily),
    bodySmall: TextStyle(color: AppPalette.primaryTextColor, fontFamily: customFontFamily),
    // labelLarge: TextStyle(color: AppPalette.primaryTextColor, fontFamily: customFontFamily),
    // labelMedium: TextStyle(color: AppPalette.primaryTextColor, fontFamily: customFontFamily),
    // labelSmall: TextStyle(color: AppPalette.primaryTextColor, fontFamily: customFontFamily),
  );

  static darkMode(AppColorsMain AppPalette) => ThemeData.dark().copyWith(
      colorScheme: ColorScheme.dark(
        primary: AppPalette.primaryColor,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: AppPalette.backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppPalette.backgroundColor,
        surfaceTintColor: Colors.transparent, // Prevents color changes on scroll
        elevation: 0,
        titleTextStyle: TextStyle(fontSize: 16.sdp, fontWeight: FontWeight.w400, color: AppPalette.primaryTextColor,),
        // systemOverlayStyle: SystemUiOverlayStyle( // Setting status bar icons color for iPhone X and older
        //   statusBarColor: AppPalette.backgroundColor,
        //   systemNavigationBarColor: AppPalette.backgroundColor, // navigation bar color
        //   statusBarIconBrightness: Brightness.light, // For Android status bar text color
        //   statusBarBrightness: Brightness.dark, // For iOS status bar text color
        // ),
        iconTheme: IconThemeData(color: AppPalette.primaryTextColor), // Light icons for AppBar
        // shape: Border(
        //   bottom: BorderSide(
        //     color: AppPalette.secondaryBackgroundColor, // Line color
        //     width: 1, // Line thickness
        //   ),
        // ),
      ),
      textTheme: textTheme(AppPalette),
      cardColor: AppPalette.primaryCardColor,
      cardTheme: CardTheme(
          color: AppPalette.primaryCardColor, // Light mode card color
          shadowColor: AppPalette.primaryShadowColor,
          elevation: 4,
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: AppPalette.borderColor.withAlpha(40), width: 1)
          )
      ),
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
        // hintStyle: TextStyle(color: AppPalette.warningColor),
        enabledBorder: _border(color: AppPalette.primaryBorderColor),
        focusedBorder: _border(color: AppPalette.primaryBorderColor),
        disabledBorder: _border(color: AppPalette.primaryBorderColor),
        errorBorder: _border(color: AppPalette.warningColor),
        focusedErrorBorder: _border(color: AppPalette.warningColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPalette.gradient2, // Set default background color
          foregroundColor: AppPalette.whiteColor, // Text color
          textStyle: TextStyle(
            fontSize: 14.sdp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
  );

  static lightMode(AppColorsMain AppPalette) => ThemeData.light().copyWith(
      colorScheme: ColorScheme.dark(
        primary: AppPalette.primaryColor,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: AppPalette.backgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: AppPalette.backgroundColor,
        surfaceTintColor: Colors.transparent, // Prevents color changes on scroll
        elevation: 0,
        titleTextStyle: TextStyle(fontSize: 16.sdp, fontWeight: FontWeight.w400, color: AppPalette.primaryTextColor,),
        // systemOverlayStyle: SystemUiOverlayStyle( // Setting status bar icons color for iPhone X and older
        //   statusBarColor: AppPalette.backgroundColor,
        //   systemNavigationBarColor: AppPalette.backgroundColor, // navigation bar color
        //   statusBarIconBrightness: Brightness.dark, // For Android status bar text color
        //   statusBarBrightness: Brightness.light, // For iOS status bar text color
        // ),
        iconTheme: IconThemeData(color: AppPalette.primaryTextColor), // Light icons for AppBar
        // shape: Border(
        //   bottom: BorderSide(
        //     color: AppPalette.secondaryBackgroundColor, // Line color
        //     width: 2, // Line thickness
        //   ),
        // ),
      ),
      textTheme: textTheme(AppPalette),
      cardColor: AppPalette.primaryCardColor,
      cardTheme: CardTheme(
        color: AppPalette.primaryCardColor, // Light mode card color
        shadowColor: AppPalette.primaryShadowColor,
        elevation: 4,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppPalette.borderColor.withAlpha(40), width: 1)
        )
      ),
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
        // hintStyle: TextStyle(color: AppPalette.warningColor),
        enabledBorder: _border(color: AppPalette.primaryBorderColor),
        focusedBorder: _border(color: AppPalette.primaryBorderColor),
        disabledBorder: _border(color: AppPalette.primaryBorderColor),
        errorBorder: _border(color: AppPalette.warningColor),
        focusedErrorBorder: _border(color: AppPalette.warningColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPalette.gradient2, // Set default background color
          foregroundColor: AppPalette.whiteColor, // Text color
          textStyle: TextStyle(
            fontSize: 14.sdp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
  );
}
