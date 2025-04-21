import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/utils/sdp.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/bloc/otp_verification_bloc/otp_verification_bloc.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/widgets/auth_background_view.dart';
import 'package:flutter_clean_architecture/widgets/checkbox_with_label.dart';
import 'package:flutter_clean_architecture/widgets/labels/description_text.dart';
import 'package:flutter_clean_architecture/widgets/labels/hyperlink_text.dart';
import 'package:go_router/go_router.dart';

import '../../../../widgets/textfields/custom_text_field.dart';
import '../../../../widgets/buttons/gradient_button.dart';
import '../../../../widgets/labels/title_text.dart';
import '../../../../core/secrets/shared_preference.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../../configs/injector/init_dependencies.dart';
import '../../../../rounter/app_route_utils.dart';
import '../../domain/usecases/login_usecase.dart';
import '../bloc/login_bloc/login_bloc.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        loginUseCase: getIt<LoginUseCase>(),
      ),
      child: _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  _LoginView();

  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  _validateInputs(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<LoginBloc>().add(UserLoginEvent(
        mobileNumber: mobileNumberController.text.trim(),
        pin: passwordController.text.trim(),
      ));
    }
  }

  _navToResetPasswordScreen(BuildContext context) {
    if (mobileNumberController.text.trim().isNotEmpty) {
      context.pushNamed(AppRoute.otpVerification.toName, extra: [
        mobileNumberController.text.trim(),
        OtpVerificationType.resetPassword,
      ]);
    } else {
      showSnackBar('Mobile Number is required!');
    }
  }

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccess) {
          // context.pushNamed(APP_PAGE.otpVerification.toName, extra: state.loginResponse);
          await SharedPreference.saveLogin(true);
          context.go(AppRoute.dashboard.toPath);
        } else if (state is LoginFailure) {
          showSnackBar(state.message, context);
        }
      },
      builder: (context, state) {

        mobileNumberController = TextEditingController(text: state.blocData.user?.mobileNumber);
        if (state.blocData.isRemember && (state.blocData.user?.password?.isNotEmpty ?? false) && (passwordController.text.trim().isEmpty)) {
          passwordController = TextEditingController(text: state.blocData.user?.password);
        }

        return Scaffold(
          body: AuthBackgroundView(
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.sdp),
                        child: TitleText(text: 'LOGIN'),
                      ),
                      Card(
                        margin: EdgeInsets.all(16.sdp),
                        child: Form(
                          key: formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 32.sdp, horizontal: 16.sdp),
                            child: Column(
                              children: [
                                DescriptionText(
                                  text: 'We need to confirm your identity before proceeding.',
                                  fontSize: 16.sdp,
                                  overflow: TextOverflow.visible,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 16.sdp),
                                CustomTextField(
                                    textEditingController: mobileNumberController,
                                    isNumericField: true,
                                    readOnly: state.blocData.user?.mobileNumber?.isNotEmpty ?? false,
                                    hintText: 'Mobile Number'),
                                SizedBox(height: 16.sdp),
                                CustomTextField(
                                    textEditingController: passwordController,
                                    isPasswordField: true,
                                    validatorType: ValidatorType.password,
                                    hintText: 'Password'),
                                SizedBox(height: 8.sdp),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: HyperlinkText(
                                    text: 'Forgot Password?',
                                    textDecoration: TextDecoration.none,
                                    onTap: () => _navToResetPasswordScreen(context),
                                    ),
                                ),
                                SizedBox(height: 32.sdp),
                                Align(
                                  alignment: Alignment.centerLeft,
                                    child: CheckboxWithLabel(
                                      label: 'Remember Me',
                                      value: state.blocData.isRemember,
                                      onChanged: (value) {
                                        context.read<LoginBloc>().add(RememberToggle(isRemember: value));
                                      })
                                ),
                                SizedBox(height: 8.sdp),
                                GradientButton(
                                    isLoading: state.blocData.isLoading,
                                    buttonText: 'Send',
                                    onPressed: () => _validateInputs(context)),
                                SizedBox(height: 8.sdp),
                                HyperlinkText(
                                  text: 'Use another account.',
                                  textAlign: TextAlign.center,
                                  textDecoration: TextDecoration.none,
                                  onTap: () => context.go(AppRoute.mobileNumberVerification.toPath),
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
      },
    );
  }
}
