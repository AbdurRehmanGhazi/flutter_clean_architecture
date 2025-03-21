import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/mobile_number_verification_response.dart';
import '../repositories/auth_repository.dart';

class MobileNumberVerificationUseCase implements UseCase<MobileNumberVerificationResponse, MobileNumberVerificationParams> {
  final AuthRepository authRepository;
  MobileNumberVerificationUseCase(this.authRepository);

  @override
  Future<Either<Failure, MobileNumberVerificationResponse>> call(MobileNumberVerificationParams params) async {
    return await authRepository.mobileNumberVerificationRequest(phone: params.mobileNumber);
  }
}

class MobileNumberVerificationParams {
  String mobileNumber;

  MobileNumberVerificationParams({
    required this.mobileNumber,
  });
}
