// lib/widgets/button_group.dart
// “설정 화면(글자 크기, 글자색, 배경색, 움직임) 버튼들을 한곳에 모은 위젯”

import 'package:flutter/material.dart';
import '../logic/setting_ui.dart';

class ButtonGroup extends StatelessWidget {
  final void Function(Color?) onTextColorChanged;
  final void Function(Color?) onBgColorChanged;
  final void Function(bool) onFontSizeChange;
  final VoidCallback onAutoFontSize;
  final void Function(String) onMovementChange;

  const ButtonGroup({
    Key? key,
    required this.onTextColorChanged,
    required this.onBgColorChanged,
    required this.onFontSizeChange,
    required this.onAutoFontSize,
    required this.onMovementChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1) 글자 크기
          buildSectionTitle("글자크기"),
          const SizedBox(height: 10),
          buildButtonRow(["작게", "크게", "자동"], (label) {
            if (label == "작게") {
              onFontSizeChange(false);
            } else if (label == "크게") {
              onFontSizeChange(true);
            } else {
              onAutoFontSize();
            }
          }),

          // 2) 글자색
          buildSectionTitle("글자색"),
          const SizedBox(height: 10),
          buildColorButtons(
            [
              Colors.red,
              const Color(0xFFFBFF00),
              const Color(0xFF00FF37),
              const Color(0xFF0022FF),
              Colors.purple,
              Colors.white,
              Colors.black,
              null,
            ],
            onTextColorChanged,
            context,
          ),

          const SizedBox(height: 20),

          // 3) 배경색
          buildSectionTitle("배경색"),
          const SizedBox(height: 10),
          buildColorButtons(
            [
              Colors.red,
              const Color(0xFFFBFF00),
              const Color(0xFF00FF37),
              const Color(0xFF0022FF),
              Colors.purple,
              Colors.white,
              Colors.black,
              null,
            ],
            onBgColorChanged,
            context,
          ),

          const SizedBox(height: 20),

          // 4) 움직임
          buildSectionTitle("움직임"),
          const SizedBox(height: 10),
          buildButtonRow(["멈추기", "흐르기"], (label) {
            onMovementChange(label);
          }),
        ],
      ),
    );
  }
}
