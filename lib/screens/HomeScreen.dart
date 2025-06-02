// lib/screens/HomeScreen.dart
// HomeScreen 전체 레이아웃: 미리보기 + 입력/완성 + 설정 버튼 그룹

import 'package:flutter/material.dart';

import '../logic/home_controller.dart';
import '../screens/result_view.dart';
import '../widgets/home_input.dart';
import '../widgets/home_preview.dart';
import '../widgets/home_settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
    HomeController()
      ..addListener(() {
        setState(() {}); // 상태가 바뀌면 화면 재빌드
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void handleCompleteButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) =>
            ResultView(
              text: _controller.displayText,
              textColor: _controller.textColor,
              bgColor: _controller.bgColor,
              fontSize: _controller.fontSize,
              movement: _controller.movement,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),

            // 1) 미리보기: 16:9 고정 비율
            AspectRatio(
              aspectRatio: 16 / 9,
              child: HomePreview(
                text: _controller.displayText,
                textColor: _controller.textColor,
                bgColor: _controller.bgColor,
                computedFontSize: _controller.fontSize,
                movement: _controller.movement,
              ),
            ),

            const SizedBox(height:5,),

            // 2) 입력창 + 완성버튼: 높이 제한
            SizedBox(
              height: 70,
              child: HomeInput(
                onTextChanged: _controller.setText,
                onComplete: handleCompleteButton,
              ),
            ),

            // 3) 설정 버튼 그룹: 남는 공간 차지
            Expanded(
              child: HomeSettings(
                onTextColorChanged: (c) {
                  if (c != null) _controller.setTextColor(c);
                },
                onBgColorChanged: (c) {
                  if (c != null) _controller.setBgColor(c);
                },
                onFontSizeChange: _controller.adjustFontSize,
                onAutoFontSize: _controller.autoFontSize,
                onMovementChange: _controller.setMovement,
              ),
            ),
          ],
        ),
      ),
    );
  }
}