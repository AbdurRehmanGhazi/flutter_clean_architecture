import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'configs/injector/init_dependencies.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/theme.dart';
import 'core/theme/theme_bloc/theme_bloc.dart';
import 'core/utils/sdp.dart';
import 'main.dart';
import 'rounter/app_route_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'widgets/classes/custom_localization_delegates.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SDP.init(context);

    final router = getIt<AppRouterConfig>().router;

    // set default system locale change if change from setting
    if (Platform.isIOS && systemLanguageCode.isNotEmpty) {
      context.setLocale(Locale(systemLanguageCode));
      systemLanguageCode = '';
    }

    return BlocConsumer<ThemeBloc, ThemeState>(
      listener: (context, state) {
        AppColors = state.appPalette;
      },
      builder: (context, state) {
        return MaterialApp.router(
          title: 'Demo App',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            ...context.localizationDelegates, // Provided by easy_localization
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            const CustomMaterialLocalizationsDelegate(), // Add custom Material delegate
            const CustomCupertinoLocalizationsDelegate(), // Add custom Cupertino delegate
          ],
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          themeMode: state.materialThemeMode, // context.watch<ThemeProvider>().lightOrDarkMode,
          theme: AppTheme.lightMode(AppColors),
          darkTheme: AppTheme.darkMode(AppColors),
          routerConfig: router,
        );
      },
    );
  }
}

/*

final router = AppRouter().router;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      routerConfig: router,
      backButtonDispatcher: RootBackButtonDispatcher(),
    );


    return MaterialApp(
        navigatorKey: globalNavigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Blog App',
        theme: AppTheme.darkThemeMode,
        navigatorObservers: [SnackBarObserver()],
        home: const WelcomeScreen()
    );
 */