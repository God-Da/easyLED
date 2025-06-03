import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

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
    final Size size = MediaQuery.of(context).size;
    final double resultViewWidth = size.width;
    final double resultViewHeight = size.height;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            // 1) 90도 회전된 전광판 텍스트
            Center(
              child: RotatedBox(
                quarterTurns: 1, // 90도 시계 방향 회전
                child: movement == "흐르기"
                    ? SizedBox(
                  width: resultViewHeight,  // ★ 회전 후 가로
                  height: fontSize * 1.3,   // ★ 한 줄만 (글자 크게 보여주려면 그대로!)
                  child: Marquee(
                    text: text.isEmpty ? '여기에 텍스트를 입력하세요' : text,
                    style: TextStyle(
                      fontFamily: 'Pretendard',
                      fontSize: fontSize,
                      fontWeight: FontWeight.w900,
                      color: textColor,
                      height: 1.0,
                    ),
                    blankSpace: 100,
                    velocity: 30.0,
                    textDirection: TextDirection.ltr,
                  ),
                )
                    : FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    text.isEmpty ? '여기에 텍스트를 입력하세요' : text,
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
            // 2) “뒤로 가기” 버튼
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, size: 24, color: Colors.white),
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
