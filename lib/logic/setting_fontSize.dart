import 'package:flutter/material.dart';

class FontSizeController {
  static const double defaultFontSize = 25.0;
  static const double minFontSize = 10.0;
  static const double maxFontSize = 100.0;

  /// 단순 계산: 현재 폰트 크기 기준 +5 또는 -5 조정
  static double adjustFontSize(double current, bool increase) {
    if (increase && current < maxFontSize) {
      return current + 5;
    } else if (!increase && current > minFontSize) {
      return current - 5;
    }
    return current;
  }

  // 자동 : 화면에 맞춰 들어갈 수 있는 최대 폰트 크기 계산
  static double calculateMaxFontSize({
    required String text,
    required double maxWidth,
    required double maxHeight,
    required TextStyle baseStyle,
    double step = 1,
  }) {
    double fontSize = minFontSize;
    final TextPainter painter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    while (fontSize <= maxFontSize) {
      final style = baseStyle.copyWith(fontSize: fontSize);
      painter.text = TextSpan(text: text, style: style);
      painter.layout(maxWidth: maxWidth);

      if (painter.size.height > maxHeight || painter.size.width > maxWidth) {
        return fontSize - step; // 넘으면 한 단계 전 사이즈로
      }

      fontSize += step;
    }

    return maxFontSize;
  }
}