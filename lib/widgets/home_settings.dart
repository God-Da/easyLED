// lib/widgets/home_settings.dart
// “HomeScreen 설정 섹션 전체”를 래핑한 StatelessWidget
// ButtonGroup의 props만 연결해 주는 래퍼 역할

import 'package:flutter/material.dart';
import 'button_group.dart';

class HomeSettings extends StatelessWidget {
  final void Function(Color?) onTextColorChanged;
  final void Function(Color?) onBgColorChanged;
  final void Function(bool) onFontSizeChange;
  final VoidCallback onAutoFontSize;
  final void Function(String) onMovementChange;

  // ▼▼▼ 추가: 초기화 콜백 4개
  final VoidCallback? onFontSizeReset;
  final VoidCallback? onTextColorReset;
  final VoidCallback? onBgColorReset;
  final VoidCallback? onMovementReset;

  const HomeSettings({
    Key? key,
    required this.onTextColorChanged,
    required this.onBgColorChanged,
    required this.onFontSizeChange,
    required this.onAutoFontSize,
    required this.onMovementChange,
    this.onFontSizeReset,
    this.onTextColorReset,
    this.onBgColorReset,
    this.onMovementReset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonGroup(
      onTextColorChanged: onTextColorChanged,
      onBgColorChanged: onBgColorChanged,
      onFontSizeChange: onFontSizeChange,
      onAutoFontSize: onAutoFontSize,
      onMovementChange: onMovementChange,
      // ▼▼▼ 추가된 부분!
      onFontSizeReset: onFontSizeReset,
      onTextColorReset: onTextColorReset,
      onBgColorReset: onBgColorReset,
      onMovementReset: onMovementReset,
    );
  }
}
