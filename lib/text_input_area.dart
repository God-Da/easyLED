import 'package:flutter/material.dart';

class TextInputArea extends StatefulWidget { //동적 화면(StatefulWidget)
  final void Function(String) onTextChanged; // 상위 위젯(HomeScreen)에서 전달한 콜백 함수

  const TextInputArea({super.key, required this.onTextChanged});

  @override
  State<TextInputArea> createState() => _TextInputAreaState();
}

class _TextInputAreaState extends State<TextInputArea> {
  //TextField의 현잿값을 얻는데 필요하다.
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //addListener로 상태를 모니터링 하기
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    //화면 종료시 컨트롤러 해제
    myController.dispose();
    super.dispose();
  }

  // 사용자가 입력한 최신 값을 출력하는 함수 (디버깅용)
  void _printLatestValue() {
    print("text field: ${myController.text}"); // 입력된 실제 텍스트 출력
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextField(
        controller: myController, //입력값을 추적하는 컨트롤러
        onChanged: (text) {
          widget.onTextChanged(text); // 상위(HomeScreen)로 전달
        },
        decoration: InputDecoration(
          labelText: '여기에 입력하세요', //힌트
          border: OutlineInputBorder(),
          filled: true, //텍스트 박스 색 채울건지
          fillColor: Colors.white,
        ),
      ),
    );
  }
}
