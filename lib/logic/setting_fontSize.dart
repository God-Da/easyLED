import 'package:flutter/material.dart';

class FontSizeController {
  static const double defaultFontSize = 150.0;
  static const double minFontSize = 10.0;
  static const double maxFontSize = 300.0;

  /// (어순 보장!) 단어 단위로 n줄로 나누기
  static List<String> splitTextByWords(String text, int lineCount) {
    final words = text.trim().split(RegExp(r'\s+'));
    if (lineCount < 1) lineCount = 1;
    if (words.isEmpty) return [''];

    final int base = words.length ~/ lineCount;
    final int extra = words.length % lineCount;

    List<String> lines = [];
    int idx = 0;
    for (int i = 0; i < lineCount; i++) {
      int take = base + (i < extra ? 1 : 0); // 앞에서부터 1개씩 더 배분
      lines.add(words.sublist(idx, idx + take).join(' '));
      idx += take;
    }
    return lines;
  }

  /// 단어 개수 기반 최대 줄 수 (너무 많으면 4줄 제한)
  static int estimateOptimalLineCount(String text) {
    final wordCount = text.trim().split(RegExp(r'\s+')).length;
    if (wordCount <= 2) return 1;
    if (wordCount <= 4) return 2;
    if (wordCount <= 6) return 3;
    return 4;
  }

  /// 한 줄(흐르기)에서 높이에 맞는 최대 폰트 찾기
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

  /// 멈추기에서 여러 줄 줄바꿈된 문자열의 최대 폰트 크기 찾기
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
      if (painter.size.height <= maxHeight && painter.size.width <= maxWidth) {
        return size;
      }
      size -= 1;
    }
    return minFontSize;
  }
}
