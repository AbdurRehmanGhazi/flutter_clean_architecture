import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class GradientIcon extends StatelessWidget {
  const GradientIcon({
    super.key,
    required this.icon,
    this.size = 24,
  });

  final IconData icon;
  final double? size;
  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [AppColors.gradient1, AppColors.gradient2,],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ).createShader(bounds);
      },
      child: Icon(
        icon,
        size: size,
        color: Colors.white, // Must be white for ShaderMask to work
      ),
    );
  }
}
