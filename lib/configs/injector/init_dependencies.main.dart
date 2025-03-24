part of 'init_dependencies.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  AuthDependency.init();

  // core
  getIt.registerLazySingleton(() => ThemeBloc());
  getIt.registerFactory(() => InternetConnection());
  getIt.registerLazySingleton(() => AppUserCubit());

  String initialRoutePath = await SharedPreference.isLogin() ? AppRoute.dashboard.toPath : AppRoute.welcome.toPath;
  getIt.registerLazySingleton(() => AppRouterConfig(initialRoutePath: initialRoutePath));

  getIt.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      getIt(),
    ),
  );
}
