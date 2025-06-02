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
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: bgColor,
      alignment: Alignment.center,
      child: movement == "멈추기"
          ? Text(
        text.isEmpty ? '여기에 텍스트를 입력하세요' : text,
        style: TextStyle(
          fontFamily: 'Pretendard',
          fontSize: fontSize,
          color: textColor,
          fontWeight: FontWeight.w900,
        ),
        textAlign: TextAlign.center,
        softWrap: true,
        overflow: TextOverflow.visible,
      )
          : SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Marquee(
          text: text.isEmpty ? '여기에 텍스트를 입력하세요' : text,
          style: TextStyle(
            fontFamily: 'Pretendard',
            fontSize: fontSize,
            color: textColor,
            fontWeight: FontWeight.w900,
          ),
          blankSpace: 100,
          velocity: 30.0,
          textDirection: TextDirection.ltr,
        ),
      ),
    );
  }
}
