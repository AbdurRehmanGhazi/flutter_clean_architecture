import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class OTPVerificationUseCase implements UseCase<dynamic, OTPVerificationParams> {
  final AuthRepository authRepository;
  OTPVerificationUseCase(this.authRepository);

  @override
  Future<Either<Failure, String>> call(OTPVerificationParams params) async {
    return await authRepository.otpVerificationRequest(otp: params.otp, phone: params.mobileNumber);
  }
}

class OTPVerificationParams {
  String otp;
  String mobileNumber;

  OTPVerificationParams({
    required this.otp,
    required this.mobileNumber,
  });
}
