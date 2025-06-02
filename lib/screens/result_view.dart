import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class ResultView extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color bgColor;
  final double fontSize;
  final String movement;

  const ResultView({
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

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            // 회전된 전광판 텍스트 영역
            Center(
              child: RotatedBox(
                quarterTurns: 1, // 90도 시계 방향 회전
                child: Container(
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
                    blankSpace: 100,
                    velocity: 30.0,
                    textDirection: TextDirection.ltr,
                  )
                      : FittedBox(
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

            // ← 뒤로가기 버튼
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
