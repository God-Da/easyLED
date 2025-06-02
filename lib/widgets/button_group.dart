import 'package:flutter/material.dart';
import '../logic/setting_ui.dart';
import 'color_picker_dialog.dart'; // 새로 분리한 다이얼로그 함수 import

class ButtonGroup extends StatelessWidget {
  final void Function(Color?) onTextColorChanged;
  final void Function(Color?) onBgColorChanged;
  final void Function(bool) onFontSizeChange;
  final void Function() onAutoFontSize;
  final void Function(String) onMovementChange;

  const ButtonGroup({
    super.key,
    required this.onTextColorChanged,
    required this.onBgColorChanged,
    required this.onFontSizeChange,
    required this.onAutoFontSize,
    required this.onMovementChange,
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

          // 2. 글자 색
          buildSectionTitle("글자색"),
          const SizedBox(height: 10),
          buildColorButtons(
            [
              Colors.red,
              Color(0xFFFBFF00),
              Color(0xFF00FF37),
              Color(0xFF0022FF),
              Colors.purple,
              Colors.white,
              Colors.black,
              null,
            ],
            onTextColorChanged,
            context,
          ),

          const SizedBox(height: 20),

          // 3. 배경 색
          buildSectionTitle("배경색"),
          const SizedBox(height: 10),
          buildColorButtons(
            [
              Colors.red,
              Color(0xFFFBFF00),
              Color(0xFF00FF37),
              Color(0xFF0022FF),
              Colors.purple,
              Colors.white,
              Colors.black,
              null,
            ],
            onBgColorChanged,
            context,
          ),

          const SizedBox(height: 20),

          // 4. 움직임
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

/// 색상 선택 버튼들을 가로로 배치
Widget buildColorButtons(
    List<Color?> colors,
    void Function(Color?) onTap,
    BuildContext context,
    ) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: colors.map((color) {
      return GestureDetector(
        onTap: () async {
          if (color != null) {
            // 미리 지정된 색상 버튼 클릭 시
            onTap(color);
          } else {
            // “무지개” 버튼 클릭 → 다이얼로그 띄우기 (분리된 함수 호출)
            final pickedColor = await showColorPickerDialog(
              context,
              Colors.red, // 초기값 (필요에 따라 원하는 기본색을 넣어도 됩니다)
            );
            if (pickedColor != null) {
              onTap(pickedColor);
            }
          }
        },
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: color == null ? null : color,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
            gradient: color == null
                ? const SweepGradient(
              colors: [
                Colors.red,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.blue,
                Colors.indigo,
                Colors.purple,
                Colors.red,
              ],
              center: Alignment.center,
            )
                : null,
          ),
        ),
      );
    }).toList(),
  );
}
