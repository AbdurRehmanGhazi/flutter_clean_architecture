import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/constants/svgs_path.dart';
import 'package:flutter_clean_architecture/core/utils/extensions/buld_context.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/sdp.dart';
import '../../../../widgets/textfields/custom_text_field.dart';
import '../../../../widgets/buttons/gradient_button.dart';
import '../../../../widgets/labels/title_text.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../../features/auth/domain/usecases/mobile_number_verification_usecase.dart';
import '../../../../features/auth/presentation/bloc/mobile_number_verification_bloc/mobile_number_verification_bloc.dart';
import '../../../../configs/injector/init_dependencies.dart';
import '../../../../rounter/app_route_utils.dart';

class MobileNumberVerificationScreen extends StatelessWidget {
  const MobileNumberVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MobileNumberVerificationBloc(
        mobileNumberVerification: getIt<MobileNumberVerificationUseCase>(),
      ),
      child: _MobileNumberVerificationView(),
    );
  }
}

class _MobileNumberVerificationView extends StatelessWidget {
  _MobileNumberVerificationView({super.key});

  final TextEditingController mobileNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  _validateInputs(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<MobileNumberVerificationBloc>().add(VerifyMobileNumberEvent(
          mobileNumber: mobileNumberController.text.trim()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MobileNumberVerificationBloc, MobileNumberVerificationState>(
      listener: (context, state) {
        if (state is MobileNumberVerified) {
          // Navigator.push(context, OTPVerificationScreen.route(mobileNumberVerificationResponse: state.response));
          context.pushNamed(AppRoute.otpVerification.toName, extra: state.response);
        } else if (state is AuthFailure) {
          showSnackBar(state.message, context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.sdp),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        if (context.isPortrait) SvgPicture.asset(SvgsPath.tabseraLogo),
                        SizedBox(height: 60.sdp),
                        Padding(
                          padding: context.isPortrait ? EdgeInsets.symmetric(vertical: context.bodyHeight/2 - 270.sdp) : EdgeInsets.zero,
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 48.sdp, horizontal: 16.sdp),
                              child: Column(
                                children: [
                                  if (context.isLandscape) Padding(
                                    padding: EdgeInsets.only(bottom: 16.sdp),
                                    child: SvgPicture.asset(SvgsPath.tabseraLogo),
                                  ),
                                  const TitleText(text: 'Welcome to Tabsera'),
                                  SizedBox(height: 32.sdp),
                                  CustomTextField(
                                      textEditingController: mobileNumberController,
                                      isNumericField: true,
                                      hintText: 'Mobile Number'),
                                  SizedBox(height: 32.sdp),
                                  GradientButton(
                                      isLoading: state is AuthLoading ? state.isLoading : false,
                                      buttonText: 'Send',
                                      onPressed: () => _validateInputs(context))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
