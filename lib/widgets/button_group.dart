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

  //초기화
  final VoidCallback? onFontSizeReset;
  final VoidCallback? onTextColorReset;
  final VoidCallback? onBgColorReset;
  final VoidCallback? onMovementReset;


  const ButtonGroup({
    Key? key,
    required this.onTextColorChanged,
    required this.onBgColorChanged,
    required this.onFontSizeChange,
    required this.onAutoFontSize,
    required this.onMovementChange,
    //초기화
    this.onFontSizeReset,
    this.onTextColorReset,
    this.onBgColorReset,
    this.onMovementReset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1) 글자크기
          Row(
            children: [
              buildSectionTitle("글자크기"), // 함수는 그대로 사용
              const SizedBox(width: 8),
              TextButton(
                onPressed: onFontSizeReset,
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFFBFF00),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 4),
                  minimumSize: Size(0, 0),
                ),
                child: const Text("초기화"),
              ),
            ],
          ),
          const SizedBox(height: 2),
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
          Row(
            children: [
              buildSectionTitle("글자색"),
              const SizedBox(width: 8),
              TextButton(
                onPressed: onTextColorReset,
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFFBFF00),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 4),
                  minimumSize: Size(0, 0),
                ),
                child: const Text("초기화"),
              ),
            ],
          ),
          const SizedBox(height: 2),
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

          const SizedBox(height: 2),

          // 3) 배경색
          Row(
            children: [
              buildSectionTitle("배경색"),
              const SizedBox(width: 8),
              TextButton(
                onPressed: onBgColorReset,
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFFBFF00),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 4),
                  minimumSize: Size(0, 0),
                ),
                child: const Text("초기화"),
              ),
            ],
          ),
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

          const SizedBox(height: 2),

          // 4) 움직임
          Row(
            children: [
              buildSectionTitle("움직임"),
              const SizedBox(width: 8),
              TextButton(
                onPressed: onMovementReset,
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFFBFF00),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 4),
                  minimumSize: Size(0, 0),
                ),
                child: const Text("초기화"),
              ),
            ],
          ),
          const SizedBox(height: 2),
          buildButtonRow(["멈추기", "흐르기"], (label) {
            onMovementChange(label);
          }),
        ],
      ),
    );
  }
}