// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:gtd_utils/base/view_model/item_select_vm.dart';
import 'package:gtd_utils/data/configuration/color_config/app_color.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_call_back.dart';

class GtdOutlineSelectButton<T extends ItemSelectVM<K>, K> extends StatefulWidget {
  final T viewModel;
  final GtdCallback<T>? onChanged;
  final Widget Function(BuildContext context, T item) itemBuilder;
  const GtdOutlineSelectButton({super.key, required this.viewModel, this.onChanged, required this.itemBuilder});

  @override
  State<GtdOutlineSelectButton<T, K>> createState() => _GtdOutlineSelectButtonState<T, K>();
}

class _GtdOutlineSelectButtonState<T extends ItemSelectVM<K>, K> extends State<GtdOutlineSelectButton<T, K>> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: () {
          setState(() {
            widget.viewModel.toggle();
            widget.onChanged?.call(widget.viewModel);
          });
        },
        child: widget.itemBuilder(context, widget.viewModel),
        // child: Card(
        //   elevation: 0,
        //   shape: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(16),
        //       borderSide: BorderSide(
        //           color: widget.viewModel.isSelected ? AppColors.mainColor : Colors.grey.shade100, width: 1)),
        //   margin: const EdgeInsets.symmetric(horizontal: 0),
        //   color: Colors.white,
        //   child: const Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 16),
        //     child: Center(
        //       child: Text.rich(
        //         TextSpan(children: [
        //           TextSpan(text: "Bun bo \n", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400)),
        //           TextSpan(text: "80,000 VND", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700))
        //         ]),
        //         textAlign: TextAlign.center,
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}

class GtdSelectItem<T extends ItemSelectVM> extends StatelessWidget {
  final T viewModel;
  final GtdCallback<T>? onSelect;
  final Widget centerItem;
  const GtdSelectItem({super.key, required this.viewModel, required this.centerItem, this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: InkWell(
        onTap: () {
          viewModel.toggle();
          onSelect?.call(viewModel);
        },
        child: Card(
          elevation: 0,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:
                  BorderSide(color: viewModel.isSelected ? AppColors.mainColor : Colors.grey.shade200, width: 1)),
          margin: const EdgeInsets.symmetric(horizontal: 0),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: centerItem,
            ),
          ),
        ),
      ),
    );
  }
}
