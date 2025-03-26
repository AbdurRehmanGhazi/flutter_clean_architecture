import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
  final String? text;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final Color? color;
  final double? fontSize;
  final TextOverflow? overflow;

  const DescriptionText({
    super.key,
    required this.text,
    this.fontWeight,
    this.textAlign,
    this.fontSize,
    this.overflow = TextOverflow.ellipsis,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text ?? "",
        textAlign: textAlign,
        overflow: overflow,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ));
  }
}
