import 'package:fpdart/src/either.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/login_response.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase implements UseCase<LoginResponse, LoginParams>{
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);
  @override
  Future<Either<Failure, LoginResponse>> call(LoginParams params) async {
    return await authRepository.loginRequest(phone: params.phone, code: params.code);
  }
}


class LoginParams  {
  final String phone;
  final String code;

  LoginParams({required this.phone, required this.code});
}
