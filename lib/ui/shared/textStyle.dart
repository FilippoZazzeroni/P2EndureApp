import 'package:flutter/material.dart';
import 'package:p2Endure/ui/shared/colors.dart';

class TextStyles {
  static TextStyle style(
      {Color color = PColors.deepBlue,
      double size = 14,
      FontWeight weight = FontWeight.normal}) {
    return TextStyle(color: color, fontSize: size, fontWeight: weight);
  }
}
