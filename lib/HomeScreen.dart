import 'package:flutter/material.dart';
import 'text_input_area.dart';
import 'preview_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String inputText = ''; // 미리보기에 보여질 입력한 텍스트 상태 변수

  // TextInputArea에서 값을 받아 저장할 함수
  void handleTextChanged(String value) {
    setState(() {
      inputText = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // 배경색상 변경
      body: Column(
        children: [
          //1.미리보기 - preview_box.dart
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.red,
              child: PreviewBox(text: inputText),
            ),
          ),

          //2.입력하기 - text_input_area.dart 값 변경 시 preview 전달
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.yellow,
              child: Row(
                children: [
                  Expanded(
                    child: TextInputArea(
                      onTextChanged: handleTextChanged,
                    ),
                  ),
                ],
              ),
            ),
          ),

          //3.설정영역
          Expanded(
            flex: 6,
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Text(
                  '환경 설정 영역',
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}