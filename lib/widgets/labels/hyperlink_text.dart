import 'package:flutter/material.dart';

class HyperlinkText extends StatelessWidget {
  const HyperlinkText({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.w500,
    this.textAlign,
    this.fontSize,
    this.isEnable = true,
    this.showIndicator = false,
    this.color,
    this.onTap,
    this.textDecoration = TextDecoration.underline,
  });

  final String? text;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final Color? color;
  final double? fontSize;
  final Function()? onTap;
  final bool isEnable;
  final bool showIndicator;
  final TextDecoration textDecoration;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnable ? onTap : null,
      child: Wrap(
        children: [
          Text(text ?? "",
              textAlign: textAlign,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                  color: color,
                  decoration: textDecoration
              )),
          if (showIndicator)
            Icon(Icons.keyboard_arrow_right)
        ],
      ),
    );
  }
}
