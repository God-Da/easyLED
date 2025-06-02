import 'package:flutter/material.dart';

class FontSizeController {
  static const double defaultFontSize = 25.0;
  static const double minFontSize = 10.0;
  static const double maxFontSize = 500.0;

  /// [작게]/[크게] 버튼 눌렀을 때 높이 초과 방지 포함
  static double adjustFontSize({
    required String text,
    required double currentSize,
    required bool increase,
    required double maxWidth,
    required double maxHeight,
    required TextStyle baseStyle,
  }) {
    double newSize = increase ? currentSize + 5 : currentSize - 5;

    if (newSize < minFontSize || newSize > maxFontSize) {
      return currentSize;
    }

    final painter = TextPainter(
      text: TextSpan(text: text, style: baseStyle.copyWith(fontSize: newSize)),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      textWidthBasis: TextWidthBasis.parent,
      maxLines: null,
    );

    painter.layout(maxWidth: maxWidth);

    if (painter.size.height > maxHeight) {
      return currentSize;
    }

    return newSize;
  }

  /// 흐르기 상태 → 한 줄 기준 최대 폰트 크기 (높이 기준만 고려)
  static double calculateMaxFontSizeSingleLine({
    required String text,
    required double maxWidth,
    required double maxHeight,
    required TextStyle baseStyle,
  }) {
    double fontSize = minFontSize;
    final painter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    );

    while (fontSize <= maxFontSize) {
      final style = baseStyle.copyWith(fontSize: fontSize);
      painter.text = TextSpan(text: text, style: style);
      painter.layout(maxWidth: double.infinity);

      if (painter.size.height > maxHeight) {
        return fontSize - 1;
      }

      fontSize += 1;
    }

    return maxFontSize;
  }

  /// 멈추기 상태 → 줄바꿈 포함 최적 줄 수 + 최대 폰트 크기 계산
  static double calculateAutoFontSizeWithWrap({
    required String text,
    required double maxWidth,
    required double maxHeight,
    required TextStyle baseStyle,
  }) {
    double bestFontSize = minFontSize;
    int maxLines = text.length;

    for (int lineCount = 1; lineCount <= maxLines; lineCount++) {
      List<String> lines = splitTextToLines(text, lineCount);
      String joined = lines.join('\n');

      double testSize = maxFontSize;
      while (testSize >= minFontSize) {
        final painter = TextPainter(
          text: TextSpan(text: joined, style: baseStyle.copyWith(fontSize: testSize)),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          textWidthBasis: TextWidthBasis.parent,
          maxLines: null,
        );
        painter.layout(maxWidth: maxWidth);

        if (painter.size.height <= maxHeight) {
          if (testSize > bestFontSize) {
            bestFontSize = testSize;
          }
          break;
        }

        testSize -= 1;
      }
    }

    return bestFontSize;
  }

  /// 문자열을 줄 수에 따라 나누기
  static List<String> splitTextToLines(String text, int lineCount) {
    int avg = (text.length / lineCount).ceil();
    List<String> lines = [];
    for (int i = 0; i < text.length; i += avg) {
      lines.add(text.substring(i, (i + avg).clamp(0, text.length)));
    }
    return lines;
  }
}