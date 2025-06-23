import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:easyLED/app_config.dart';

class ResultView extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color bgColor;
  final double fontSize;
  final String movement;

  const ResultView({
    Key? key,
    required this.text,
    required this.textColor,
    required this.bgColor,
    required this.fontSize,
    required this.movement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            // 회전된 전광판
            Center(
              child: RotatedBox(
                quarterTurns: 1, // 90도 시계 방향 회전
                child: movement == "흐르기"
                    ? SizedBox(
                  width: AppConfig.previewHeight,
                  height: fontSize * 1.3,
                  child: Marquee(
                    text: text.isEmpty
                        ? AppConfig.defaultDisplayText
                        : text,
                    style: TextStyle(
                      fontFamily: AppConfig.fontFamily,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w900,
                      color: textColor,
                      height: AppConfig.marqueeLineHeight,
                    ),
                    blankSpace: AppConfig.marqueeBlankSpace,
                    velocity: AppConfig.moveVelocity,
                    textDirection: TextDirection.ltr,
                  ),
                )
                    : SizedBox(
                  width: AppConfig.previewWidth,
                  height: AppConfig.previewHeight,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      text.isEmpty
                          ? AppConfig.defaultDisplayText
                          : text,
                      style: TextStyle(
                        fontFamily: AppConfig.fontFamily,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w900,
                        color: textColor,
                        height: 1.0,
                      ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                ),
              ),
            ),
            // 뒤로가기 버튼
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, size: AppConfig.iconSize, color: Colors.white),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
