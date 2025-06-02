// lib/widgets/text_input_area.dart
// “하단 입력창” 컴포넌트: 흰 배경의 라운드형 텍스트 필드

import 'package:flutter/material.dart';

class TextInputArea extends StatefulWidget {
  final void Function(String) onTextChanged;

  const TextInputArea({Key? key, required this.onTextChanged}) : super(key: key);

  @override
  State<TextInputArea> createState() => _TextInputAreaState();
}

class _TextInputAreaState extends State<TextInputArea> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      widget.onTextChanged(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextField(
        controller: _controller,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: '텍스트를 입력하세요',
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
