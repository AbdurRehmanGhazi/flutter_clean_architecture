import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/theme/app_pallete.dart';
import '../loader.dart';


class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.buttonText,
    required this.onPressed,
    this.isLoading = false,
    this.isEnable = true,
    this.height = 50,
  });

  final String buttonText;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isEnable;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnable && !isLoading ? onPressed : null,
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
        backgroundColor: WidgetStatePropertyAll(isEnable ? AppPalette.primaryColor : AppPalette.unselectedItemColor),
        shadowColor: WidgetStatePropertyAll(Colors.transparent),
        padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 0, horizontal: 12)),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
          side: BorderSide(color: isEnable ? AppPalette.primaryColor : AppPalette.unselectedItemColor),
        )),
        minimumSize: WidgetStatePropertyAll(Size(double.minPositive, height)), // Full width with defined height
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: isLoading ? 0.0 : 1.0, // Hide text when loading
            child: Text(buttonText),
          ),
          if (isLoading)
            Positioned(
              child: SizedBox(
                height: height * 0.6,
                width: height * 0.6,
                child: const Loader(),
              ),
            ),
        ],
      ),
    );
  }
}

/*
 @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
          color: isLoading
              ? AppPalette.transparentColor
              : isEnable ? AppPalette.primaryColor : AppPalette.unselectedItemColor,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppPalette.primaryColor)),
      child: isLoading
          ? const Loader()
          : ElevatedButton(
        onPressed: isEnable ? onPressed : null,
        style: ElevatedButton.styleFrom(
            backgroundColor: AppPalette.transparentColor,
            shadowColor: AppPalette.transparentColor,
            padding: EdgeInsets.zero
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: AppPalette.primaryButtonTextColor,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
 */