// 입력 섹션: 텍스트 입력창과 “완성” 버튼을 묶어 홈스크린 하단에 배치

import 'package:flutter/material.dart';

import 'text_input_area.dart';

class HomeInput extends StatelessWidget {
  final void Function(String) onTextChanged;
  final VoidCallback onComplete;

  const HomeInput({
    super.key,
    required this.onTextChanged,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 2-1) 텍스트 입력 + 완성 버튼
          Row(
            children: [
              Expanded(child: TextInputArea(onTextChanged: onTextChanged)),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: onComplete,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFBFF00),
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: const Text("완성"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
