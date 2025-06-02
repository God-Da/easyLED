import 'package:flutter/material.dart';

import '../logic/setting_ui.dart';

class ButtonGroup extends StatelessWidget {
  final void Function(Color?) onTextColorChanged;
  final void Function(Color?) onBgColorChanged;
  final void Function(bool) onFontSizeChange;


  const ButtonGroup({
    super.key,
    required this.onTextColorChanged,
    required this.onBgColorChanged,
    required this.onFontSizeChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. 글자 크기
          buildSectionTitle("글자크기"),
          const SizedBox(height: 15),
          buildButtonRow(["작게", "크게", "자동"], (label) {
            print("글자크기 선택: $label");

            if (label == "작게") {
              onFontSizeChange(false); // 줄이기
            } else if (label == "크게") {
              onFontSizeChange(true); // 키우기
            } else if (label == "자동") {
              // 여기에 자동정렬 넣기
            }
          }),

          // 2. 글자 색
          buildSectionTitle("글자색"),
          const SizedBox(height: 15),
          buildColorButtons(
            [Colors.red, Color(0xFFFBFF00), Color(0xFF00FF37), Color(0xFF0022FF), Colors.purple, Colors.white, Colors.black, null],
            onTextColorChanged,
            context,
          ),

          const SizedBox(height: 20),

          // 3. 배경 색
          buildSectionTitle("배경색"),
          const SizedBox(height: 15),
          buildColorButtons(
            [Colors.red, Color(0xFFFBFF00), Color(0xFF00FF37), Color(0xFF0022FF), Colors.purple, Colors.white, Colors.black, null],
            onBgColorChanged,
            context,
          ),

          const SizedBox(height: 20),

          // 4. 움직임
          buildSectionTitle("움직임"),
          const SizedBox(height: 15),
          buildButtonRow(["멈추기", "흐르기"], (label) {
            print("움직임 선택: $label");
          }),
        ],
      ),
    );
  }
}