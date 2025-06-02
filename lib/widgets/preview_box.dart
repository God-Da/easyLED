import 'package:flutter/material.dart';

class PreviewBox extends StatelessWidget {
  final String text;

  const PreviewBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text.isEmpty ? '여기에 텍스트를 입력하세요' : text,
        style: const TextStyle(fontSize: 25, color: Colors.white),
      ),
    );
  }
}
