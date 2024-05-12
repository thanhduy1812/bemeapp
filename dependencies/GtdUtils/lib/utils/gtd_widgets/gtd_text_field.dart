// ignore_for_file: public_member_api_docs, sort_constructors_first
library passenger_picker;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtd_utils/base/view_model/gtd_validate_field_vm.dart';
import 'package:gtd_utils/data/configuration/color_config/app_color.dart';
import 'package:gtd_utils/utils/cubit/gtd_text_field_validation_cubit.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_call_back.dart';

class GtdFocusTextField {
  bool isValid = true;
  bool? isInteractive = true;
  FocusNode focusNode = FocusNode();
  GlobalKey<FormFieldState> formFieldKey = GlobalKey<FormFieldState>();

  GtdFocusTextField({required this.isValid, this.isInteractive}) {
    // if (isInteractive == false) {
    //   focusNode = AlwaysDisableFocusNode();
    // }
  }

  void dispose() {
    focusNode.dispose();
  }
}

class GtdTextField extends StatelessWidget {
  final GtdValidateFieldVM viewModel;

  final Widget? leftIcon;
  final Widget? rightIcon;
  final double? height;
  final bool isBoldTextWhenEmpty;
  final EdgeInsets? contentPadding;
  final BoxDecoration? boxBorder;
  final InputBorder? border;
  final bool isDisable;
  final VoidCallback? onSelect;
  final GtdCallback? onChanged;

  const GtdTextField({
    Key? key,
    required this.viewModel,
    this.leftIcon,
    this.rightIcon,
    this.height,
    this.contentPadding,
    this.boxBorder,
    this.border = InputBorder.none,
    this.isDisable = false,
    this.isBoldTextWhenEmpty = false,
    this.onSelect,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GtdTextFieldValidationCubit()..initTextFieldVM(viewModel),
      child: BlocBuilder<GtdTextFieldValidationCubit, GtdTextFieldValidationState>(
        builder: (context, state) {
          return StreamBuilder(
            stream: BlocProvider.of<GtdTextFieldValidationCubit>(context).validationCombineStream(),
            initialData: viewModel,
            builder: (context, snapshot) {
              bool isValid = !snapshot.hasError;
              String errorMess = snapshot.error.toString();
              // var colorValidate = (isValid)
              //     ? Color.fromRGBO(241, 241, 241, isDisable ? 0.4 : 1)
              //     : Theme.of(context).colorScheme.error;
              var colorIcon =
                  (isValid) ? Color.fromRGBO(18, 24, 38, isDisable ? 0.4 : 1) : Theme.of(context).colorScheme.error;
              var borderTF = border;
              bool hasText = (viewModel.controllerSearch.text.isNotEmpty);
              return Container(
                height: height ?? 60,
                decoration: boxBorder,
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: isDisable ? null : onSelect,
                  child: TextFormField(
                    key: viewModel.focusfield.formFieldKey,
                    scrollPadding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    controller: viewModel.controllerSearch,
                    keyboardType:
                        viewModel.type.keyboardType == TextInputType.name ? null : viewModel.type.keyboardType,
                    textInputAction: TextInputAction.done,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                        RegExp(viewModel.type.typingExpression),
                      ),
                    ],
                    onChanged: (value) {
                      BlocProvider.of<GtdTextFieldValidationCubit>(context).updateValueTF(value);
                      onChanged?.call(value);
                    },
                    textCapitalization: viewModel.type != GtdTextFieldType.email
                        ? TextCapitalization.sentences
                        : TextCapitalization.none,
                    focusNode: viewModel.focusfield.focusNode,
                    enabled: viewModel.isEnable,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: hasText ? FontWeight.w600 : FontWeight.w400,
                      color: AppColors.boldText,
                    ),
                    cursorHeight: 13,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: borderTF,
                      focusedBorder: borderTF,
                      focusedErrorBorder: borderTF,
                      enabledBorder: borderTF,
                      errorBorder: borderTF,
                      disabledBorder: borderTF,
                      labelStyle: MaterialStateTextStyle.resolveWith((states) {
                        bool hasBoldColor = !isDisable && isBoldTextWhenEmpty;
                        // Color labelColor = (isValid)
                        //     ? Color.fromRGBO(0, 0, 0, isDisable ? 0.4 : 1)
                        //     : Theme.of(context).colorScheme.error;
                        var disableStyle = TextStyle(
                          color: (hasText || hasBoldColor) ? AppColors.boldText : AppColors.subText,
                          fontSize: 15,
                          fontWeight: hasText ? FontWeight.w500 : FontWeight.w400,
                        );
                        var enableStyle = TextStyle(
                          color: (hasText || hasBoldColor) ? AppColors.boldText : AppColors.subText,
                          fontSize: 15,
                          fontWeight: hasText ? FontWeight.w600 : FontWeight.w400,
                        );

                        if (states.contains(MaterialState.disabled)) {
                          return disableStyle;
                        } else {
                          return enableStyle;
                        }
                      }),
                      labelText: (isValid) ? viewModel.inputLabel : errorMess,
                      hintText: viewModel.inputPlaceholder,
                      hintStyle: const TextStyle(fontSize: 15),
                      errorStyle: const TextStyle(height: 0),
                      floatingLabelStyle: TextStyle(
                        color: (isValid) ? Colors.grey.shade500 : Theme.of(context).colorScheme.error,
                        fontSize: 13,
                      ).apply(fontSizeFactor: 1.3),
                      // floatingLabelBehavior: !viewModel.hasFloatLabel
                      //     ? FloatingLabelBehavior.never
                      //     : isValid
                      //         ? FloatingLabelBehavior.auto
                      //         : FloatingLabelBehavior.always,
                      floatingLabelBehavior:
                          !viewModel.hasFloatLabel ? FloatingLabelBehavior.never : FloatingLabelBehavior.auto,
                      contentPadding: contentPadding ??
                          const EdgeInsets.symmetric(
                            horizontal: 0,
                            vertical: 0,
                          ),
                      prefixIcon: (leftIcon != null)
                          ? Padding(
                              padding: EdgeInsets.only(
                                left: contentPadding?.left ?? 0,
                                right: 12,
                              ),
                              child: SizedBox(child: leftIcon),
                            )
                          : null,
                      prefixIconColor: colorIcon,
                      suffixIcon: (rightIcon != null)
                          ? Padding(
                              padding: EdgeInsets.only(
                                left: 10,
                                right: contentPadding?.right ?? 0,
                              ),
                              child: SizedBox(child: rightIcon),
                            )
                          : null,
                      suffixIconColor: colorIcon,
                    ),
                    validator: (value) {
                      return "";
                    },
                    autovalidateMode: AutovalidateMode.disabled,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class StepperController {
  int currentValue = 0;
}

class ValidityNotifier extends ChangeNotifier {
  bool _isValid = false;

  bool get isValid => _isValid;

  void setValidity(bool isValid) {
    _isValid = isValid;
    notifyListeners();
  }
}
