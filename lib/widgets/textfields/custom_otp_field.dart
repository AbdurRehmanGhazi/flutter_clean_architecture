import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';

import '../../core/theme/app_pallete.dart';

class CustomOtpField extends StatefulWidget {
  final bool isEnabled;
  final int numberOfFields;
  final void Function(String) onSubmit;
  final void Function(String) onChange;

  const CustomOtpField({
    super.key,
    required this.numberOfFields,
    required this.onSubmit,
    required this.onChange,
    this.isEnabled = true,
  });

  @override
  State<CustomOtpField> createState() => _CustomOtpFieldState();
}

class _CustomOtpFieldState extends State<CustomOtpField> {
  late final TextEditingController pinController;
  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    pinController = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final errorBorderColor = AppPalette.warningColor;
    final borderColor = widget.isEnabled
        ? AppPalette.primaryColor
        : AppPalette.primaryColor.withOpacity(0.5);
    final bottomBorderWidth = 4.0;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
        fontSize: 22,
        color: AppPalette.textFieldTitleColor, // Set the text color to black
      ),
      decoration: BoxDecoration(
        color: widget.isEnabled ? AppPalette.textFieldBGColor : AppPalette.unselectedItemColor,
        // Keep the box color white for both filled and unfilled states
        border: Border(
          bottom: BorderSide(
              color: borderColor,
              width: bottomBorderWidth), // 2 px bottom border
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4), // Border radius for the top-left corner
          topRight:
          Radius.circular(4), // Border radius for the top-right corner
        ),
      ),
    );

    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Directionality(
            textDirection: TextDirection.ltr,
            child: LayoutBuilder(
              builder: (context, constraints) => Pinput(
                  enabled: widget.isEnabled,
                  controller: pinController,
                  focusNode: focusNode,
                  length: widget.numberOfFields,
                  defaultPinTheme: defaultPinTheme.copyWith(
                      width: (constraints.maxWidth / widget.numberOfFields)),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    // Allow only digits
                  ],
                  keyboardType: TextInputType.number,
                  separatorBuilder: (index) => const SizedBox(width: 8),
                  // validator: (value) {
                  //   return value == '2222' ? null : 'Pin is incorrect';
                  // },
                  hapticFeedbackType: HapticFeedbackType.lightImpact,
                  onCompleted: (pin) {
                    widget.onSubmit(pin); // Submit callback
                  },
                  onChanged: (value) {
                    debugPrint('onChanged: $value');
                    widget.onChange(value); // Submit callback
                  },
                  cursor: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 9),
                        width: 22,
                        height: 2,
                        color: borderColor,
                      ),
                    ],
                  ),
                  focusedPinTheme: defaultPinTheme.copyWith(
                    width: (constraints.maxWidth / widget.numberOfFields),
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border(
                        bottom: BorderSide(
                            color: borderColor, width: bottomBorderWidth),
                      ),
                    ),
                  ),
                  submittedPinTheme: defaultPinTheme.copyWith(
                    width: (constraints.maxWidth / widget.numberOfFields),
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border(
                        bottom: BorderSide(
                            color: borderColor, width: bottomBorderWidth),
                      ),
                    ),
                  ),
                  errorPinTheme: defaultPinTheme.copyWith(
                    width: (constraints.maxWidth / widget.numberOfFields),
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border(
                        bottom: BorderSide(
                            color: errorBorderColor, width: bottomBorderWidth),
                      ),
                    ),
                  ),
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
