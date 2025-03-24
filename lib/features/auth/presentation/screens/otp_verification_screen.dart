import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/textfields/custom_otp_field.dart';
import '../../../../core/widgets/buttons/gradient_button.dart';
import '../../../../core/widgets/gradient_icon.dart';
import '../../../../core/widgets/labels/hyperlink_text.dart';
import '../../../../core/widgets/loader.dart';
import '../../../../core/widgets/labels/title_text.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../../features/auth/domain/entities/mobile_number_verification_response.dart';
import '../../../../features/auth/domain/usecases/otp_resend_usecase.dart';
import '../../../../features/auth/domain/usecases/otp_verification_usecase.dart';
import '../../../../features/auth/presentation/bloc/otp_verification_bloc/otp_verification_bloc.dart';
import '../../../../features/auth/presentation/screens/registration_screen.dart';
import '../../../../configs/injector/init_dependencies.dart';
import '../../../../rounter/app_route_utils.dart';

class OTPVerificationScreen extends StatelessWidget {
  final MobileNumberVerificationResponse mobileNumberVerificationResponse;

  const OTPVerificationScreen({
    super.key,
    required this.mobileNumberVerificationResponse,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpVerificationBloc(
        otpVerification: getIt<OTPVerificationUseCase>(),
        otpResend: getIt<OTPResendUseCase>(),
      ),
      child: _OTPVerificationView(mobileNumberVerificationResponse: mobileNumberVerificationResponse),
    );
  }
}

class _OTPVerificationView extends StatefulWidget {

  const _OTPVerificationView({super.key, required this.mobileNumberVerificationResponse});

  final MobileNumberVerificationResponse mobileNumberVerificationResponse;

  @override
  State<_OTPVerificationView> createState() => __OTPVerificationViewState();
}

class __OTPVerificationViewState extends State<_OTPVerificationView> {
  String _otpCode = '';

  _validateOTP(BuildContext context) {
    if (_otpCode.length == 5) {
      context.read<OtpVerificationBloc>().add(OTPVerificationEvent(otp: _otpCode));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpVerificationBloc, OtpVerificationState>(
      listener: (context, state) {
        if (state is OtpVerificationSuccess) {
          context.pushNamed(AppRoute.registration.toName, extra: widget.mobileNumberVerificationResponse.phone);
        } else if (state is OtpResendSuccess) {
          // showSnackBar(state.model.phone ?? '', context);
          showSnackBar('OTP Resend Successfully!', context);
        } else if (state is OtpVerificationFailure) {
          showSnackBar(state.message, context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Center(
              child: SingleChildScrollView(
                child: Column(children: [
                  const GradientIcon(icon: Icons.pin_rounded, size: 120,),
                  const SizedBox(height: 16),
                  const TitleText(text: 'Enter the 5-digit OTP sent to your mobile number +923355269449'),
                  const SizedBox(height: 32),
                  CustomOtpField(
                    numberOfFields: 5,
                    onChange: (code) {
                      _otpCode = '';
                    },
                    onSubmit: (code) {
                      _otpCode = code;
                    },
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Spacer(),
                      if (state is OtResendLoading ? state.isLoading : false)
                        const SizedBox(height: 20, width: 20, child: Loader()),
                      const SizedBox(width: 8),
                      HyperlinkText(
                        isEnable: true,
                        text: 'Resend',
                        onTap: () {
                          context.read<OtpVerificationBloc>().add(OTPResendEvent(phone: widget.mobileNumberVerificationResponse.phone ?? ''));
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 32),
                  GradientButton(
                    isLoading: state is OtpVerificationLoading ? state.isLoading : false,
                    buttonText: 'Verify',
                    onPressed: () => _validateOTP(context),
                  ),
                ],),
              ),
            ),
          ),
        );
      },
    );
  }
}
