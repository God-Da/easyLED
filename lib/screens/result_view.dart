// lib/screens/result_view.dart
// “최종뷰(가로 모드처럼 보이도록 90도 회전)” + 뒤로 가기 버튼

import 'package:flutter/material.dart';

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
            // 1) 90도 회전된 전광판 텍스트 (FittedBox + Text/Marquee)
            Center(
              child: RotatedBox(
                quarterTurns: 1, // 90도 시계 방향 회전
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: movement == "흐르기"
                      ? SizedBox(
                    width: double.infinity,
                    child: Text( // Marquee 대신 Text로 단순 예시
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
                  )
                      : Text(
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

            // 2) “뒤로 가기” 버튼 (작게 왼쪽 위)
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
