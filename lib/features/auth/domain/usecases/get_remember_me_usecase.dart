import 'package:flutter_clean_architecture/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class GetRememberMeUseCase implements UseCase<bool, NoParams>{
  final AuthRepository authRepository;

  GetRememberMeUseCase(this.authRepository);
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await authRepository.getRememberMe();
  }
}

