import 'package:flutter/material.dart';

class PreviewBox extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color bgColor;

  const PreviewBox({
    super.key,
    required this.text,
    this.textColor = Colors.white,
    this.bgColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      alignment: Alignment.center,
      child: Text(
        text.isEmpty ? '여기에 텍스트를 입력하세요' : text,
        style: TextStyle(
          fontSize: 25,
          color: textColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
