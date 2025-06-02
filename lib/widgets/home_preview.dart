// 미리보기 섹션: 16:9 비율 전광판 모양, 멈추기/흐르기 모드에 따라 텍스트 고정 또는 흐름 처리

import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import '../logic/marquee_config.dart'; // 공통 Marquee 속도 상수

class HomePreview extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color bgColor;
  final double fontSize;
  final String movement;

  const HomePreview({
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
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
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
        ),
      ),
    );
  }
}
