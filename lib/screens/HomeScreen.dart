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
  String movement = "멈추기";

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

  void handleFontSizeChange(bool increase, BoxConstraints constraints) {
    setState(() {
      fontSize = FontSizeController.adjustFontSize(
        text: inputText,
        currentSize: fontSize,
        increase: increase,
        maxWidth: constraints.maxWidth,
        maxHeight: constraints.maxHeight,
        baseStyle: const TextStyle(
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w900,
        ),
      );
    });
  }

  void handleAutoFontSize(BoxConstraints constraints) {
    const styleBase = TextStyle(
      fontFamily: 'Pretendard',
      fontWeight: FontWeight.w900,
    );

    if (movement == "흐르기") {
      final size = FontSizeController.calculateMaxFontSizeSingleLine(
        text: inputText.replaceAll('\n', ''),
        maxWidth: constraints.maxWidth,
        maxHeight: constraints.maxHeight,
        baseStyle: styleBase,
      );

      setState(() {
        inputText = inputText.replaceAll('\n', '');
        fontSize = size;
      });
    } else {
      final lineCount = _bestLineCount(inputText, constraints);
      final lines = FontSizeController.splitTextToLines(inputText, lineCount);
      final wrappedText = lines.join('\n');

      final finalSize = FontSizeController.calculateAutoFontSizeWithWrap(
        text: wrappedText,
        maxWidth: constraints.maxWidth,
        maxHeight: constraints.maxHeight,
        baseStyle: styleBase,
      );

      setState(() {
        inputText = wrappedText;
        fontSize = finalSize;
      });
    }
  }

  void handleMovementChange(String label) {
    setState(() {
      movement = label;
    });
  }

  int _bestLineCount(String text, BoxConstraints constraints) {
    int bestLineCount = 1;
    double bestFontSize = 10;

    for (int lineCount = 1; lineCount <= text.length; lineCount++) {
      final lines = FontSizeController.splitTextToLines(text, lineCount);
      final joined = lines.join('\n');

      final size = FontSizeController.calculateAutoFontSizeWithWrap(
        text: joined,
        maxWidth: constraints.maxWidth,
        maxHeight: constraints.maxHeight,
        baseStyle: const TextStyle(
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w900,
        ),
      );

      final painter = TextPainter(
        text: TextSpan(
          text: joined,
          style: TextStyle(fontSize: size, fontFamily: 'Pretendard', fontWeight: FontWeight.w900),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
        textWidthBasis: TextWidthBasis.parent,
      );
      painter.layout(maxWidth: constraints.maxWidth);

      if (painter.size.height <= constraints.maxHeight && size > bestFontSize) {
        bestFontSize = size;
        bestLineCount = lineCount;
      }
    }

    return bestLineCount;
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
                movement: movement,
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
                    Expanded(
                      child: TextInputArea(onTextChanged: handleTextChanged),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        print("완성 버튼 클릭");
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                        backgroundColor: Color(0xFFFBFF00),
                        foregroundColor: Colors.black,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  onFontSizeChange: (bool increase) {
                    handleFontSizeChange(increase, constraints);
                  },
                  onAutoFontSize: () => handleAutoFontSize(constraints),
                  onMovementChange: handleMovementChange,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}