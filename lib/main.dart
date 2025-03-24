import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/theme/theme_bloc/theme_bloc.dart';
import 'package:flutter_clean_architecture/translations/codegen_loader.g.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app.dart';
import 'configs/injector/init_dependencies.dart';
import 'core/utils/native_classes/langugage_manager.dart';

final globalNavigatorKey = GlobalKey<NavigatorState>();
String systemLanguageCode = '';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencies();

  Intl.defaultLocale = 'en';

  await EasyLocalization.ensureInitialized();
  await initializeDateFormatting('en_US', null);

  systemLanguageCode = Platform.isIOS ? await LanguageManager.getPreferredLanguage() : '';
  systemLanguageCode = systemLanguageCode.split('-').first;

  runApp(
    EasyLocalization(
      path: 'assets/translations',
      supportedLocales: const [
        Locale('en'),
        Locale('so'),
      ],
      fallbackLocale: Locale('en'),
      assetLoader: CodegenLoader(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => getIt<ThemeBloc>()),
        ],
        child: MyApp(),
      ),
    ),
  );
}

