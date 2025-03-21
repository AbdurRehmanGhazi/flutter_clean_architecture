import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/textfields/custom_text_field.dart';
import '../../../../core/widgets/buttons/gradient_button.dart';
import '../../../../core/widgets/gradient_icon.dart';
import '../../../../core/widgets/labels/title_text.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../../features/auth/domain/usecases/mobile_number_verification_usecase.dart';
import '../../../../features/auth/presentation/bloc/mobile_number_verification_bloc/mobile_number_verification_bloc.dart';
import '../../../../configs/injector/init_dependencies.dart';
import '../../../../rounter/route_utils.dart';

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
          context.pushNamed(APP_PAGE.otpVerification.toName, extra: state.response);
        } else if (state is AuthFailure) {
          showSnackBar(state.message, context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    children: [
                      const GradientIcon(icon: Icons.mobile_friendly, size: 120),
                      const SizedBox(height: 16),
                      const TitleText(text: 'Enter your Mobile Number', fontSize: 24),
                      const SizedBox(height: 32),
                      CustomTextField(
                          textEditingController: mobileNumberController,
                          isNumericField: true,
                          hintText: 'Mobile Number'),
                      const SizedBox(height: 32),
                      GradientButton(
                          isLoading: state is AuthLoading ? state.isLoading : false,
                          buttonText: 'Send',
                          onPressed: () => _validateInputs(context))
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
