import 'package:bloc/bloc.dart';
import 'package:flutter_clean_architecture/core/secrets/secure_storage.dart';
import 'package:flutter_clean_architecture/core/secrets/shared_preference.dart';
import 'package:meta/meta.dart';

import '../../../../../core/entities/user.dart';
import '../../../domain/usecases/login_usecase.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc({
    required LoginUseCase loginUseCase,
  })  : _loginUseCase = loginUseCase,
        super(LoginInitial(blocData: LoginBlocData())) {
    on<UserLoginEvent>(_onUserLogin);
    on<RememberToggle>(_onToggleRemember);
    on<LoadRememberMe>(_loadRememberMe);
    add(LoadRememberMe());
  }

  _onUserLogin(UserLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginInitial(blocData: state.blocData.copyWith(isLoading: true)));
    final res = await _loginUseCase(LoginParams(phone: event.mobileNumber, code: event.pin, isRemember: state.blocData.isRemember));
    emit(LoginInitial(blocData: state.blocData.copyWith(isLoading: false)));
    res.fold(
      (l) => emit(LoginFailure(l.message, blocData: state.blocData)),
      (r) => emit(LoginSuccess(blocData: state.blocData.copyWith(user: r))),
    );
  }

  _onToggleRemember(RememberToggle event, Emitter<LoginState> emit) async {
    emit(LoginInitial(blocData: state.blocData.copyWith(isRemember: event.isRemember)));
  }


  _loadRememberMe(LoadRememberMe event, Emitter<LoginState> emit) async {
    final isRemember = await SharedPreference.getRememberMe();
    final user =  await SecureStorage.getUser();
    emit(LoginInitial(blocData: state.blocData.copyWith(isRemember: isRemember, user: user)));
  }

}
