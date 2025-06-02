import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:flutter/services.dart';

class ResultView extends StatefulWidget {
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
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  @override
  void initState() {
    super.initState();
    // 가로 모드로 강제 전환
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // 이전 방향 (세로)로 복귀
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.bgColor,
      body: SafeArea(
        child: Center(
          child: Container(
            color: widget.bgColor,
            width: double.infinity,
            height: double.infinity,
            child: widget.movement == "흐르기"
                ? Marquee(
              text: widget.text.isEmpty ? '여기에 텍스트를 입력하세요' : widget.text,
              style: TextStyle(
                fontSize: widget.fontSize,
                color: widget.textColor,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w900,
                height: 1.0,
              ),
              blankSpace: 100,
              velocity: 30.0,
              textDirection: TextDirection.ltr,
            )
                : Center(
              child: Text(
                widget.text.isEmpty ? '여기에 텍스트를 입력하세요' : widget.text,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  color: widget.textColor,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w900,
                  height: 1.0,
                ),
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
