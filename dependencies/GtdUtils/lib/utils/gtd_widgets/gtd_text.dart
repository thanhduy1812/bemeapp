library gtd_text;

import 'package:flutter/material.dart';

enum TextType {headlineLarge, headlineMedium, headlineSmall, bodySmall}

class GtdText<T> extends StatelessWidget {
  final String text;
  final Color? colorText;
  final FontWeight? fontWeight;
  final TextType? textType;
  final TextAlign? textAlign;

  const GtdText({
    super.key,
    required this.text,
    this.colorText,
    this.fontWeight,
    this.textType,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle;
    switch (textType) {
      case TextType.headlineLarge:
        textStyle = Theme.of(context).textTheme.headlineLarge;
        break;
      case TextType.headlineMedium:
        textStyle = Theme.of(context).textTheme.headlineMedium;
        break;
      case TextType.headlineSmall:
        textStyle = Theme.of(context).textTheme.headlineSmall;
        break;
      case TextType.bodySmall:
        textStyle = Theme.of(context).textTheme.bodySmall;
        break;
      default:
        break;
    }
    return Text(
      text,
      style: textStyle?.merge(
        TextStyle(
          color: colorText,
          fontWeight: fontWeight,
        )
      ),
      textAlign: textAlign,
    );
  }
}
