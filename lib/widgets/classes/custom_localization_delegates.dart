import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/*

Warning: This application's locale, so, is not supported by all of its localization delegates.
(Due to these reasons i have create custom delegates)

• A MaterialLocalizations delegate that supports the so locale was not found.
• A CupertinoLocalizations delegate that supports the so locale was not found. not working i don't know why

 */

class CustomMaterialLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  const CustomMaterialLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'so';

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    // Fallback to default English localizations
    return SynchronousFuture<MaterialLocalizations>(
      DefaultMaterialLocalizations(),
    );
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<MaterialLocalizations> old) => false;
}


class CustomCupertinoLocalizationsDelegate extends LocalizationsDelegate<CupertinoLocalizations> {
  const CustomCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'so';

  @override
  Future<CupertinoLocalizations> load(Locale locale) async {
    // Fallback to default English localizations
    return SynchronousFuture<CupertinoLocalizations>(
      DefaultCupertinoLocalizations(),
    );
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<CupertinoLocalizations> old) => false;
}
