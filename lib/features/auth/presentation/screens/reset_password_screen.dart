import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/utils/sdp.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/widgets/auth_background_view.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/validators/confirm_password_validator.dart';
import '../../../../widgets/textfields/custom_otp_field.dart';
import '../../../../widgets/textfields/custom_text_field.dart';
import '../../../../widgets/buttons/gradient_button.dart';
import '../../../../widgets/gradient_icon.dart';
import '../../../../widgets/labels/title_text.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../../features/auth/domain/usecases/registration_usecase.dart';
import '../../../../features/auth/presentation/bloc/registration/registration_bloc.dart';
import '../../../../configs/injector/init_dependencies.dart';
import '../../../../main.dart';
import '../../../../rounter/app_route_utils.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String mobileNumber;

  const ResetPasswordScreen({
    super.key,
    required this.mobileNumber,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(registration: getIt<RegistrationUseCase>()),
      child: _ResetPasswordView(mobileNumber: mobileNumber),
    );
  }
}

class _ResetPasswordView extends StatefulWidget {
  final String mobileNumber;
  const _ResetPasswordView({super.key, required this.mobileNumber});

  @override
  State<_ResetPasswordView> createState() => __ResetPasswordViewState();
}

class __ResetPasswordViewState extends State<_ResetPasswordView> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  _navToMobileNumberVerificationScreen(BuildContext context) {
    if (formKey.currentState!.validate()) {
      final validateConfirmPassword = ConfirmPasswordValidator.validate(passwordController.text.trim(), confirmPasswordController.text.trim());
      if (validateConfirmPassword != null) {
        showSnackBar(validateConfirmPassword);
        return;
      }
      context.read<RegistrationBloc>().add(UserRegistrationEvent(
        phone: widget.mobileNumber,
        code: 'lk',
        name: passwordController.text.trim(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          if (state is RegistrationSuccess) {
            context.go(AppRoute.login.toPath);
            Timer(const Duration(milliseconds: 500), () => showSnackBar('Password Reset Successfully!', globalNavigatorKey.currentContext));
          } else if (state is RegistrationFailure) {
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
                          child: TitleText(text: 'Reset Password'),
                        ),
                        Card(
                          margin: EdgeInsets.all(16.sdp),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 32.sdp, horizontal: 16.sdp),
                            child: Form(
                              key: formKey,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              child: Column(
                                children: [
                                  CustomTextField(
                                      isPasswordField: true,
                                      validatorType: ValidatorType.password,
                                      textEditingController: passwordController,
                                      prefixIcon: GradientIcon(icon: Icons.lock_rounded),
                                      hintText: 'Password'),
                                  SizedBox(height: 16.sdp),
                                  CustomTextField(
                                      isPasswordField: true,
                                      validatorType: ValidatorType.confirmPassword,
                                      textEditingController: confirmPasswordController,
                                      prefixIcon: GradientIcon(icon: Icons.lock_rounded),
                                      hintText: 'Confirm Password'),
                                  SizedBox(height: 32.sdp),
                                  GradientButton(
                                    isLoading: state is RegistrationLoading ? state.isLoading : false,
                                    buttonText: 'Reset',
                                    onPressed: () => _navToMobileNumberVerificationScreen(context),
                                  ),
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
          );
        }
    );
  }
}
