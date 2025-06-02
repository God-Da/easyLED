// lib/logic/home_controller.dart

import 'package:flutter/material.dart';
import 'setting_fontSize.dart';

/// HomeScreen의 상태(state)와 로직(handler)을 전부 관리하는 컨트롤러
class HomeController extends ChangeNotifier {
  // 1) 원본 텍스트, 화면용 텍스트, 색상, 폰트 크기, 움직임 모드 상태
  String _inputText   = '';
  String _displayText = '';
  Color  _textColor   = Colors.white;
  Color  _bgColor     = Colors.black;
  double _fontSize    = FontSizeController.defaultFontSize;
  String _movement    = "멈추기";

  // ▶ 외부에서 읽을 수 있도록 getter만 공개
  String get inputText   => _inputText;
  String get displayText => _displayText;
  Color  get textColor   => _textColor;
  Color  get bgColor     => _bgColor;
  double get fontSize    => _fontSize;
  String get movement    => _movement;

  /// 1) 사용자가 텍스트 입력 시 호출
  void setText(String value) {
    _inputText   = value;
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

  /// 4) 작게/크게 버튼 누를 때 폰트 크기 조정
  void adjustFontSize(bool increase, BoxConstraints constraints) {
    const baseStyle = TextStyle(
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w900,
    );

    if (_movement == "멈추기") {
      // (1) 원본 _inputText 기준으로 최적 줄 개수 계산
      final linesCount = FontSizeController.estimateOptimalLineCount(_inputText);

      // (2) 단어 단위로 분할해서 linesCount 만큼 줄바꿈 생성
      final lines = FontSizeController.splitTextByWords(_inputText, linesCount);
      final wrappedText = lines.join('\n');

      // (3) 기존 _fontSize에서 증감한 testSize 계산
      double testSize = increase ? _fontSize + 3 : _fontSize - 3;
      if (testSize < FontSizeController.minFontSize) {
        testSize = FontSizeController.minFontSize;
      }
      if (testSize > FontSizeController.maxFontSize) {
        testSize = FontSizeController.maxFontSize;
      }

      // (4) wrappedText + testSize로 실제로 표시했을 때 영역 내에 들어가는지 확인
      final painter = TextPainter(
        text: TextSpan(text: wrappedText, style: baseStyle.copyWith(fontSize: testSize)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        textWidthBasis: TextWidthBasis.parent,
      );
      painter.layout(maxWidth: constraints.maxWidth);

      if (painter.size.height <= constraints.maxHeight) {
        // (5) 영역을 넘지 않으면 실제 상태에 반영
        _displayText = wrappedText;
        _fontSize    = testSize;
        notifyListeners();
      }
      // 만약 영역을 넘으면 아무것도 하지 않아서 기존 상태 유지

    } else {
      // “흐르기” 모드: 줄바꿈 없이 단일 행만 고려
      final singleLine = _inputText.replaceAll('\n', '');
      double testSize = increase ? _fontSize + 3 : _fontSize - 3;
      if (testSize < FontSizeController.minFontSize) {
        testSize = FontSizeController.minFontSize;
      }
      if (testSize > FontSizeController.maxFontSize) {
        testSize = FontSizeController.maxFontSize;
      }

      final painter = TextPainter(
        text: TextSpan(text: singleLine, style: baseStyle.copyWith(fontSize: testSize)),
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        textWidthBasis: TextWidthBasis.parent,
      );
      painter.layout(maxWidth: constraints.maxWidth);

      if (painter.size.height <= constraints.maxHeight) {
        _displayText = singleLine;
        _fontSize    = testSize;
        notifyListeners();
      }
    }
  }

  /// 5) 자동 버튼 누를 때 폰트 + 줄바꿈 계산
  void autoFontSize(BoxConstraints constraints) {
    const styleBase = TextStyle(
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w900,
    );

    if (_movement == "흐르기") {
      final singleLine = _inputText.replaceAll('\n', '');
      final size = FontSizeController.calculateMaxFontSizeSingleLine(
        text: singleLine,
        maxWidth: constraints.maxWidth,
        maxHeight: constraints.maxHeight,
        baseStyle: styleBase,
      );
      _displayText = singleLine;
      _fontSize    = size;
    } else {
      final linesCount = FontSizeController.estimateOptimalLineCount(_inputText);
      final lines      = FontSizeController.splitTextByWords(_inputText, linesCount);
      final wrapped    = lines.join('\n');

      final adjustedSize = FontSizeController.calculateAutoFontSizeWithWrap(
        text: wrapped,
        maxWidth: constraints.maxWidth,
        maxHeight: constraints.maxHeight,
        baseStyle: styleBase,
      );
      _displayText = wrapped;
      _fontSize    = adjustedSize;
    }

    notifyListeners();
  }

  /// 6) 움직임(멈추기/흐르기) 변경
  void setMovement(String label) {
    _movement = label;
    if (_movement == "흐르기") {
      // 줄바꿈 제거
      _displayText = _inputText.replaceAll('\n', '');
    } else {
      _displayText = _inputText;
    }
    notifyListeners();
  }
}
