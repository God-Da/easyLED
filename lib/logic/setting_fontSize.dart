import 'package:flutter/material.dart';

class FontSizeController {
  static const double defaultFontSize = 25.0;
  static const double minFontSize = 10.0;
  static const double maxFontSize = 100.0;

  /// 현재 폰트 크기 기준 +5 또는 -5 조정
  static double adjustFontSize(double current, bool increase) {
    if (increase && current < maxFontSize) {
      return current + 5;
    } else if (!increase && current > minFontSize) {
      return current - 5;
    }
    return current;
  }
}
