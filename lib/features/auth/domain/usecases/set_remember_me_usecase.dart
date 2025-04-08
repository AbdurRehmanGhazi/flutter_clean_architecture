import 'package:flutter_clean_architecture/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class SetRememberMeUseCase implements UseCase<bool, bool>{
  final AuthRepository authRepository;

  SetRememberMeUseCase(this.authRepository);
  @override
  Future<Either<Failure, bool>> call(bool value) async {
    return await authRepository.setRememberMe(value: value);
  }
}

