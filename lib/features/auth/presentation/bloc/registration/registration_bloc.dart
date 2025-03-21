import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../domain/entities/registration_response.dart';
import '../../../domain/usecases/registration_usecase.dart';

part 'registration_event.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationUseCase _registration;

  RegistrationBloc({
    required RegistrationUseCase registration,
  })  : _registration = registration,
        super(RegistrationInitial()) {
    on<RegistrationEvent>((event, emit) => RegistrationInitial());
    on<UserRegistrationEvent>(_onUserRegistration);
  }

  _onUserRegistration(
    UserRegistrationEvent event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(RegistrationLoading(isLoading: true));
    final res = await _registration(RegistrationParams(phone: event.phone, code: event.code, name: event.name));
    emit(RegistrationLoading());
    res.fold(
      (l) => emit(RegistrationFailure(l.message)),
      (r) => emit(RegistrationSuccess(r)),
    );
  }
}
