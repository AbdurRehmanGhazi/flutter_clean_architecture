import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/textfields/custom_otp_field.dart';
import '../../../../core/widgets/textfields/custom_text_field.dart';
import '../../../../core/widgets/buttons/gradient_button.dart';
import '../../../../core/widgets/gradient_icon.dart';
import '../../../../core/widgets/labels/title_text.dart';
import '../../../../core/utils/show_snackbar.dart';
import '../../../../features/auth/domain/usecases/registration_usecase.dart';
import '../../../../features/auth/presentation/bloc/registration/registration_bloc.dart';
import '../../../../configs/injector/init_dependencies.dart';
import '../../../../main.dart';
import '../../../../rounter/route_utils.dart';

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
  final TextEditingController nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  String _pinCode = '';

  _navToMobileNumberVerificationScreen(BuildContext context) {
    if (formKey.currentState!.validate() && _pinCode.length == 4) {
      context.read<RegistrationBloc>().add(UserRegistrationEvent(
            phone: widget.mobileNumber,
            code: _pinCode,
            name: nameController.text.trim(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
      if (state is RegistrationSuccess) {
        context.go(APP_PAGE.welcome.toPath);
        Timer(const Duration(milliseconds: 500), () => showSnackBar('Registration Complete Successfully!', globalNavigatorKey.currentContext));
      } else if (state is RegistrationFailure) {
        showSnackBar(state.message, context);
      }
    },
    builder: (context, state) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(children: [
                  const GradientIcon(icon: Icons.app_registration, size: 120,),
                  const SizedBox(height: 16),
                  const TitleText(text: 'Registration'),
                  const SizedBox(height: 32),
                  CustomTextField(
                      textEditingController: nameController, hintText: 'Name'),
                  const SizedBox(height: 32),
                  CustomOtpField(
                    numberOfFields: 4,
                    onChange: (code) {
                      _pinCode = '';
                    },
                    onSubmit: (code) {
                      _pinCode = code;
                    },
                  ),
                  const SizedBox(height: 32),
                  GradientButton(
                    isLoading: state is RegistrationLoading ? state.isLoading : false,
                    buttonText: 'Send',
                    onPressed: () => _navToMobileNumberVerificationScreen(context),
                  ),
                ],),
              ),
            ),
          ),
        ),
      );
    }
    );
  }
}
