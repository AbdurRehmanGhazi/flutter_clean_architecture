import 'package:fpdart/src/either.dart';
import '../../../../core/entities/user.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/login_response.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase implements UseCase<User, LoginParams>{
  final AuthRepository authRepository;

  LoginUseCase(this.authRepository);
  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await authRepository.loginRequest(phone: params.phone, code: params.code, isRemember: params.isRemember);
  }
}


class LoginParams  {
  final String phone;
  final String code;
  final bool isRemember;

  LoginParams({required this.phone, required this.code, required this.isRemember});
}
