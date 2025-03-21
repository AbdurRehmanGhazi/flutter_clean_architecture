import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
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
    emit(OtpVerificationLoading(isLoading: true));
    final res = await _otpVerification(OTPVerificationParams(otp: event.otp, mobileNumber: ''));
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
    emit(OtResendLoading(isLoading: true));
    final res = await _otpResend(OtpResendParams(phone: ''));
    emit(OtResendLoading());
    res.fold(
      (l) => emit(OtpVerificationFailure(l.message)),
      (r) => emit(OtpResendSuccess(r)),
    );
  }
}
