import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/theme/app_colors.dart';
import 'package:flutter_clean_architecture/core/theme/theme_bloc/theme_bloc.dart';
import 'package:flutter_clean_architecture/core/utils/sdp.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/widgets/auth_background_view.dart';
import 'package:flutter_clean_architecture/widgets/labels/description_text.dart';
import 'package:flutter_clean_architecture/widgets/styles/custom_container_box_decoration.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/svgs_path.dart';
import '../../../../core/secrets/shared_preference.dart';
import '../../../../widgets/textfields/custom_otp_field.dart';
import '../../../../widgets/buttons/gradient_button.dart';
import '../../../../widgets/labels/hyperlink_text.dart';
import '../../../../widgets/loader.dart';
import '../../../../widgets/labels/title_text.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../../features/auth/domain/usecases/otp_resend_usecase.dart';
import '../../../../features/auth/domain/usecases/otp_verification_usecase.dart';
import '../../../../features/auth/presentation/bloc/otp_verification_bloc/otp_verification_bloc.dart';
import '../../../../configs/injector/init_dependencies.dart';
import '../../../../rounter/app_route_utils.dart';

class OTPVerificationScreen extends StatelessWidget {
  final String mobileNumber;
  final OtpVerificationType otpVerificationType;

  const OTPVerificationScreen({
    super.key,
    required this.mobileNumber,
    required this.otpVerificationType,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpVerificationBloc(
        otpVerification: getIt<OTPVerificationUseCase>(),
        otpResend: getIt<OTPResendUseCase>(),
      ),
      child: _OTPVerificationView(
        mobileNumber: mobileNumber,
        otpVerificationType: otpVerificationType,
      ),
    );
  }
}

class _OTPVerificationView extends StatefulWidget {
  const _OTPVerificationView({
    required this.mobileNumber,
    required this.otpVerificationType,
  });

  final String mobileNumber;
  final OtpVerificationType otpVerificationType;

  @override
  State<_OTPVerificationView> createState() => __OTPVerificationViewState();
}

class __OTPVerificationViewState extends State<_OTPVerificationView> {
  Timer? _timer;
  int _start = 30;
  String _otpCode = '';

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  _validateOTP(BuildContext context) {
    if (_otpCode.length == 5) {
      context.read<OtpVerificationBloc>().add(OTPVerificationEvent(otp: _otpCode, type: widget.otpVerificationType));
    }
  }

  void startTimer() {
    setState(() { _start = 30;  });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpVerificationBloc, OtpVerificationState>(
      listener: (context, state) async {
        if (state is OtpVerificationSuccess) {
          switch(widget.otpVerificationType) {
            case OtpVerificationType.registration:
              context.pushNamed(AppRoute.registration.toName, extra: widget.mobileNumber);
            case OtpVerificationType.resetPassword:
              context.pushNamed(AppRoute.resetPassword.toName, extra: widget.mobileNumber);
            case OtpVerificationType.twoStep:
              await SharedPreference.saveLogin(true);
              context.go(AppRoute.dashboard.toPath);
          }
        } else if (state is OtpResendSuccess) {
          // showSnackBar(state.model.phone ?? '', context);
          showSnackBar('OTP Resend Successfully!', context);
          startTimer();
        } else if (state is OtpVerificationFailure) {
          showSnackBar(state.message, context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: AuthBackgroundView(
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.sdp),
                        child: TitleText(text: 'VERIFICATION'),
                      ),
                      Card(
                        margin: EdgeInsets.all(16.sdp),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.sdp, horizontal: 20.sdp),
                          child: Column(
                            children: [
                              DescriptionText(
                                text: 'A verification code has been sent to your number ${widget.mobileNumber}',
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                fontSize: 16.sdp,
                              ),
                              AnimatedSize(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                                child: (_start != 0) ? Padding(
                                  padding: EdgeInsets.only(top: 16.sdp),
                                  child: DescriptionText(
                                    text: "Please Wait: $_start seconds",
                                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5),
                                  ),
                                ) : SizedBox.shrink(),
                              ), //DateTimeFormatter.formatDuration(_start)
                              SizedBox(height: 16.sdp),
                              Container(
                                height: 120.sdp,
                                width: 120.sdp,
                                padding: EdgeInsets.all(16.sdp),
                                decoration: createCustomBorder(allRadius: 60.sdp, bgColor: Colors.transparent, all: true),
                                child: SvgPicture.asset(SvgsPath.tabseraLogo),
                              ),
                              SizedBox(height: 24.sdp),
                              CustomOtpField(
                                numberOfFields: 5,
                                onChange: (code) {
                                  _otpCode = '';
                                },
                                onSubmit: (code) {
                                  _otpCode = code;
                                },
                              ),
                              SizedBox(height: 32.sdp),
                              GradientButton(
                                isLoading: state is OtpVerificationLoading ? state.isLoading : false,
                                buttonText: 'Verify',
                                onPressed: () => _validateOTP(context),
                              ),
                              AnimatedSize(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                                child: (_start != 0) ? SizedBox.shrink() : Padding(
                                  padding: EdgeInsets.only(top: 8.0.sdp),
                                  child: Column(
                                    children: [
                                      DescriptionText(text: 'Didn\'t receive a code'),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          if (state is OtResendLoading ? state.isLoading : false)
                                            SizedBox(
                                                height: 20.sdp,
                                                width: 20.sdp,
                                                child: Loader(color: AppColors.primaryColor)),
                                          SizedBox(width: 8.sdp),
                                          HyperlinkText(
                                            isEnable: _start == 0,
                                            text: 'Resend Code',
                                            // textDecoration: TextDecoration.none,
                                            color: context.read<ThemeBloc>().state.appPalette.primaryColor,
                                            onTap: () {
                                              context.read<OtpVerificationBloc>().add(OTPResendEvent(
                                                phone: widget.mobileNumber ,
                                                type: widget.otpVerificationType,
                                              ));
                                              },
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
