import 'package:flutter/material.dart';

import '../widgets/button_group.dart';
import '../widgets/preview_box.dart';
import '../widgets/text_input_area.dart';

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
              child: PreviewBox(text: inputText),
            ),
          ),

          //2.입력하기 - text_input_area.dart 값 변경 시 preview 전달
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
            child: Expanded(
              flex: 1,
              child: Container(
                child: Row(
                  children: [
                    // 텍스트 입력창
                    Expanded(
                      child: TextInputArea(onTextChanged: handleTextChanged),
                    ),

                    const SizedBox(width: 10), //간격

                    ElevatedButton(
                      onPressed: () {
                        print("완성 버튼 클릭");
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                        backgroundColor: Color(0xFFFBFF00),
                        //버튼 색
                        foregroundColor: Colors.black,
                        //버튼 글자색
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ), //버튼 둥글게
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
              ),
            ),
          ),

          //3.설정영역
          Expanded(flex: 5, child: Center(child: ButtonGroup())),
        ],
      ),
    );
  }
}
