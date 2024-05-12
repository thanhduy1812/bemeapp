// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gtd_utils/base/bloc/cubit/rebuild_widget_cubit.dart';
import 'package:gtd_utils/base/view/base_view.dart';
import 'package:gtd_utils/base/view_model/base_page_view_model.dart';
import 'package:meta/meta.dart';

class BaseViewController<T extends BasePageViewModel> extends StatefulWidget {
  final T viewModel;

  const BaseViewController({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  @override
  State<BaseViewController> createState() => _BaseViewControllerState();

  static String get route => "baseRoute";
  String getRoute() => route;
  // static String get route => runtimeType.toString();

  @protected
  AppBar buildAppbar(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      elevation: 0,
      backgroundColor: Colors.grey.shade500,
      title: Column(
        children: [
          (viewModel.title != null) ? Text(viewModel.title!) : const SizedBox(),
          (viewModel.subTitle != null)
              ? Text(
                  viewModel.subTitle!,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  @mustBeOverridden
  Widget buildBody(BuildContext context) {
    throw UnimplementedError();
  }

  @protected
  Widget buildBottomBar(BuildContext context) {
    throw UnimplementedError();
  }
}

class _BaseViewControllerState extends State<BaseViewController> {
  @override
  Widget build(BuildContext context) {
    return InjectorWidget(
      viewModel: widget.viewModel,
      child: Builder(
        builder: (context) {
          return BlocProvider(
            create: (context) => RebuildWidgetCubit(),
            child: BlocBuilder<RebuildWidgetCubit, RebuildWidgetState>(
              builder: (context, state) {
                return Scaffold(
                  backgroundColor: Colors.grey.shade50,
                  appBar: widget.buildAppbar(context),
                  body: widget.buildBody(context),
                  bottomNavigationBar: BottomAppBar(
                    child: widget.buildBottomBar(context),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
