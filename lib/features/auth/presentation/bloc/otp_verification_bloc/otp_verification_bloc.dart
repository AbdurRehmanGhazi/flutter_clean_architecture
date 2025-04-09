import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';
import '../../../../../core/error/failures.dart';
import '../../../domain/entities/otp_resend_response.dart';
import '../../../domain/usecases/otp_resend_usecase.dart';
import '../../../domain/usecases/otp_verification_usecase.dart';

part 'otp_verification_event.dart';

part 'otp_verification_state.dart';

class OtpVerificationBloc extends Bloc<OtpVerificationEvent, OtpVerificationState> {
  final OTPVerificationUseCase _otpVerification;
  final OTPResendUseCase _otpResend;

  OtpVerificationBloc({
    required OTPVerificationUseCase otpVerification,
    required OTPResendUseCase otpResend,
  })  : _otpVerification = otpVerification,
        _otpResend = otpResend,
        super(OtpVerificationInitial()) {
    on<OtpVerificationEvent>((event, emit) => emit(OtpVerificationLoading()));
    on<OTPVerificationEvent>(_onOTPVerificationEvent);
    on<OTPResendEvent>(_onOTPResendEvent);
  }

  _onOTPVerificationEvent(
    OTPVerificationEvent event,
    Emitter<OtpVerificationState> emit,
  ) async {

    late Either<Failure, String> res;
    emit(OtpVerificationLoading(isLoading: true));

    switch (event.type) {
      case OtpVerificationType.registration:
        res = await _otpVerification(OTPVerificationParams(otp: event.otp, mobileNumber: ''));
      case OtpVerificationType.resetPassword:
        res = await _otpVerification(OTPVerificationParams(otp: event.otp, mobileNumber: ''));
      case OtpVerificationType.twoStep:
        res = await _otpVerification(OTPVerificationParams(otp: event.otp, mobileNumber: ''));
    }

    emit(OtpVerificationLoading());
    res.fold(
      (l) => emit(OtpVerificationFailure(l.message)),
      (r) => emit(OtpVerificationSuccess(r)),
    );
  }

  _onOTPResendEvent(
    OTPResendEvent event,
    Emitter<OtpVerificationState> emit,
  ) async {

    late Either<Failure, OtpResendResponse> res;
    emit(OtResendLoading(isLoading: true));

    switch (event.type) {
      case OtpVerificationType.registration:
        res = await _otpResend(OtpResendParams(phone: ''));
      case OtpVerificationType.resetPassword:
        res = await _otpResend(OtpResendParams(phone: ''));
      case OtpVerificationType.twoStep:
        res = await _otpResend(OtpResendParams(phone: ''));
    }

    emit(OtResendLoading());
    res.fold(
      (l) => emit(OtpVerificationFailure(l.message)),
      (r) => emit(OtpResendSuccess(r)),
    );
  }
}
