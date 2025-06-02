// lib/widgets/color_picker_dialog.dart
// “컬러 피커 다이얼로그” 호출부만 별도 함수로 분리

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

/// 다이얼로그를 띄워 사용자가 색상을 고르게 하고,
/// 선택된 색상을 Future로 반환합니다.
/// 초기값(initialColor)을 받아서, 선택 후 결과를 돌려주세요.
/// - 만약 사용자가 취소하거나 아무것도 선택하지 않았다면 null 반환.
/// - 호출은 await showColorPicker(context, currentColor) 식으로 하면 됩니다.
Future<Color?> showColorPickerDialog(
    BuildContext context,
    Color initialColor,
    ) async {
  Color tempColor = initialColor;

  final selected = await showDialog<Color>(
    context: context,
    builder: (dialogCtx) {
      return AlertDialog(
        title: const Text('색상을 선택하세요'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: tempColor,
            onColorChanged: (Color c) {
              tempColor = c;
            },
            enableAlpha: false,
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('취소'),
            onPressed: () {
              Navigator.of(dialogCtx).pop(null);
            },
          ),
          TextButton(
            child: const Text('확인'),
            onPressed: () {
              Navigator.of(dialogCtx).pop(tempColor);
            },
          ),
        ],
      );
    },
  );

  return selected; // 선택된 색상 또는 null
}
