import 'package:beme_english/home/app_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_call_back.dart';

class InputTextField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final Widget? leadingIcon;
  final GtdCallback<String>? onChanged;
  final GtdVoidCallback? onTap;
  final focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  final bool isSelection;
  InputTextField(
      {super.key,
      required this.hintText,
      this.labelText,
      this.leadingIcon,
      this.onChanged,
      this.isSelection = false,
      String initText = "",
      this.onTap}) {
    _textEditingController.text = initText;
  }

  @override
  Widget build(BuildContext context) {
    if (isSelection) {
      _textEditingController.selection = const TextSelection(baseOffset: 0, extentOffset: 0);
    }
    return TextField(
      controller: _textEditingController,
      focusNode: focusNode,
      readOnly: isSelection,
      onTapOutside: (event) {
        focusNode.unfocus();
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade500, width: 1.0, style: BorderStyle.solid)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade500, width: 1.0, style: BorderStyle.solid)),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey.shade300),
        floatingLabelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: appBlueDeepColor),
        hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey.shade300),
        filled: false,
        fillColor: Colors.white,
        focusColor: appBlueDeepColor,
        hoverColor: appBlueDeepColor,
        prefixIcon: leadingIcon,
      ),
      onChanged: (value) => onChanged?.call(value),
      onTap: () => onTap?.call(),
    );
  }
}
