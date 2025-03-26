import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../widgets/textfields/custom_text_field.dart';
import '../../../../widgets/buttons/gradient_button.dart';
import '../../../../widgets/gradient_icon.dart';
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
  _LoginView({super.key});

  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  _validateInputs(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<LoginBloc>().add(UserLoginEvent(
        mobileNumber: mobileNumberController.text.trim(),
        pin: pinController.text.trim(),
      ));
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
                      const TitleText(text: 'Enter your Mobile Number'),
                      const SizedBox(height: 32),
                      CustomTextField(
                          textEditingController: mobileNumberController,
                          isNumericField: true,
                          hintText: 'Mobile Number'),
                      const SizedBox(height: 16),
                      CustomTextField(
                          textEditingController: pinController,
                          isNumericField: true,
                          isPasswordField: true,
                          isPinField: true,
                          hintText: 'PIN'),
                      const SizedBox(height: 32),
                      GradientButton(
                          isLoading: state is LoginLoading ? state.isLoading : false,
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
