import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/theme/theme_bloc/theme_bloc.dart';
import 'package:flutter_clean_architecture/translations/codegen_loader.g.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import '../core/secrets/shared_preference.dart';
import '../core/theme/theme.dart';
import '../core/utils/snackbar_observer.dart';
import '../features/auth/presentation/screens/welcome_screen.dart';
import 'configs/injector/init_dependencies.dart';
import '../rounter/app_router.dart';
import '../rounter/route_utils.dart';
import 'core/theme/app_pallete.dart';
import 'core/theme/theme_provider.dart';
import 'core/utils/native_classes/langugage_manager.dart';
import 'core/widgets/classes/custom_localization_delegates.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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

  String initialRoutePath = await SharedPreference.isLogin() ? APP_PAGE.dashboard.toPath : APP_PAGE.welcome.toPath;

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
        child: MyApp(initialRoutePath: initialRoutePath),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoutePath;
  const MyApp({super.key, required this.initialRoutePath});

  @override
  Widget build(BuildContext context) {

    final router = AppRouter(initialRoutePath: initialRoutePath).router;

    // set default system locale change if change from setting
    if (Platform.isIOS && systemLanguageCode.isNotEmpty) {
      context.setLocale(Locale(systemLanguageCode));
      systemLanguageCode = '';
    }


    return BlocConsumer<ThemeBloc, ThemeState>(
      listener: (context, state) {
        AppPalette = state.appPalette;
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
          theme: AppTheme.lightMode(AppPalette),
          darkTheme: AppTheme.darkMode(AppPalette),
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