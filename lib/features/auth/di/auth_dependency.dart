import '../../../configs/injector/init_dependencies.dart';
import '../data/datasources/auth_remote_data_source.dart';
import '../data/repositories/auth_repository_impl.dart';
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/login_usecase.dart';
import '../domain/usecases/mobile_number_verification_usecase.dart';
import '../domain/usecases/otp_resend_usecase.dart';
import '../domain/usecases/otp_verification_usecase.dart';
import '../domain/usecases/registration_usecase.dart';

class AuthDependency {

  static void init() {
    // Data Source
    getIt
      ..registerFactory<AuthRemoteDataSource>(
            () => AuthRemoteDataSourceImpl(),
      )

    // Repository
      ..registerFactory<AuthRepository>(
            () => AuthRepositoryImpl(
          getIt(),
        ),
      )

    // UseCases
      ..registerFactory<MobileNumberVerificationUseCase>(
            () => MobileNumberVerificationUseCase(
          getIt(),
        ),
      )

      ..registerFactory<OTPVerificationUseCase>(
            () => OTPVerificationUseCase(
          getIt(),
        ),
      )

      ..registerFactory<OTPResendUseCase>(
            () => OTPResendUseCase(
          getIt(),
        ),
      )

      ..registerFactory<RegistrationUseCase>(
            () => RegistrationUseCase(
          getIt(),
        ),
      )

      ..registerFactory<LoginUseCase>(
            () => LoginUseCase(
          getIt(),
        ),
      );
  }
}