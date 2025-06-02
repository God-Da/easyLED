import 'package:flutter/material.dart';

class PreviewBox extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color bgColor;
  final double fontSize;

  const PreviewBox({
    super.key,
    required this.text,
    this.textColor = Colors.white,
    this.bgColor = Colors.black,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      alignment: Alignment.center,
      child: Text(
        text.isEmpty ? '여기에 텍스트를 입력하세요' : text,
        style: TextStyle(
          fontSize: fontSize,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
