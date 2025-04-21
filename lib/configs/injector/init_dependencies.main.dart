part of 'init_dependencies.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  AuthDependency.init();

  // core
  getIt.registerLazySingleton(() => ThemeBloc());
  getIt.registerFactory(() => InternetConnection());
  getIt.registerLazySingleton(() => AppUserCubit());

  final isRemember = await SharedPreference.getRememberMe();
  final isLogin =  await SharedPreference.isLogin();
  String initialRoutePath = isLogin ? AppRoute.dashboard.toPath : isRemember ? AppRoute.login.toPath : AppRoute.mobileNumberVerification.toPath;
  getIt.registerLazySingleton(() => AppRouterConfig(initialRoutePath: initialRoutePath));

  getIt.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      getIt(),
    ),
  );
}
