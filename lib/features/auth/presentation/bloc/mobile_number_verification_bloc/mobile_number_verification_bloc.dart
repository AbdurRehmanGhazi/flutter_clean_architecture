import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/mobile_number_verification_response.dart';
import '../../../domain/usecases/mobile_number_verification_usecase.dart';

part 'mobile_number_verification_event.dart';

part 'mobile_number_verification_state.dart';

class MobileNumberVerificationBloc extends Bloc<MobileNumberVerificationEvent, MobileNumberVerificationState> {
  final MobileNumberVerificationUseCase _mobileNumberVerification;

  MobileNumberVerificationBloc({
    required MobileNumberVerificationUseCase mobileNumberVerification,
  })  : _mobileNumberVerification = mobileNumberVerification,
        super(AuthInitial()) {
    on<MobileNumberVerificationEvent>((_, emit) => emit(const AuthLoading()));
    on<VerifyMobileNumberEvent>(_onMobileNumberVerificationEvent);
  }

  _onMobileNumberVerificationEvent(
    VerifyMobileNumberEvent event,
    Emitter<MobileNumberVerificationState> emit,
  ) async {
    emit(const AuthLoading(isLoading: true));
    final res = await _mobileNumberVerification(MobileNumberVerificationParams(mobileNumber: event.mobileNumber));
    emit(const AuthLoading());
    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(MobileNumberVerified(r)),
    );
  }
}
