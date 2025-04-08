import 'package:bloc/bloc.dart';
import 'package:flutter_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture/features/auth/domain/usecases/get_remember_me_usecase.dart';
import 'package:flutter_clean_architecture/features/auth/domain/usecases/set_remember_me_usecase.dart';
import 'package:meta/meta.dart';

import '../../../domain/entities/login_response.dart';
import '../../../domain/usecases/login_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;
  final GetRememberMeUseCase _getRememberMe;
  final SetRememberMeUseCase _setRememberMe;

  LoginBloc({
    required LoginUseCase loginUseCase,
    required GetRememberMeUseCase getRememberMe,
    required SetRememberMeUseCase setRememberMe,
  })  : _loginUseCase = loginUseCase,
        _getRememberMe = getRememberMe,
        _setRememberMe = setRememberMe,
        super(LoginInitial(isRemember: false)) {
    on<LoginEvent>((event, emit) => emit(LoginLoading(isRemember: state.isRemember)));
    on<UserLoginEvent>(_onUserLogin);
    on<RememberToggle>(_onToggleRemember);
    on<LoadRememberMe>(_loadRememberMe);
  }

  _onUserLogin(UserLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading(isLoading: true, isRemember: state.isRemember));
    final res = await _loginUseCase(LoginParams(phone: event.mobileNumber, code: event.pin));
    emit(LoginLoading(isRemember: state.isRemember));
    res.fold(
      (l) => emit(LoginFailure(l.message, isRemember: state.isRemember)),
      (r) => emit(LoginSuccess(r, isRemember: state.isRemember)),
    );
  }

  _onToggleRemember(RememberToggle event, Emitter<LoginState> emit) async {
    final res = await _setRememberMe(event.isRemember);
    res.fold(
      (l) => emit(LoginFailure(l.message, isRemember: state.isRemember)),
      (r) => emit(LoginInitial(isRemember: r)),
    );
  }

  _loadRememberMe(LoadRememberMe event, Emitter<LoginState> emit) async {
    final res = await _getRememberMe(NoParams());
    res.fold(
      (l) => emit(LoginFailure(l.message, isRemember: state.isRemember)),
      (r) => emit(LoginInitial(isRemember: r)),
    );
  }

}
