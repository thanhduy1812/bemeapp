import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtd_utils/base/view_model/gtd_validate_field_vm.dart';
import 'package:rxdart/rxdart.dart';

part 'gtd_text_field_validation_state.dart';

enum GtdTextFieldType {
  none(TextInputType.text),
  name(TextInputType.name),
  email(TextInputType.emailAddress),
  userName(TextInputType.name),
  // phoneIOS(TextInputType.numberWithOptions(signed: true, decimal: true)),
  phoneIOS(TextInputType.phone),
  phoneAndroid(TextInputType.phone),
  tax(TextInputType.text),
  dateTime(TextInputType.datetime),
  selection(TextInputType.text),
  number(TextInputType.numberWithOptions(signed: true, decimal: true));

  final TextInputType keyboardType;
  const GtdTextFieldType(this.keyboardType);
}

extension GtdTextFieldTypeExp on GtdTextFieldType {
  String get typingExpression {
    switch (this) {
      case GtdTextFieldType.name:
        return r"[A-Za-z ]";
      case GtdTextFieldType.email:
        return r"[A-Z0-9a-z@_\\-\\.]";
      case GtdTextFieldType.userName:
        return r"[A-Za-z0-9_.]";
      case GtdTextFieldType.phoneIOS:
      case GtdTextFieldType.phoneAndroid:
        return r"[0-9]";
      case GtdTextFieldType.tax:
        return r"[0-9-]";
      case GtdTextFieldType.number:
        return r"[0-9]";
      default:
        return r".*";
    }
  }

  String get validationExpression {
    switch (this) {
      case GtdTextFieldType.name:
        return r"[A-Za-z ]";
      case GtdTextFieldType.email:
        return r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$";
      case GtdTextFieldType.userName:
        return r"[A-Za-z0-9_.]";
      case GtdTextFieldType.phoneIOS:
      case GtdTextFieldType.phoneAndroid:
        return r"(09)[0-9 ]{8,10}|(07)[0-9 ]{8,10}|(03)[0-9 ]{8,10}|(05)[0-9 ]{8,10}|(01)[0-9 ]{8,11}|(08)[0-9 ]{8,10}";
      case GtdTextFieldType.tax:
        return r"^(?=.{10}$)[0-9]{10,10}|^(?=.{14}$)[0-9]{10}[-]{1}[0-9]{3}";
      case GtdTextFieldType.number:
        return r"[0-9]";
      default:
        return ".*";
    }
  }
}

class AsciiInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String s = newValue.text.split(RegExp(r'[^\u0000-\u007F]')).join('');
    return TextEditingValue(
      text: s,
      selection: newValue.selection,
    );
  }
}

StreamTransformer<T, T> skipFirstStreamTrasnformer<T>() {
  bool hasSkipped = false;
  return StreamTransformer<T, T>.fromHandlers(
    handleData: (data, sink) {
      if (hasSkipped) {
        sink.add(data);
      } else {
        hasSkipped = true;
      }
    },
  );
}

class GtdTextFieldValidationCubit extends Cubit<GtdTextFieldValidationState> {
  GtdTextFieldValidationCubit() : super(const GtdTextFieldValidationCubitInitial(true, ""));

  final BehaviorSubject<GtdValidateFieldVM> textFieldVMSubject = BehaviorSubject<GtdValidateFieldVM>();

  late GtdValidateFieldVM viewModel;

  Stream<GtdValidateFieldVM> get textFieldVMStream => textFieldVMSubject.stream.transform(validateTFVM);

  //Stream for realtime validation textfield
  final validateTFVM = StreamTransformer<GtdValidateFieldVM, GtdValidateFieldVM>.fromHandlers(
    handleData: (data, sink) {
      var validateResult = data.validateViewModel();
      validateResult.when((success) => sink.add(data), (error) => sink.addError(error));
    },
  );

  void initTextFieldVM(GtdValidateFieldVM viewModel) {
    this.viewModel = viewModel;
    this.viewModel.initStreamIfClosed();
    textFieldVMSubject.add(viewModel);
    viewModel.validateStream.listen((event) {
      textFieldVMSubject.sink.add(viewModel);
    }, onError: (error) {
      textFieldVMSubject.sink.addError(error);
    });
  }

  void updateValueTF(String value) {
    viewModel.text = value;
  }

  Stream<GtdValidateFieldVM> validationCombineStream() {
    return textFieldVMSubject.stream;
    // return Rx.combineLatest2(textFieldVMSubject.stream, viewModel.valueStream, (a, b) {
    //   return a;
    // });
  }

  // void validateTextFieldVM(String value) {
  //   viewModel.validateInput();
  //   viewModel.valueStream.doOnError((p0, p1) {
  //     if (p0 is String) {
  //       textFieldVMSubject.sink.addError(p0);
  //     }
  //     print("$p0");
  //   });
  // }

  @override
  Future<void> close() {
    textFieldVMSubject.close();
    viewModel.dispose();
    return super.close();
  }
}
