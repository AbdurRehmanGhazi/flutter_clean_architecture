import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/registration_response.dart';
import '../repositories/auth_repository.dart';

class RegistrationUseCase implements UseCase<RegistrationResponse, RegistrationParams>{
  final AuthRepository authRepository;
  RegistrationUseCase(this.authRepository);

  @override
  Future<Either<Failure, RegistrationResponse>> call(RegistrationParams params) async {
    return await authRepository.registrationRequest(name: params.name, phone: params.phone, code: params.code);
  }
}

class RegistrationParams {
  String phone;
  String code;
  String name;

  RegistrationParams({
    required this.phone,
    required this.code,
    required this.name,
  });
}