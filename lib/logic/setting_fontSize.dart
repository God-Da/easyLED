import 'package:flutter/material.dart';

class FontSizeController {
  static const double defaultFontSize = 25.0;
  static const double minFontSize = 10.0;
  static const double maxFontSize = 300.0;

  static double adjustFontSize({
    required String text,
    required double currentSize,
    required bool increase,
    required double maxWidth,
    required double maxHeight,
    required TextStyle baseStyle,
  }) {
    double newSize = increase ? currentSize + 3 : currentSize - 3;
    if (newSize < minFontSize || newSize > maxFontSize) return currentSize;

    final painter = TextPainter(
      text: TextSpan(text: text, style: baseStyle.copyWith(fontSize: newSize)),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      textWidthBasis: TextWidthBasis.parent,
    )..layout(maxWidth: maxWidth);

    return (painter.size.height <= maxHeight) ? newSize : currentSize;
  }

  static double calculateMaxFontSizeSingleLine({
    required String text,
    required double maxWidth,
    required double maxHeight,
    required TextStyle baseStyle,
  }) {
    double size = minFontSize;
    final painter = TextPainter(textDirection: TextDirection.ltr);
    while (size < maxFontSize) {
      painter.text = TextSpan(text: text, style: baseStyle.copyWith(fontSize: size));
      painter.layout(maxWidth: maxWidth);
      if (painter.size.height > maxHeight) return size - 1;
      size += 1;
    }
    return size;
  }

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
      if (painter.size.height <= maxHeight) return size;
      size -= 1;
    }
    return minFontSize;
  }

  static List<String> splitTextByWords(String text, int lineCount) {
    final words = text.split(' ');
    final lines = List<String>.filled(lineCount, '', growable: false);

    for (int i = 0; i < words.length; i++) {
      lines[i % lineCount] += (lines[i % lineCount].isEmpty ? '' : ' ') + words[i];
    }

    return lines;
  }

  static int estimateOptimalLineCount(String text) {
    final wordCount = text.split(' ').length;
    if (wordCount <= 2) return 1;
    if (wordCount <= 4) return 2;
    if (wordCount <= 6) return 3;
    return 4;
  }
}
