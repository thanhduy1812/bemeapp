import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GtdDatePickerTheme with DiagnosticableTreeMixin {
  final TextStyle cancelStyle;
  final TextStyle doneStyle;
  final TextStyle itemStyle;
  final Color backgroundColor;
  final Color? headerColor;

  final double containerHeight;
  final double titleHeight;
  final double actionHeight;
  final double itemHeight;

  const GtdDatePickerTheme({
    this.cancelStyle = const TextStyle(color: Colors.black54, fontSize: 16),
    this.doneStyle = const TextStyle(color: Colors.blue, fontSize: 16),
    this.itemStyle = const TextStyle(color: Color(0xFF000046), fontSize: 18),
    this.backgroundColor = Colors.white,
    this.headerColor,
    this.containerHeight = 215.0,
    this.titleHeight = 44.0,
    this.actionHeight = 48.0,
    this.itemHeight = 36.0,
  });
}
