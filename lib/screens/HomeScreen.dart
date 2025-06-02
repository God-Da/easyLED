// lib/screens/HomeScreen.dart

import 'package:flutter/material.dart';

import '../logic/home_controller.dart';
import '../screens/result_view.dart';
import '../widgets/home_input.dart';
import '../widgets/home_preview.dart';
import '../widgets/home_settings.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        HomeController()..addListener(() {
          // 컨트롤러의 상태가 바뀌면 setState()로 전체 HomeScreen rebuild
          setState(() {});
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // ResultView로 전달할 때에는 controller.displayText 등 사용

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),

            // 1) Preview 영역
            HomePreview(
              text: _controller.displayText,
              textColor: _controller.textColor,
              bgColor: _controller.bgColor,
              fontSize: _controller.fontSize,
              movement: _controller.movement,
            ),

            const SizedBox(height: 10),

            // 2) 입력창 + 완성 버튼
            HomeInput(
              onTextChanged: _controller.setText,
              onComplete: () {
                // ResultView에 displayText, textColor, bgColor, fontSize, movement 전달
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ResultView(
                          text: _controller.displayText,
                          textColor: _controller.textColor,
                          bgColor: _controller.bgColor,
                          fontSize: _controller.fontSize,
                          movement: _controller.movement,
                        ),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // 3) 설정 버튼 그룹
            LayoutBuilder(
              builder: (context, constraints) {
                return HomeSettings(
                  onTextColorChanged: (Color? c) {
                    if (c != null) _controller.setTextColor(c);
                  },
                  onBgColorChanged: (Color? c) {
                    if (c != null) _controller.setBgColor(c);
                  },
                  onFontSizeChange:
                      (bool inc) =>
                          _controller.adjustFontSize(inc, constraints),
                  onAutoFontSize: () => _controller.autoFontSize(constraints),
                  onMovementChange: _controller.setMovement,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
