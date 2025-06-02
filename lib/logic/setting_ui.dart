import 'package:flutter/material.dart';

//구역 제목 만들기
Widget buildSectionTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Text(
      title,
      style: const TextStyle(
        color: Colors.white, //색상
        fontSize: 25,
        fontWeight: FontWeight.bold, // 폰트 굵기?
      ),
    ),
  );
}

//버튼 가로 정렬
Widget buildButtonRow(List<String> labels, void Function(String) onPressed) {
  return Row(
    children:
        labels
            .map(
              (label) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ElevatedButton(
                    onPressed: () => onPressed(label),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 20),
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
              ),
            )
            .toList(),
  );
}

//색상 선택 버튼
Widget buildColorButtons(List<Color?> colors, void Function(Color?) onTap) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: colors.map((color) {
      return GestureDetector(
        onTap: () => onTap(color),
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

