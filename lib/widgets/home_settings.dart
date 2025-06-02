// 설정 섹션: 글자 크기, 색상, 배경색, 움직임 모드를 선택하는 버튼 그룹

import 'package:flutter/material.dart';
import 'button_group.dart';

class HomeSettings extends StatelessWidget {
  final void Function(Color?) onTextColorChanged;
  final void Function(Color?) onBgColorChanged;
  final void Function(bool) onFontSizeChange;
  final VoidCallback onAutoFontSize;
  final void Function(String) onMovementChange;

  const HomeSettings({
    super.key,
    required this.onTextColorChanged,
    required this.onBgColorChanged,
    required this.onFontSizeChange,
    required this.onAutoFontSize,
    required this.onMovementChange,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonGroup(
      onTextColorChanged: onTextColorChanged,
      onBgColorChanged: onBgColorChanged,
      onFontSizeChange: onFontSizeChange,
      onAutoFontSize: onAutoFontSize,
      onMovementChange: onMovementChange,
    );
  }
}
