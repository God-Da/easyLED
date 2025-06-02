// lib/logic/home_controller.dart
// “최종뷰(16:9) 기준 폰트 크기 계산 + 상태 관리”를 담당하는 ChangeNotifier 컨트롤러

import 'package:flutter/material.dart';
import 'setting_fontSize.dart';

class HomeController extends ChangeNotifier {
  // 1) 상태 변수
  String _inputText   = '';  // 사용자가 입력한 원본 문자열
  String _displayText = '';  // 화면(미리보기/최종뷰)에 실제로 그려줄 문자열 (줄바꿈 포함)
  Color  _textColor   = Colors.white;
  Color  _bgColor     = Colors.black;
  double _fontSize    = FontSizeController.defaultFontSize;
  String _movement    = "멈추기"; // 기본값: 멈추기

  // ▼ 외부에서 읽어갈 수 있도록 getter 제공
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

  /// 4) “작게/크게” 버튼: 최종뷰 크기(예: 1600×900) 기준으로 줄바꿈 + 폰트 크기 재계산
  void adjustFontSize(bool increase) {
    const styleBase = TextStyle(
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w900,
    );

    // ── (예시) 최종뷰의 가로×세로 픽셀 단위. 실제 기기에 맞추려면 별도 상수 혹은 매개변수로 치환하세요. ──
    final double finalWidth  = 1600;
    final double finalHeight = 900;

    if (_movement == "흐르기") {
      // “흐르기” 모드: 줄바꿈 없이 한 줄만 고려
      final singleLine = _inputText.replaceAll('\n', '');

      double testSize = increase ? _fontSize + 3 : _fontSize - 3;
      if (testSize < FontSizeController.minFontSize) testSize = FontSizeController.minFontSize;
      if (testSize > FontSizeController.maxFontSize) testSize = FontSizeController.maxFontSize;

      final painter = TextPainter(
        text: TextSpan(text: singleLine, style: styleBase.copyWith(fontSize: testSize)),
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        textWidthBasis: TextWidthBasis.parent,
      )..layout(maxWidth: finalWidth);

      if (painter.size.height <= finalHeight) {
        _displayText = singleLine;
        _fontSize    = testSize;
        notifyListeners();
      }
    } else {
      // “멈추기” 모드: 최적 줄 개수 계산 → 단어 단위로 분할 → 줄바꿈된 문자열(wrapped) 생성
      final linesCount = FontSizeController.estimateOptimalLineCount(_inputText);
      final lines      = FontSizeController.splitTextByWords(_inputText, linesCount);
      final wrapped    = lines.join('\n');

      double testSize = increase ? _fontSize + 3 : _fontSize - 3;
      if (testSize < FontSizeController.minFontSize) testSize = FontSizeController.minFontSize;
      if (testSize > FontSizeController.maxFontSize) testSize = FontSizeController.maxFontSize;

      final painter = TextPainter(
        text: TextSpan(text: wrapped, style: styleBase.copyWith(fontSize: testSize)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        textWidthBasis: TextWidthBasis.parent,
      )..layout(maxWidth: finalWidth);

      if (painter.size.height <= finalHeight) {
        _displayText = wrapped;
        _fontSize    = testSize;
        notifyListeners();
      }
    }
  }

  /// 5) “자동” 버튼: 최종뷰 크기(예: 1600×900)에서 최대 폰트 크기 한 번에 계산
  void autoFontSize() {
    const styleBase = TextStyle(
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w900,
    );

    final double finalWidth  = 1600;
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
      _fontSize    = size;
    } else {
      final linesCount = FontSizeController.estimateOptimalLineCount(_inputText);
      final lines      = FontSizeController.splitTextByWords(_inputText, linesCount);
      final wrapped    = lines.join('\n');

      final size = FontSizeController.calculateAutoFontSizeWithWrap(
        text: wrapped,
        maxWidth: finalWidth,
        maxHeight: finalHeight,
        baseStyle: styleBase,
      );
      _displayText = wrapped;
      _fontSize    = size;
    }

    notifyListeners();
  }

  /// 6) “멈추기/흐르기” 상태 토글 → displayText 재설정
  void setMovement(String label) {
    _movement = label;
    if (_movement == "흐르기") {
      _displayText = _inputText.replaceAll('\n', '');
    } else {
      _displayText = _inputText;
    }
    notifyListeners();
  }
}
