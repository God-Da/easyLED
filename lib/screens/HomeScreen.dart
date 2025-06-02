import 'package:flutter/material.dart';

import '../widgets/button_group.dart';
import '../widgets/preview_box.dart';
import '../widgets/text_input_area.dart';
import '../logic/setting_fontSize.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String inputText = ''; // 미리보기에 보여질 입력한 텍스트 상태 변수
  Color textColor = Colors.white; // 색상 선택 시 보여질 상태 변수
  Color bgColor = Colors.black;
  double fontSize = FontSizeController.defaultFontSize;

  // TextInputArea에서 값을 받아 저장할 함수
  void handleTextChanged(String value) {
    setState(() {
      inputText = value;
    });
  }

  void handleTextColorChanged(Color? color) {
    if (color != null) {
      setState(() {
        textColor = color;
      });
    }
  }

  void handleBgColorChanged(Color? color) {
    if (color != null) {
      setState(() {
        bgColor = color;
      });
    }
  }

  void handleFontSizeChange(bool increase) {
    setState(() {
      fontSize = FontSizeController.adjustFontSize(fontSize, increase);
    });
  }

  void handleAutoFontSize(BoxConstraints constraints) {
    final maxFont = FontSizeController.calculateMaxFontSize(
      text: inputText.isEmpty ? '여기에 텍스트를 입력하세요' : inputText,
      maxWidth: constraints.maxWidth,
      maxHeight: constraints.maxHeight,
      baseStyle: const TextStyle(fontWeight: FontWeight.bold),
    );

    setState(() {
      fontSize = maxFont;
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
              child: PreviewBox(
                text: inputText,
                textColor: textColor,
                bgColor: bgColor,
                fontSize: fontSize,
              ),
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
                    const SizedBox(width: 10), //요소 간 간격
                    ElevatedButton(
                      onPressed: () {
                        print("완성 버튼 클릭");
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 18,
                        ),
                        //버튼 배경
                        backgroundColor: Color(0xFFFBFF00),
                        // 버튼 글자 색
                        foregroundColor: Colors.black,
                        //버튼 곡률
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
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
          Expanded(
            flex: 5,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ButtonGroup(
                  onTextColorChanged: handleTextColorChanged,
                  onBgColorChanged: handleBgColorChanged,
                  onFontSizeChange: handleFontSizeChange,
                  onAutoFontSize: () => handleAutoFontSize(constraints),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
