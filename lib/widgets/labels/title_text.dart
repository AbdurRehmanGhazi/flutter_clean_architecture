import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/theme/app_colors.dart';

class TitleText extends StatelessWidget {
  final String? text;
  final Color? color;
  final TextAlign? align;
  final FontWeight? fontWeight;
  final double? fontSize;

  const TitleText({
    super.key,
    required this.text,
    this.color,
    this.align,
    this.fontWeight,
    this.fontSize,
  });

  Text _getTextWidget(BuildContext context) => Text(
        text ?? '',
        textAlign: align,
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: color,
            ),
      );

  @override
  Widget build(BuildContext context) {
    return color != null
        ? _getTextWidget(context)
        : ShaderMask(
            shaderCallback: (Rect bounds) => LinearGradient(
              colors: [AppColors.gradient1, AppColors.gradient2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),
            child: _getTextWidget(context),
          );
  }
}
