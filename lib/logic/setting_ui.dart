// lib/logic/setting_ui.dart
// “설정 화면(버튼 그룹)에서 쓰이는 공통 UI 빌더 함수 모음”

import 'package:flutter/material.dart';
import '../widgets/color_picker_dialog.dart';

/// 구역 제목(“글자 크기”, “글자색” 등)을 출력하는 위젯
Widget buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

/// 라벨 리스트 → 가로로 버튼을 늘어놓는 Row 위젯  여기서 조정하기
Widget buildButtonRow(List<String> labels, void Function(String) onPressed) {
  return Row(
    children: labels.map((label) {
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
            onPressed: () => onPressed(label),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10),
              textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(label, textAlign: TextAlign.center),
          ),
        ),
      );
    }).toList(),
  );
}

/// 색상 버튼을 가로로 만들어주는 헬퍼
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
            onTap(color);
          } else {
            // “무지개” 버튼 클릭 → 다이얼로그 띄우기
            final pickedColor = await showColorPickerDialog(
              context,
              Colors.red, // 초기값(예시)
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
            color: color,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(8),
            gradient: color == null
                ? const SweepGradient(
              colors: [
                Colors.red,
                Colors.orange,
                const Color(0xFFFBFF00),
                const Color(0xFF00FF37),
                const Color(0xFF0022FF),
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
