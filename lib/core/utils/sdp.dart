import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/core/utils/extensions/buld_context.dart';

class SDP {
  static late double width;

  static void init(BuildContext context) {
    width = !context.isTabletOrIpad ? context.shortestSide : context.shortestSide*3/4;
    print("width $width");
  }

  static double calculateSdp(double dp) {
    const double referenceWidth = 440; // Adjust based on your design phone width
    return (dp / referenceWidth) * width;
  }
}

extension SDPExtensionInt on int {
  double get sdp => SDP.calculateSdp(toDouble());
  // double get sdp => toDouble();
}

extension SDPExtensionDouble on double {
  double get sdp => SDP.calculateSdp(this);
  // double get sdp => this;
}
