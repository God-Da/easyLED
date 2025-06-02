import 'package:flutter/material.dart';

import '../logic/setting_fontSize.dart';
import '../screens/result_view.dart';
import '../widgets/button_group.dart';
import '../widgets/preview_box.dart';
import '../widgets/text_input_area.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String inputText = '';
  Color textColor = Colors.white;
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
        text: inputText,
        maxWidth: constraints.maxWidth,
        maxHeight: constraints.maxHeight,
        baseStyle: styleBase,
      );
      setState(() {
        inputText = inputText.replaceAll('\n', '');
        fontSize = size;
      });
    } else {
      final bestLineCount = FontSizeController.estimateOptimalLineCount(
        inputText,
      );
      final lines = FontSizeController.splitTextByWords(
        inputText,
        bestLineCount,
      );
      final wrappedText = lines.join('\n');
      final adjustedSize = FontSizeController.calculateAutoFontSizeWithWrap(
        text: wrappedText,
        maxWidth: constraints.maxWidth,
        maxHeight: constraints.maxHeight,
        baseStyle: styleBase,
      );
      setState(() {
        inputText = wrappedText;
        fontSize = adjustedSize;
      });
    }
  }

  void handleMovementChange(String label) {
    setState(() {
      movement = label;
    });
  }

  void handleCompleteButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ResultView(
              text: inputText,
              textColor: textColor,
              bgColor: bgColor,
              fontSize: fontSize,
              movement: movement,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            // 1. 미리보기 (16:9 고정)
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1), // 흰색 테두리
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: PreviewBox(
                  text: inputText,
                  textColor: textColor,
                  bgColor: bgColor,
                  fontSize: fontSize,
                  movement: movement,
                ),
              ),
            ),

            // 2. Spacer: 중간 빈 공간 확보
            //const Spacer(),
            const SizedBox(height: 30),

            // 3. 하단 입력창 + 버튼 + 설정 그룹 묶기
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              child: Column(
                mainAxisSize: MainAxisSize.min, // 내용만큼만 차지
                children: [
                  // 입력창 + 버튼
                  Row(
                    children: [
                      Expanded(
                        child: TextInputArea(onTextChanged: handleTextChanged),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: handleCompleteButton,
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

                  const SizedBox(height: 20),

                  // 설정 버튼 그룹
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return ButtonGroup(
                        onTextColorChanged: handleTextColorChanged,
                        onBgColorChanged: handleBgColorChanged,
                        onFontSizeChange:
                            (bool inc) =>
                                handleFontSizeChange(inc, constraints),
                        onAutoFontSize: () => handleAutoFontSize(constraints),
                        onMovementChange: handleMovementChange,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
