import 'package:flutter/material.dart';

class TextInputArea extends StatefulWidget {
  final void Function(String) onTextChanged;

  const TextInputArea({super.key, required this.onTextChanged});

  @override
  State<TextInputArea> createState() => _TextInputAreaState();
}

class _TextInputAreaState extends State<TextInputArea> {
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    print("text field: ${myController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextField(
        controller: myController,
        onChanged: widget.onTextChanged,
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
