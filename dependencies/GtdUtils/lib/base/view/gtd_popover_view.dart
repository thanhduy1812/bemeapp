

import 'package:flutter/material.dart';
import 'package:gtd_utils/base/view_model/gtd_validate_field_vm.dart';
import 'package:gtd_utils/helpers/extension/colors_extension.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_button.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_text_field.dart';

class GtdPopoverView extends StatelessWidget {
 final String title;
  final GtdInputTextFieldVM viewModel;
  GtdPopoverView({super.key, this.title = "", required this.viewModel});
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final textFieldViewModel = GtdInputTextFieldVM(
        label: viewModel.placeholder,
        type: viewModel.type,
        inputValidateBehavior: GtdInputValidateBehavior.auto);
    return Builder(builder: (BuildContext context) {
      return SafeArea(
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppBar(
                  title: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      title,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.close))
                  ],
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Nhập ${viewModel.label.toLowerCase()}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    GtdTextField(
                      viewModel: textFieldViewModel,
                      height: 60,
                      rightIcon: IconButton(
                        onPressed: () {
                          textFieldViewModel.text = "";
                        },
                        icon: const Icon(Icons.close),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      boxBorder: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade500, width: 1.0),
                          borderRadius: BorderRadius.circular(6)),
                    ),
                  ],
                )),
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: GtdButton(
                      borderRadius: 24,
                      onPressed: (value) {
                        Navigator.of(context).pop(textFieldViewModel.text);
                      },
                      gradient: GtdColors.appGradient(context),
                      text: "Tiếp tục"),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}