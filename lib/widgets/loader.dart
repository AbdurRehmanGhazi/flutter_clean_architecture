import 'package:flutter/material.dart';
import '../core/theme/app_pallete.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.75,
      child: Center(
        child: CircularProgressIndicator(color: color ?? AppPalette.whiteColor),
      ),
    );
  }
}
