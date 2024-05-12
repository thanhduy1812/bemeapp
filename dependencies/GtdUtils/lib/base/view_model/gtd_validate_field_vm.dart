// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gtd_utils/data/network/models/wrapped_result/result.dart';
import 'package:gtd_utils/utils/cubit/gtd_text_field_validation_cubit.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_text_field.dart';
import 'package:intl/intl.dart';

import 'package:rxdart/rxdart.dart';

enum GtdInputValidateBehavior { none, auto, manual }

enum GtdInputUserBehavior { typing, selection }

enum GtdInputSelectType { none, name, date, nationality, country, passport, membershipCard, city }

abstract class GtdValidateFieldVM {
  GtdFocusTextField focusfield = GtdFocusTextField(isValid: true);
  GtdTextFieldType type = GtdTextFieldType.none;
  GtdInputValidateBehavior inputValidateBehavior = GtdInputValidateBehavior.manual;
  GtdInputUserBehavior inputUserBehavior = GtdInputUserBehavior.typing;
  String label = "";
  String placeholder = "";
  String groupTitle = "";
  String hintLabel = "";
  bool allowEmpty = true;
  bool hasUnderlineBorder = true;
  bool hasFloatLabel = true;
  bool showRequired = false;
  String _text = "";

  String get text => _text;
  set text(String value) {
    _text = value;
    // Update text and set cursor at the end of text
    var offset = value.isEmpty ? 0 : controllerSearch.text.length;
    controllerSearch.value = TextEditingValue(text: value, selection: TextSelection.collapsed(offset: offset));
    switch (inputValidateBehavior) {
      case GtdInputValidateBehavior.auto:
        var result = validateViewModel();
        result.when((success) {
          updateValidateStream(value: text);
        }, (error) => updateValidateStream(error: error));
        break;
      case GtdInputValidateBehavior.manual:
        validateViewModel();
        updateValidateStream(value: text);
        break;
      default:
        updateValidateStream(value: text);
        break;
    }
  }

  bool get isEnable => inputUserBehavior == GtdInputUserBehavior.typing;
  bool get isValid => validateViewModel().when((success) => true, (error) => false);

  BehaviorSubject<String> _validateSubject = BehaviorSubject.seeded("");
  Stream<String> get validateStream => _validateSubject.stream;
  Sink<String> get validateSink => _validateSubject.sink;

  String get inputLabel => showRequired ? '$label *' : label;
  String get inputPlaceholder => showRequired ? '$placeholder *' : placeholder;

  GtdValidateFieldVM({
    this.type = GtdTextFieldType.none,
    this.inputValidateBehavior = GtdInputValidateBehavior.manual,
    this.inputUserBehavior = GtdInputUserBehavior.typing,
    this.label = "",
    this.placeholder = "",
    this.groupTitle = "",
    this.hintLabel = "",
    this.allowEmpty = true,
    this.hasUnderlineBorder = true,
    this.hasFloatLabel = true,
    this.showRequired = false,
    String? text,
  });
  final TextEditingController controllerSearch = TextEditingController();

  bool validateInput({bool showError = true}) {
    var validateResult = validateViewModel();
    return validateResult.when((success) {
      updateValidateStream(value: text);
      return true;
    }, (error) {
      if (showError) {
        updateValidateStream(error: error);
      }
      return false;
    });
  }

  void onChangeValue(String value) {
    _text = value;
    validateInput();
  }

  void updateValidateStream({String? value, String? error}) {
    if (value != null) {
      if (_validateSubject.isClosed) {
        _validateSubject = BehaviorSubject.seeded(value);
      } else {
        _validateSubject.sink.add(value);
      }
    }
    if (error != null) {
      _validateSubject.addError(error);
    }
  }

  Result<bool, String> validateViewModel() {
    bool isValid = true;
    String errorMess = "";
    String value = text;

    bool allowValidate = inputValidateBehavior == GtdInputValidateBehavior.auto ||
        inputValidateBehavior == GtdInputValidateBehavior.manual;
    if (allowValidate) {
      if (!allowEmpty && (value.isEmpty)) {
        // Logger.e("error empty input");
        isValid = false;
        if (isEnable == false) {
          errorMess = 'Vui lòng chọn ${label.toLowerCase()}';
        } else {
          errorMess = 'Vui lòng nhập ${label.toLowerCase()}';
        }
        // if (viewModel.groupTitle.isNotEmpty) {
        //   errorMess += " của ${viewModel.groupTitle.toLowerCase()}";
        // }
      } else {
        RegExp regex = RegExp(type.validationExpression);
        if (!regex.hasMatch(value)) {
          isValid = false;
          errorMess = '$label không hợp lệ!';
        }
      }
    }
    focusfield.isValid = isValid;
    return (isValid) ? Success(isValid) : Error(errorMess);
  }

  void initStreamIfClosed() {
    if (_validateSubject.isClosed) {
      _validateSubject = BehaviorSubject.seeded(text);
    }
  }

  void dispose() {
    if (kDebugMode) {
      print("GtdValidateFieldVM - dispose");
    }
    _validateSubject.close();
  }
}

class GtdInputTextFieldVM extends GtdValidateFieldVM {
  final GtdInputSelectType selectType;
  GtdInputTextFieldVM({
    this.selectType = GtdInputSelectType.none,
    super.type,
    super.inputValidateBehavior,
    super.inputUserBehavior,
    super.label,
    super.placeholder,
    super.groupTitle,
    super.hintLabel,
    super.allowEmpty,
    super.hasUnderlineBorder,
    super.hasFloatLabel,
    super.text,
    super.showRequired,
  }) {
    // if (type == GtdTextFieldType.dateTime || type == GtdTextFieldType.selection) {
    //   super.isEnable = false;
    // }
  }

  void onSelectedValue(String? value) {
    if (value != null) {
      text = value;
    }
  }
}

class GtdSelectDateTextFieldVM extends GtdValidateFieldVM {
  DateTime? _selectedDate;
  DateTime? minDate;
  DateTime? maxDate;

  DateTime? get selectedDate => _selectedDate;

  set selectedDate(DateTime? value) {
    _selectedDate = value;
    if (value != null) {
      try {
        String dateStr = DateFormat("dd/MM/yyyy").format(selectedDate!);
        text = dateStr;
      } catch (e) {
        text = "";
      }
    } else {
      text = "";
    }
  }

  GtdSelectDateTextFieldVM({
    super.groupTitle = "",
    DateTime? selectedDate,
    this.minDate,
    this.maxDate,
    super.allowEmpty,
    super.hasUnderlineBorder,
    super.inputValidateBehavior = GtdInputValidateBehavior.manual,
    super.text,
    super.label,
    super.placeholder,
  }) : _selectedDate = selectedDate {
    type = GtdTextFieldType.dateTime;
    inputUserBehavior = GtdInputUserBehavior.selection;
    if (selectedDate != null) {
      this.selectedDate = selectedDate;
    }
  }
  String get selectDateString {
    if (selectedDate != null) {
      return DateFormat("dd/MM/yyyy").format(selectedDate!);
    } else {
      return "";
    }
  }
}
