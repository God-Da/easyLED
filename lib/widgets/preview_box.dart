import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class PreviewBox extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color bgColor;
  final double fontSize;
  final String movement;

  const PreviewBox({
    super.key,
    required this.text,
    this.textColor = Colors.white,
    this.bgColor = Colors.black,
    required this.fontSize,
    required this.movement,
  });

  @override
  Widget build(BuildContext context) {
    final displayedText = text.isEmpty ? '여기에 텍스트를 입력하세요' : text;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: bgColor,
      alignment: Alignment.center,
      child: movement == "멈추기"
          ? SingleChildScrollView(
        child: Text(
          displayedText,
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: fontSize,
            height: 1.0,
            color: textColor,
            fontWeight: FontWeight.w900,
          ),
          textAlign: TextAlign.center,
          softWrap: true,
        ),
      )
          : SizedBox.expand(
        child: Marquee(
          text: displayedText,
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: fontSize,
            height: 1.0,
            color: textColor,
            fontWeight: FontWeight.w900,
          ),
          blankSpace: 100,
          velocity: 30.0,
          textDirection: TextDirection.ltr,
          startPadding: 20.0,
          pauseAfterRound: const Duration(seconds: 0),
        ),
      ),
    );
  }
}
