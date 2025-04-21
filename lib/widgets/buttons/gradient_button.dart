import 'package:flutter/material.dart';
import '../../core/utils/sdp.dart';
import '../../core/theme/app_colors.dart';
import '../loader.dart';

class GradientButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double height;
  final bool isLoading;

  const GradientButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.height = 55,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height.sdp,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
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
          backgroundColor: WidgetStatePropertyAll(Colors.transparent),
          shadowColor: WidgetStatePropertyAll(Colors.transparent),
          textStyle: WidgetStatePropertyAll(TextStyle(
            fontSize: 16.sdp,
            fontWeight: FontWeight.w500,
          ))
        ),
        child: Text(buttonText),
      ),
    );
  }
}
