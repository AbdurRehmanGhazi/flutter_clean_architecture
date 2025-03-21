part of 'init_dependencies.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  AuthDependency.init();

  getIt.registerLazySingleton(() => ThemeBloc());

  getIt.registerFactory(() => InternetConnection());

  // core
  getIt.registerLazySingleton(() => AppUserCubit());

  getIt.registerFactory<ConnectionChecker>(
    () => ConnectionCheckerImpl(
      getIt(),
    ),
  );
}
