import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Text(text ?? '',
        textAlign: align,
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ));
  }
}
