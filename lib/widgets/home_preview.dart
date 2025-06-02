// lib/widgets/home_preview.dart
// “미리보기 영역(16:9) + 축소(FittedBox)=> PreviewBox을 합친 컴포넌트

import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

/// ▶ “FinalTextDisplay” 기능을 여기서 직접 구현
///    : 최종뷰(1600×900 비율)용 텍스트 위젯
class FinalTextDisplay extends StatelessWidget {
  final String text;         // 이미 줄바꿈이 적용된 문자열 or 한 줄 문자열
  final Color  textColor;
  final Color  bgColor;
  final double computedFontSize;
  final String movement;

  const FinalTextDisplay({
    Key? key,
    required this.text,
    required this.textColor,
    required this.bgColor,
    required this.computedFontSize,
    required this.movement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
      alignment: Alignment.center,
      child: movement == "흐르기"
          ? Marquee(
        text: text.isEmpty ? '여기에 텍스트를 입력하세요' : text,
        style: TextStyle(
          fontFamily: 'Pretendard',
          fontSize: computedFontSize,
          fontWeight: FontWeight.w900,
          color: textColor,
          height: 1.0,
        ),
        blankSpace: 100,
        velocity: 30.0,
        textDirection: TextDirection.ltr,
      )
          : Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            text.isEmpty ? '여기에 텍스트를 입력하세요' : text,
            style: TextStyle(
              fontFamily: 'Pretendard',
              fontSize: computedFontSize,
              fontWeight: FontWeight.w900,
              color: textColor,
              height: 1.0,
            ),
            textAlign: TextAlign.center,
            softWrap: true,
          ),
        ),
      ),
    );
  }
}

/// ▶ “HomePreview” 자체: 미리보기 박스 (화면에 보이는 부분)
///    1) AspectRatio(16:9) 안에
///    2) FittedBox로 감싼 “FinalTextDisplay”(1600×900) 를 배치
class HomePreview extends StatelessWidget {
  final String text;
  final Color  textColor;
  final Color  bgColor;
  final double computedFontSize;
  final String movement;

  const HomePreview({
    Key? key,
    required this.text,
    required this.textColor,
    required this.bgColor,
    required this.computedFontSize,
    required this.movement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            // “최종뷰 가정 크기”: 1600×900
            width: 1600,
            height: 900,
            child: FinalTextDisplay(
              text: text,
              textColor: textColor,
              bgColor: bgColor,
              computedFontSize: computedFontSize,
              movement: movement,
            ),
          ),
        ),
      ),
    );
  }
}
