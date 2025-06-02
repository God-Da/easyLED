// lib/logic/home_controller.dart
// “최종뷰(16:9) 기준 폰트 크기 계산 + 상태 관리”를 담당하는 ChangeNotifier 컨트롤러

import 'package:flutter/material.dart';

import 'setting_fontSize.dart';

class HomeController extends ChangeNotifier {
  // 1) 상태 변수
  String _inputText = ''; // 사용자가 입력한 원본 문자열
  String _displayText = ''; // 화면(미리보기/최종뷰)에 실제로 그려줄 문자열 (줄바꿈 포함)
  Color _textColor = Colors.white;
  Color _bgColor = Colors.black;
  double _fontSize = FontSizeController.defaultFontSize;
  String _movement = "멈추기"; // 기본값: 멈추기

  // ▼ 외부에서 읽어갈 수 있도록 getter 제공
  String get inputText => _inputText;

  String get displayText => _displayText;

  Color get textColor => _textColor;

  Color get bgColor => _bgColor;

  double get fontSize => _fontSize;

  String get movement => _movement;

  /// 1) 사용자가 텍스트 입력 시 호출
  void setText(String value) {
    _inputText = value;
    _displayText = value; // 입력이 바뀌면 displayText도 동기화
    notifyListeners();
  }

  /// 2) 글자색 변경
  void setTextColor(Color c) {
    _textColor = c;
    notifyListeners();
  }

  /// 3) 배경색 변경
  void setBgColor(Color c) {
    _bgColor = c;
    notifyListeners();
  }

  // 4) “작게/크게” 버튼: 최종뷰 크기(예: 1600×900) 기준으로 줄바꿈 + 폰트 크기 재계산
  void adjustFontSize(bool increase) {
    const styleBase = TextStyle(fontFamily: 'Pretendard', fontWeight: FontWeight.w900);
    final double W = 1600, H = 900;
    final minSize = FontSizeController.minFontSize;
    final maxSize = FontSizeController.maxFontSize;
    final words = _inputText.trim().split(RegExp(r'\s+'));

    // (1) 현재 줄 수 계산
    int curLines = _displayText.split('\n').length;
    int maxLines = words.length.clamp(1, 4);

    if (_movement == "흐르기") {
      // 한 줄만!
      String oneLine = _inputText.replaceAll('\n', '');
      double testSize = increase ? _fontSize + 3 : _fontSize - 3;
      if (testSize < minSize) testSize = minSize;
      if (testSize > maxSize) testSize = maxSize;

      final painter = TextPainter(
        text: TextSpan(text: oneLine, style: styleBase.copyWith(fontSize: testSize)),
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        textWidthBasis: TextWidthBasis.parent,
      )..layout(maxWidth: W);

      if (painter.size.height <= H) {
        _displayText = oneLine;
        _fontSize = testSize;
      }
      notifyListeners();
      return;
    }

    // (2) 멈추기 모드: 폰트 크기 up/down + 줄 수 조정
    if (increase) {
      // 크기 UP: 줄 수를 "줄여가며" 최대 크기
      for (int lines = curLines; lines >= 1; lines--) {
        final splitted = FontSizeController.splitTextByWords(_inputText, lines);
        final testWrapped = splitted.join('\n');
        double testSize = _fontSize + 3;
        if (testSize > maxSize) testSize = maxSize;

        final painter = TextPainter(
          text: TextSpan(text: testWrapped, style: styleBase.copyWith(fontSize: testSize)),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          textWidthBasis: TextWidthBasis.parent,
        )..layout(maxWidth: W);

        if (painter.size.height <= H) {
          _displayText = testWrapped;
          _fontSize = testSize;
          notifyListeners();
          return;
        }
      }
      // 만약 1줄로도 넘치면 그냥 1줄, 최대 폰트로 유지
      final testWrapped = FontSizeController.splitTextByWords(_inputText, 1).join('\n');
      _displayText = testWrapped;
      _fontSize = _fontSize + 3 > maxSize ? maxSize : _fontSize + 3;
      notifyListeners();
    } else {
      // 크기 DOWN: 줄 수를 "늘려가며" 최소 크기
      for (int lines = curLines; lines <= maxLines; lines++) {
        final splitted = FontSizeController.splitTextByWords(_inputText, lines);
        final testWrapped = splitted.join('\n');
        double testSize = _fontSize - 3;
        if (testSize < minSize) testSize = minSize;

        final painter = TextPainter(
          text: TextSpan(text: testWrapped, style: styleBase.copyWith(fontSize: testSize)),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          textWidthBasis: TextWidthBasis.parent,
        )..layout(maxWidth: W);

        if (painter.size.height <= H) {
          _displayText = testWrapped;
          _fontSize = testSize;
          notifyListeners();
          return;
        }
      }
      // 최대로 줄 수 늘려도 안 맞으면, 마지막 줄 수/폰트 유지
      final testWrapped = FontSizeController.splitTextByWords(_inputText, maxLines).join('\n');
      _displayText = testWrapped;
      _fontSize = _fontSize - 3 < minSize ? minSize : _fontSize - 3;
      notifyListeners();
    }
  }



  /// 5) “자동” 버튼: 최종뷰 크기(예: 1600×900)에서 최대 폰트 크기 한 번에 계산
  void autoFontSize() {
    const styleBase = TextStyle(
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w900,
    );

    final double finalWidth = 1600;
    final double finalHeight = 900;

    if (_movement == "흐르기") {
      final singleLine = _inputText.replaceAll('\n', '');
      final size = FontSizeController.calculateMaxFontSizeSingleLine(
        text: singleLine,
        maxWidth: finalWidth,
        maxHeight: finalHeight,
        baseStyle: styleBase,
      );
      _displayText = singleLine;
      _fontSize = size;
    } else {
      final linesCount = FontSizeController.estimateOptimalLineCount(
        _inputText,
      );
      final lines = FontSizeController.splitTextByWords(_inputText, linesCount);
      final wrapped = lines.join('\n');

      final size = FontSizeController.calculateAutoFontSizeWithWrap(
        text: wrapped,
        maxWidth: finalWidth,
        maxHeight: finalHeight,
        baseStyle: styleBase,
      );
      _displayText = wrapped;
      _fontSize = size;
    }

    notifyListeners();
  }

  // 6) “멈추기/흐르기” 상태 토글 → displayText 재설정
  void setMovement(String label) {
    _movement = label;
    if (_movement == "흐르기") {
      _displayText = _inputText.replaceAll('\n', '');
    } else {
      // ★ 움직임이 "멈추기"로 바뀔 때도 항상 줄바꿈 적용
      final linesCount = FontSizeController.estimateOptimalLineCount(
        _inputText,
      );
      final lines = FontSizeController.splitTextByWords(_inputText, linesCount);
      _displayText = lines.join('\n');
    }
    notifyListeners();
  }
}
