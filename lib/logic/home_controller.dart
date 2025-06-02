import 'package:flutter/material.dart';
import 'setting_fontSize.dart';

/// HomeScreen의 상태(state)와 로직(handler)을 전부 관리하는 컨트롤러
class HomeController extends ChangeNotifier {
  // 1) 원본 텍스트, 화면용 텍스트, 색상, 폰트 크기, 움직임 모드 상태
  String _inputText = '';
  String _displayText = '';
  Color _textColor = Colors.white;
  Color _bgColor = Colors.black;
  double _fontSize = FontSizeController.defaultFontSize;
  String _movement = "멈추기";

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
      final newSize = FontSizeController.adjustFontSize(
        text: _displayText,
        currentSize: _fontSize,
        increase: increase,
        maxWidth: constraints.maxWidth,
        maxHeight: constraints.maxHeight,
        baseStyle: baseStyle,
      );
      _fontSize = newSize;
    } else {
      final singleLine = _displayText.replaceAll('\n', '');
      final newSize = FontSizeController.adjustFontSize(
        text: singleLine,
        currentSize: _fontSize,
        increase: increase,
        maxWidth: constraints.maxWidth,
        maxHeight: constraints.maxHeight,
        baseStyle: baseStyle,
      );
      _fontSize = newSize;
    }

    notifyListeners();
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
