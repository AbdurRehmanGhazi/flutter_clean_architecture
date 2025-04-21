part of 'login_bloc.dart';


class LoginBlocData {
  final User? user;
  final bool isRemember;
  final bool isLoading;

  LoginBlocData({this.user, this.isRemember = false, this.isLoading = false});

  LoginBlocData copyWith({User? user, bool? isRemember, bool? isLoading}) {
    return LoginBlocData(
      user: user ?? this.user,
      isRemember: isRemember ?? this.isRemember,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

@immutable
sealed class LoginState {
  final LoginBlocData blocData;
  const LoginState({required this.blocData});
}

final class LoginInitial extends LoginState {
  const LoginInitial({required super.blocData});
}

final class LoginFailure extends LoginState {
  final String message;

  const LoginFailure(this.message, {required super.blocData});
}

final class LoginSuccess extends LoginState {
  const LoginSuccess({required super.blocData});
}
