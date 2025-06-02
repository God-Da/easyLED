// lib/widgets/color_picker_dialog.dart
// “무지개 색상” 버튼 클릭 시 팝업되는 ColorPicker 다이얼로그

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

/// 다이얼로그를 띄워 사용자가 색상을 고르면 선택된 색상을 반환,
/// 취소하면 null을 반환합니다.
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
            onColorChanged: (Color c) => tempColor = c,
            enableAlpha: false,
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('취소'),
            onPressed: () => Navigator.of(dialogCtx).pop(null),
          ),
          TextButton(
            child: const Text('확인'),
            onPressed: () => Navigator.of(dialogCtx).pop(tempColor),
          ),
        ],
      );
    },
  );

  return selected;
}
