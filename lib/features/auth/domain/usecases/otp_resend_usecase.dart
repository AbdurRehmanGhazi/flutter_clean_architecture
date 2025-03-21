import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';
import '../entities/otp_resend_response.dart';

class OTPResendUseCase implements UseCase<dynamic, OtpResendParams> {
  final AuthRepository authRepository;
  OTPResendUseCase(this.authRepository);

  @override
  Future<Either<Failure, OtpResendResponse>> call(OtpResendParams params) async {
    return await authRepository.otpResendRequest(phone: params.phone);
  }
}

class OtpResendParams {
  String phone;

  OtpResendParams({
    required this.phone,
  });
}
