import 'package:flutter/material.dart';
import 'setting_fontSize.dart';

class HomeController extends ChangeNotifier {
  String _inputText = '';
  String _displayText = '';
  Color _textColor = Colors.white;
  Color _bgColor = Colors.black;
  double _fontSize = FontSizeController.defaultFontSize;
  String _movement = "멈추기";
  double fontSizeStep=10;

  String get inputText => _inputText;
  String get displayText => _displayText;
  Color get textColor => _textColor;
  Color get bgColor => _bgColor;
  double get fontSize => _fontSize;
  String get movement => _movement;

  void setText(String value) {
    _inputText = value;
    if (_movement == "흐르기") {
      _displayText = value.replaceAll('\n', ' ');
    } else {
      final linesCount = FontSizeController.estimateOptimalLineCount(value);
      final lines = FontSizeController.splitTextByWords(value, linesCount);
      _displayText = lines.join('\n');
    }
    notifyListeners();
  }

  void setTextColor(Color c) {
    _textColor = c;
    notifyListeners();
  }

  void setBgColor(Color c) {
    _bgColor = c;
    notifyListeners();
  }

  /// 폰트 크기 조절 - 동작 방식 완전 분리!
  void adjustFontSize(bool increase) {
    const styleBase = TextStyle(fontFamily: 'Pretendard', fontWeight: FontWeight.w900);
    final double W = 1600, H = 900;
    final minSize = FontSizeController.minFontSize;
    final maxSize = FontSizeController.maxFontSize;
    final words = _inputText.trim().split(RegExp(r'\s+'));

    // 흐르기: 무조건 한 줄, 높이만 조정
    if (_movement == "흐르기") {
      String oneLine = _inputText.replaceAll('\n', ' ');
      double testSize = increase ? _fontSize + fontSizeStep : _fontSize -fontSizeStep;
      if (testSize < minSize) testSize = minSize;
      if (testSize > maxSize) testSize = maxSize;

      final painter = TextPainter(
        text: TextSpan(text: oneLine, style: styleBase.copyWith(fontSize: testSize)),
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        textWidthBasis: TextWidthBasis.parent,
      )..layout(maxWidth: W);

      // 높이만 체크
      if (painter.size.height <= H) {
        _displayText = oneLine;
        _fontSize = testSize;
      }
      notifyListeners();
      return;
    }

    // 멈추기: 줄바꿈 조정하며 폰트 증감, 어순 절대 유지!
    int maxLines = words.length.clamp(1, 4);
    int curLines = _displayText.split('\n').length;

    if (increase) {
      // 크게: 줄 수를 줄여가며, 최대 폰트 찾기
      for (int lines = curLines; lines >= 1; lines--) {
        final splitted = FontSizeController.splitTextByWords(_inputText, lines);
        final testWrapped = splitted.join('\n');
        double testSize = _fontSize + fontSizeStep;
        if (testSize > maxSize) testSize = maxSize;

        final painter = TextPainter(
          text: TextSpan(text: testWrapped, style: styleBase.copyWith(fontSize: testSize)),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          textWidthBasis: TextWidthBasis.parent,
        )..layout(maxWidth: W);

        if (painter.size.height <= H && painter.size.width <= W) {
          _displayText = testWrapped;
          _fontSize = testSize;
          notifyListeners();
          return;
        }
      }
      // 1줄로도 안 되면 최소 줄수/최대 폰트 유지
      final testWrapped = FontSizeController.splitTextByWords(_inputText, 1).join('\n');
      _displayText = testWrapped;
      _fontSize = (_fontSize + fontSizeStep > maxSize) ? maxSize : _fontSize + fontSizeStep;
      notifyListeners();
    } else {
      // 작게: 줄 수를 늘려가며, 최소 폰트 찾기
      for (int lines = curLines; lines <= maxLines; lines++) {
        final splitted = FontSizeController.splitTextByWords(_inputText, lines);
        final testWrapped = splitted.join('\n');
        double testSize = _fontSize -fontSizeStep;
        if (testSize < minSize) testSize = minSize;

        final painter = TextPainter(
          text: TextSpan(text: testWrapped, style: styleBase.copyWith(fontSize: testSize)),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          textWidthBasis: TextWidthBasis.parent,
        )..layout(maxWidth: W);

        if (painter.size.height <= H && painter.size.width <= W) {
          _displayText = testWrapped;
          _fontSize = testSize;
          notifyListeners();
          return;
        }
      }
      // 최대 줄수/최소 폰트 유지
      final testWrapped = FontSizeController.splitTextByWords(_inputText, maxLines).join('\n');
      _displayText = testWrapped;
      _fontSize = (_fontSize -fontSizeStep < minSize) ? minSize : _fontSize -fontSizeStep;
      notifyListeners();
    }
  }

  /// 자동: 멈추기 - 여러 줄로, 흐르기 - 한 줄로, 최대 폰트 찾기
  void autoFontSize() {
    const styleBase = TextStyle(fontFamily: 'Pretendard', fontWeight: FontWeight.w900);
    final double W = 1600, H = 900;

    if (_movement == "흐르기") {
      final singleLine = _inputText.replaceAll('\n', ' ');
      final size = FontSizeController.calculateMaxFontSizeSingleLine(
        text: singleLine,
        maxWidth: W,
        maxHeight: H,
        baseStyle: styleBase,
      );
      _displayText = singleLine;
      _fontSize = size;
      notifyListeners();
      return;
    }

    // 멈추기: 1~maxLines 중 최대 폰트 조합 찾기
    final words = _inputText.trim().split(RegExp(r'\s+'));
    int maxLines = words.length.clamp(1, 4);

    double bestFontSize = FontSizeController.minFontSize;
    String bestWrapped = _inputText;
    for (int lines = 1; lines <= maxLines; lines++) {
      final splitted = FontSizeController.splitTextByWords(_inputText, lines);
      final testWrapped = splitted.join('\n');
      final size = FontSizeController.calculateAutoFontSizeWithWrap(
        text: testWrapped,
        maxWidth: W,
        maxHeight: H,
        baseStyle: styleBase,
      );
      if (size > bestFontSize) {
        bestFontSize = size;
        bestWrapped = testWrapped;
      }
    }
    _displayText = bestWrapped;
    _fontSize = bestFontSize;
    notifyListeners();
  }

  /// 모드 변경시 줄바꿈/한줄 재적용
  void setMovement(String label) {
    _movement = label;
    if (_movement == "흐르기") {
      _displayText = _inputText.replaceAll('\n', ' ');
    } else {
      final words = _inputText.trim().split(RegExp(r'\s+'));
      int maxLines = words.length.clamp(1, 4);
      final lines = FontSizeController.splitTextByWords(_inputText, maxLines);
      _displayText = lines.join('\n');
    }
    notifyListeners();
  }

  // 나머지(초기화 등)
  void resetAll() {
    _textColor = Colors.white;
    _bgColor = Colors.black;
    _fontSize = FontSizeController.defaultFontSize;
    _movement = "멈추기";
    _displayText = _inputText;
    notifyListeners();
  }
  void resetFontSize() {
    _fontSize = FontSizeController.defaultFontSize;
    notifyListeners();
  }
  void resetTextColor() {
    _textColor = Colors.white;
    notifyListeners();
  }
  void resetBgColor() {
    _bgColor = Colors.black;
    notifyListeners();
  }
  void resetMovement() {
    _movement = "멈추기";
    notifyListeners();
  }
}
