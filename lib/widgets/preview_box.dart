import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import '../logic/marquee_config.dart';

class PreviewBox extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color bgColor;
  final double fontSize;
  final String movement;

  const PreviewBox({
    super.key,
    required this.text,
    required this.textColor,
    required this.bgColor,
    required this.fontSize,
    required this.movement,
  });

  @override
  Widget build(BuildContext context) {
    final displayText = text.isEmpty ? '텍스트를 입력하세요' : text;

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: bgColor,
      child: movement == "흐르기"
          ? Marquee(
        text: displayText,
        style: TextStyle(
          fontFamily: 'Pretendard',
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          color: textColor,
          height: 1.0,
        ),
        blankSpace: kMarqueeBlankSpace,
        velocity: kMarqueeVelocity,
        textDirection: TextDirection.ltr,
      )
          : Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            displayText,
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: fontSize,
              fontWeight: FontWeight.w900,
              color: textColor,
              height: 1.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
