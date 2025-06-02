// lib/widgets/home_input.dart
// “HomeScreen 하단 입력창 + 완성 버튼” 영역을 담당하는 위젯

import 'package:flutter/material.dart';
import 'text_input_area.dart';

class HomeInput extends StatelessWidget {
  final void Function(String) onTextChanged;
  final VoidCallback onComplete;

  const HomeInput({
    Key? key,
    required this.onTextChanged,
    required this.onComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextInputArea(onTextChanged: onTextChanged),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: onComplete,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFBFF00),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              ),
            ),
            child: const Text("완성"),
          ),
        ],
      ),
    );
  }
}
