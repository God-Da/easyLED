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

  // 추가: 각각의 초기화 콜백
  final VoidCallback onResetFontSize;
  final VoidCallback onResetTextColor;
  final VoidCallback onResetBgColor;
  final VoidCallback onResetMovement;

  const ButtonGroup({
    Key? key,
    required this.onTextColorChanged,
    required this.onBgColorChanged,
    required this.onFontSizeChange,
    required this.onAutoFontSize,
    required this.onMovementChange,
    required this.onResetFontSize,
    required this.onResetTextColor,
    required this.onResetBgColor,
    required this.onResetMovement,
  }) : super(key: key);


  // 제목+초기화 버튼 Row
  Widget sectionHeader(String title, VoidCallback onReset) => Row(
    children: [
      Text(
        title,
        style: const TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold,
        ),
      ),
      IconButton(
        icon: const Icon(Icons.refresh, size: 20, color: Colors.white),
        tooltip: "초기화",
        onPressed: onReset,
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10,0,10,0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1) 글자 크기
          sectionHeader("글자크기", onResetFontSize),
          const SizedBox(height: 5),
          buildButtonRow(["작게", "크게", "자동"], (label) {
            if (label == "작게") onFontSizeChange(false);
            else if (label == "크게") onFontSizeChange(true);
            else onAutoFontSize();
          }),

          // 2) 글자색
          sectionHeader("글자색", onResetTextColor),
          const SizedBox(height: 5),
          buildColorButtons(
              [Colors.red,
              const Color(0xFFFBFF00),
              const Color(0xFF00FF37),
              const Color(0xFF0022FF),
              Colors.purple,
              Colors.white,
              Colors.black,
              null,
            ], onTextColorChanged, context),
          const SizedBox(height: 5),

          // 3) 배경색
          sectionHeader("배경색", onResetBgColor),
          buildColorButtons([
              Colors.red,
              const Color(0xFFFBFF00),
              const Color(0xFF00FF37),
              const Color(0xFF0022FF),
              Colors.purple,
              Colors.white,
              Colors.black,
              null,
          ], onBgColorChanged, context),
          const SizedBox(height: 5),

          // 4) 움직임
          sectionHeader("움직임", onResetMovement),
          const SizedBox(height: 5),
          buildButtonRow(["멈추기", "흐르기"], (label) {
            onMovementChange(label);
          }),
        ],
      ),
    );
  }
}