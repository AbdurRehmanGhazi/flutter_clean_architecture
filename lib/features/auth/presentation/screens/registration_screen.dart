import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/utils/sdp.dart';
import 'package:go_router/go_router.dart';
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

class RegistrationScreen extends StatelessWidget {
  final String mobileNumber;

  const RegistrationScreen({
    super.key,
    required this.mobileNumber,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(registration: getIt<RegistrationUseCase>()),
      child: RegistrationView(mobileNumber: mobileNumber),
    );
  }
}

class RegistrationView extends StatefulWidget {
  final String mobileNumber;
  const RegistrationView({super.key, required this.mobileNumber});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  _navToMobileNumberVerificationScreen(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<RegistrationBloc>().add(UserRegistrationEvent(
            phone: widget.mobileNumber,
            code: 'lk',
            name: firstNameController.text.trim(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
      if (state is RegistrationSuccess) {
        context.go(AppRoute.welcome.toPath);
        Timer(const Duration(milliseconds: 500), () => showSnackBar('Registration Complete Successfully!', globalNavigatorKey.currentContext));
      } else if (state is RegistrationFailure) {
        showSnackBar(state.message, context);
      }
    },
    builder: (context, state) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.sdp),
                    child: TitleText(text: 'SIGN UP'),
                  ),
                  Card(
                    margin: EdgeInsets.all(16.sdp),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.sdp, horizontal: 16.sdp),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            CustomTextField(
                                textEditingController: firstNameController,
                                prefixIcon: GradientIcon(icon: Icons.person_rounded),
                                hintText: 'First Name'),
                            SizedBox(height: 16.sdp),
                            CustomTextField(
                                textEditingController: lastNameController,
                                prefixIcon: GradientIcon(icon: Icons.person_rounded),
                                hintText: 'Last Name'),
                            SizedBox(height: 16.sdp),
                            CustomTextField(
                                textEditingController: emailController,
                                prefixIcon: GradientIcon(icon: Icons.email_rounded),
                                hintText: 'Email'),
                            SizedBox(height: 16.sdp),
                            CustomTextField(
                                textEditingController: passwordController,
                                isPasswordField: true,
                                prefixIcon: GradientIcon(icon: Icons.lock_rounded),
                                hintText: 'Password'),
                            SizedBox(height: 16.sdp),
                            CustomTextField(
                                textEditingController: confirmPasswordController,
                                isPasswordField: true,
                                prefixIcon: GradientIcon(icon: Icons.lock_rounded),
                                hintText: 'Confirm Password'),
                            SizedBox(height: 32.sdp),
                            GradientButton(
                              isLoading: state is RegistrationLoading ? state.isLoading : false,
                              buttonText: 'Sign Up',
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
      );
    }
    );
  }
}
