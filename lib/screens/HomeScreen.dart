import 'package:flutter/material.dart';
import '../widgets/button_group.dart';
import '../widgets/preview_box.dart';
import '../widgets/text_input_area.dart';
import '../logic/setting_fontSize.dart';
import '../screens/result_view.dart';

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
      final bestLineCount = FontSizeController.estimateOptimalLineCount(inputText);
      final lines = FontSizeController.splitTextByWords(inputText, bestLineCount);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: PreviewBox(
              text: inputText,
              textColor: textColor,
              bgColor: bgColor,
              fontSize: fontSize,
              movement: movement,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
            child: SizedBox(
              height: 80,
              child: Row(
                children: [
                  Expanded(
                    child: TextInputArea(onTextChanged: handleTextChanged),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ResultView(
                            text: inputText,
                            textColor: textColor,
                            bgColor: bgColor,
                            fontSize: fontSize,
                            movement: movement,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      backgroundColor: const Color(0xFFFBFF00),
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
          Expanded(
            flex: 5,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ButtonGroup(
                  onTextColorChanged: handleTextColorChanged,
                  onBgColorChanged: handleBgColorChanged,
                  onFontSizeChange: (bool inc) => handleFontSizeChange(inc, constraints),
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
