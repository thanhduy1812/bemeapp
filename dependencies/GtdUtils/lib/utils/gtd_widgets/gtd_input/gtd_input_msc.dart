import 'package:flutter/material.dart';
import 'package:gtd_utils/helpers/extension/colors_extension.dart';

class GtdInputMsc {
  static BoxDecoration inputDecoration = BoxDecoration(
    border: Border.all(
      color: GtdColors.blueGrey,
    ),
    borderRadius: BorderRadius.circular(6),
  );

  static BoxDecoration inputErrorDecoration = BoxDecoration(
    border: Border.all(
      color: GtdColors.crimsonRed,
    ),
    borderRadius: BorderRadius.circular(6),
  );

  static TextStyle inputStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: GtdColors.inkBlack,
  );

  static TextStyle errorStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: GtdColors.crimsonRed,
  );
}

enum GtdInputValidation {
  required,
  invalid,
  valid,
  notMatched,
}

enum GtdInputValidationField {
  text,
  email,
  phoneNumber,
}

extension GtdInputValidationFieldExt on GtdInputValidationField {
  TextInputType inputType() {
    switch (this) {
      case GtdInputValidationField.text:
        return TextInputType.text;
      case GtdInputValidationField.email:
        return TextInputType.emailAddress;
      case GtdInputValidationField.phoneNumber:
        return TextInputType.phone;
    }
  }
}