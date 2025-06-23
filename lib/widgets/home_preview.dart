// lib/widgets/home_preview.dart
// “미리보기 영역(16:9) + 축소(FittedBox)=> PreviewBox을 합친 컴포넌트
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:easyLED/app_config.dart';

class FinalTextDisplay extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color bgColor;
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
        text: text.isEmpty ? AppConfig.defaultDisplayText : text,
        style: TextStyle(
          fontFamily: AppConfig.fontFamily,
          fontSize: computedFontSize,
          fontWeight: FontWeight.w900,
          color: textColor,
          height: AppConfig.marqueeLineHeight,
        ),
        blankSpace: AppConfig.marqueeBlankSpace,
        velocity: AppConfig.moveVelocity,
        textDirection: TextDirection.ltr,
      )
          : Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            text.isEmpty ? AppConfig.defaultDisplayText : text,
            style: TextStyle(
              fontFamily: AppConfig.fontFamily,
              fontSize: computedFontSize,
              fontWeight: FontWeight.w900,
              color: textColor,
              height: AppConfig.marqueeLineHeight,
            ),
            textAlign: TextAlign.center,
            softWrap: true,
          ),
        ),
      ),
    );
  }
}

class HomePreview extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color bgColor;
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
            width: AppConfig.previewWidth,
            height: AppConfig.previewHeight,
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
