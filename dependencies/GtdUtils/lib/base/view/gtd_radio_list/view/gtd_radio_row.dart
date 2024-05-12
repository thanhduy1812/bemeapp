import 'package:flutter/material.dart';
import 'package:gtd_utils/base/view/base_view.dart';
import 'package:gtd_utils/base/view/gtd_radio_list/view_model/gtd_radio_row_viewmodel.dart';
import 'package:gtd_utils/data/network/network.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_radio_title.dart';

class GtdRadioRow<K> extends BaseView<GtdRadioRowViewModel<K>> {
  final List<GtdRadioTitle<K>> Function(BuildContext radioRowContext, K? groupValue, Sink<K?> groupValueSink)
      radiosBuilder;
  const GtdRadioRow({super.key, required super.viewModel, required this.radiosBuilder});

  @override
  Widget buildWidget(BuildContext context) {
    return StreamBuilder(
        initialData: viewModel.groupValue,
        stream: viewModel.groupValueController.stream,
        builder: (context, snapshot) {
          Logger.i("Rebuild GtdRadioRow");
          viewModel.groupValue = snapshot.data;
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: radiosBuilder(context, snapshot.data, viewModel.groupValueController.sink),
          );
        });
  }
}
