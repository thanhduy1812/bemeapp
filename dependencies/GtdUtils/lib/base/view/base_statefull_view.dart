import 'package:flutter/material.dart';
import 'package:gtd_utils/base/view_model/base_view_model.dart';
import 'package:meta/meta.dart';

import 'base_view.dart';

abstract class BaseStatefullView<T extends BaseViewModel> extends StatefulWidget {
  final T viewModel;
  const BaseStatefullView({super.key, required this.viewModel});

  @override
  State<BaseStatefullView> createState() => _BaseStatefullViewState();
  @mustBeOverridden
  Widget buildWidget(BuildContext pageContext) {
    throw UnimplementedError();
  }

  @protected
  void dispose() {}
}

class _BaseStatefullViewState extends State<BaseStatefullView> {
  @override
  Widget build(BuildContext context) {
    return InjectorWidget(
      viewModel: widget.viewModel,
      child: Builder(
        builder: (injectorContext) {
          return widget.buildWidget(injectorContext);
        },
      ),
    );
  }
}
