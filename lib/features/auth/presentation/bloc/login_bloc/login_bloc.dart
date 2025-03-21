import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/login_response.dart';
import '../../../domain/usecases/login_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc({
    required LoginUseCase loginUseCase,
  })  : _loginUseCase = loginUseCase,
        super(LoginInitial()) {
    on<LoginEvent>((event, emit) => emit(LoginLoading()));
    on<UserLoginEvent>(_onUserLogin);
  }

  _onUserLogin(UserLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading(isLoading: true));
    final res = await _loginUseCase(LoginParams(phone: event.mobileNumber, code: event.pin));
    emit(LoginLoading());
    res.fold(
          (l) => emit(LoginFailure(l.message)),
          (r) => emit(LoginSuccess(r)),
    );
  }
}
