import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../loader.dart';

class GradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final bool isLoading;

  const GradientButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.gradient1,
            AppColors.gradient2,
            // AppPallete.gradient3,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: isLoading ? Loader() : ElevatedButton(
        onPressed: onPressed,
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
          // fixedSize: const Size(395, 55),
          backgroundColor: WidgetStatePropertyAll(AppColors.transparentColor),
          shadowColor: WidgetStatePropertyAll(AppColors.transparentColor),
          textStyle: WidgetStatePropertyAll(TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ))
        ),
        child: Text(buttonText),
      ),
    );
  }
}
