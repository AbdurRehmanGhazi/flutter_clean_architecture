import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  final String? text;
  final Color? color;
  final TextAlign? align;
  final FontWeight? weight;
  final double? fontSize;

  const TitleText({
    super.key,
    required this.text,
    this.color,
    this.align,
    this.weight = FontWeight.w400,
    this.fontSize= 18
  });

  @override
  Widget build(BuildContext context) {
    return Text(text ?? '',
        textAlign: align,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: weight,
          color: color,
        ));
  }
}
