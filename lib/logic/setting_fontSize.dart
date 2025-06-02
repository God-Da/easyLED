// lib/logic/setting_fontSize.dart
// “폰트 크기 계산” 관련 헬퍼 함수 모음

import 'package:flutter/material.dart';

class FontSizeController {
  static const double defaultFontSize = 150.0;
  static const double minFontSize     = 10.0;
  static const double maxFontSize     = 300.0;

  /// “크게/작게” 버튼 → (단순 증감) 영역을 넘지 않도록 검사
  static double adjustFontSize({
    required String text,
    required double currentSize,
    required bool increase,
    required double maxWidth,
    required double maxHeight,
    required TextStyle baseStyle,
  }) {
    double newSize = increase ? currentSize + 3 : currentSize - 3;
    if (newSize < minFontSize || newSize > maxFontSize) {
      return currentSize;
    }

    final painter = TextPainter(
      text: TextSpan(text: text, style: baseStyle.copyWith(fontSize: newSize)),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      textWidthBasis: TextWidthBasis.parent,
    )..layout(maxWidth: maxWidth);

    return (painter.size.height <= maxHeight) ? newSize : currentSize;
  }

  /// “흐르기” 모드: 한 줄 기준 최대 폰트 크기(높이만 고려)
  static double calculateMaxFontSizeSingleLine({
    required String text,
    required double maxWidth,
    required double maxHeight,
    required TextStyle baseStyle,
  }) {
    double size = minFontSize;
    final painter = TextPainter(textDirection: TextDirection.ltr);
    while (size <= maxFontSize) {
      painter.text = TextSpan(text: text, style: baseStyle.copyWith(fontSize: size));
      painter.layout(maxWidth: maxWidth);
      if (painter.size.height > maxHeight) {
        return size - 1;
      }
      size += 1;
    }
    return maxFontSize;
  }

  /// “멈추기” 모드: 여러 줄로 줄 바꾼 문자열(text)을 최대 크기까지 반복 탐색
  static double calculateAutoFontSizeWithWrap({
    required String text,
    required double maxWidth,
    required double maxHeight,
    required TextStyle baseStyle,
  }) {
    double size = maxFontSize;
    final painter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      textWidthBasis: TextWidthBasis.parent,
    );
    while (size >= minFontSize) {
      painter.text = TextSpan(text: text, style: baseStyle.copyWith(fontSize: size));
      painter.layout(maxWidth: maxWidth);
      if (painter.size.height <= maxHeight) {
        return size;
      }
      size -= 1;
    }
    return minFontSize;
  }

  /// “단어 단위로 n줄로 나누기” 헬퍼
  static List<String> splitTextByWords(String text, int lineCount) {
    final words = text.split(' ');
    final lines = List<String>.filled(lineCount, '', growable: false);
    for (int i = 0; i < words.length; i++) {
      final idx = i % lineCount;
      lines[idx] += (lines[idx].isEmpty ? '' : ' ') + words[i];
    }
    return lines;
  }

  /// “적절한 줄 개수 추정” 헬퍼 (단어 수 기반)
  static int estimateOptimalLineCount(String text) {
    final wordCount = text.split(' ').length;
    if (wordCount <= 2) return 1;
    if (wordCount <= 4) return 2;
    if (wordCount <= 6) return 3;
    return 4;
  }
}
