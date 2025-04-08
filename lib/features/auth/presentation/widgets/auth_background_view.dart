import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/constants/svgs_path.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthBackgroundView extends StatelessWidget {
  const AuthBackgroundView({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: SvgPicture.asset(SvgsPath.topLeftArc),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: SvgPicture.asset(SvgsPath.bottomRightArc),
        ),
        child
      ],
    );
  }
}
