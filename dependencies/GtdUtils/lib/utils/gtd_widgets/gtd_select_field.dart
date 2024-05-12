import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtd_utils/base/view_model/gtd_validate_field_vm.dart';
import 'package:gtd_utils/utils/cubit/gtd_text_field_validation_cubit.dart';

class GtdSelectField extends StatelessWidget {
  final GtdValidateFieldVM viewModel;

  final Widget? leftIcon;
  final Widget? rightIcon;
  final double? height;
  final EdgeInsets? contentPadding;
  final BoxDecoration? boxBorder;
  final InputBorder? border;
  final VoidCallback? onSelect;
  final String? hintRightText;
  const GtdSelectField(
      {super.key,
      required this.viewModel,
      this.leftIcon,
      this.rightIcon,
      this.height,
      this.contentPadding,
      this.boxBorder,
      this.border = InputBorder.none,
      this.hintRightText,
      this.onSelect});

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
                // String errorMess = snapshot.error.toString();
                // var colorValidate =
                //     (isValid) ? const Color.fromRGBO(241, 241, 241, 1) : Theme.of(context).colorScheme.error;
                var colorIcon = (isValid) ? const Color.fromRGBO(18, 24, 38, 1) : Theme.of(context).colorScheme.error;
                // var borderTF = (!viewModel.hasUnderlineBorder)
                //     ? InputBorder.none
                //     : UnderlineInputBorder(
                //         borderSide: BorderSide(
                //         color: colorValidate,
                //         width: 0.5,
                //       ));
                var borderTF = InputBorder.none;
                return Container(
                  height: height ?? 58,
                  decoration: boxBorder,
                  child: GestureDetector(
                    onTap: onSelect,
                    child: TextField(
                      key: viewModel.focusfield.formFieldKey,
                      controller: viewModel.controllerSearch,
                      keyboardType: viewModel.type.keyboardType,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(viewModel.type.typingExpression)),
                      ],
                      onChanged: (value) => BlocProvider.of<GtdTextFieldValidationCubit>(context).updateValueTF(value),
                      textCapitalization: TextCapitalization.sentences,
                      focusNode: viewModel.focusfield.focusNode,
                      enabled: viewModel.isEnable,
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.grey.shade900),
                      textAlign: TextAlign.end,
                      decoration: InputDecoration(
                        border: borderTF,
                        focusedBorder: borderTF,
                        focusedErrorBorder: borderTF,
                        enabledBorder: borderTF,
                        errorBorder: borderTF,
                        disabledBorder: borderTF,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: const EdgeInsets.symmetric(vertical: 16),
                        hintText: hintRightText ?? "Nhập",
                        hintStyle: TextStyle(fontSize: 15, color: Colors.grey.shade500),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(left: 0),
                          child: Text(
                            viewModel.label,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                        // prefixIcon: (leftIcon != null)
                        //     ? Padding(
                        //         padding: const EdgeInsets.only(left: 20, right: 20),
                        //         child: SizedBox(child: leftIcon),
                        //       )
                        //     : null,
                        // prefixIconColor: colorIcon,
                        suffixIcon: (rightIcon != null)
                            ? Padding(
                                padding: const EdgeInsets.only(left: 10, right: 0),
                                child: SizedBox(child: rightIcon),
                              )
                            : null,
                        suffixIconColor: colorIcon,
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
