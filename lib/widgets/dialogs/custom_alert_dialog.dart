import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/constants/svgs_path.dart';
import 'package:flutter_clean_architecture/core/utils/extensions/buld_context.dart';
import 'package:flutter_clean_architecture/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_clean_architecture/widgets/gradient_icon.dart';
import 'package:flutter_clean_architecture/widgets/labels/description_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/sdp.dart';
import '../../../../widgets/textfields/custom_text_field.dart';
import '../../../../widgets/buttons/gradient_button.dart';
import '../../../../widgets/labels/title_text.dart';
import '../../../../features/auth/presentation/bloc/mobile_number_verification_bloc/mobile_number_verification_bloc.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String yesButtonTitle;
  final String noButtonTitle;
  final VoidCallback onYesPressed;
  final VoidCallback onNoPressed;

  final TextEditingController mobileNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.yesButtonTitle = 'Yes',
    this.noButtonTitle = 'No',
    required this.onYesPressed,
    required this.onNoPressed,
  });

  _validateInputs(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<MobileNumberVerificationBloc>().add(VerifyMobileNumberEvent(
          mobileNumber: mobileNumberController.text.trim()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.sdp),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 28.sdp, horizontal: 16.sdp),
        child: IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientIcon(icon: Icons.check_circle_outline_rounded, size: 60.sdp),
              SizedBox(height: 12.sdp),
              TitleText(text: title, fontSize: 18.sdp, fontWeight: FontWeight.w500,),
              SizedBox(height: 12.sdp),
              DescriptionText(text: content, overflow: TextOverflow.visible, textAlign: TextAlign.center),
              SizedBox(height: 36.sdp),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IntrinsicWidth(
                    stepWidth: 120.sdp,
                    child: GradientButton(
                        buttonText: yesButtonTitle,
                        height: 42,
                        onPressed: () {
                          context.pop();
                          onYesPressed();
                        }),
                  ),
                  IntrinsicWidth(
                    stepWidth: 120.sdp,
                    child: GradientButton(
                        buttonText: noButtonTitle,
                        height: 42,
                        onPressed: () {
                          context.pop();
                          onNoPressed();
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
