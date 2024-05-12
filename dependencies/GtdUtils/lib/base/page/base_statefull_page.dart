import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtd_utils/base/bloc/cubit/rebuild_widget_cubit.dart';
import 'package:gtd_utils/base/view/base_view.dart';
import 'package:gtd_utils/base/view_model/base_page_view_model.dart';
import 'package:gtd_utils/utils/popup/gtd_app_loading.dart';
import 'package:meta/meta.dart';

class BaseStatefulPage<T extends BasePageViewModel> extends StatefulWidget {
  final T viewModel;
  const BaseStatefulPage({super.key, required this.viewModel});

  @override
  State<BaseStatefulPage> createState() => _BaseStatefulPageState();

  static String get route => "baseRoute";
  String getRoute() => route;
  // static String get route => runtimeType.toString();

  @protected
  AppBar? buildAppbar(BuildContext pageContext) {
    return AppBar(
      scrolledUnderElevation: 0,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light),
      elevation: 0,
      backgroundColor: Colors.white,
      title: ValueListenableBuilder(
        valueListenable: viewModel.subTitleNotifer,
        builder: (context, value, child) {
          return Column(
            children: [
              (viewModel.title != null) ? Text(viewModel.title!) : const SizedBox(),
              (viewModel.subTitle != null)
                  ? Text(
                      value,
                      style: TextStyle(color: Colors.grey.shade500, fontSize: 13),
                    )
                  : const SizedBox(),
            ],
          );
        },
      ),
    );
  }

  @mustBeOverridden
  Widget buildBody(BuildContext pageContext) {
    throw UnimplementedError();
  }

  @protected
  Widget? buildBottomBar(BuildContext pageContext) {
    return null;
  }

  @protected
  List<BlocProvider> initProviders() {
    return [];
  }

  @protected
  void dispose() {}
}

class _BaseStatefulPageState extends State<BaseStatefulPage> {
  @override
  Widget build(BuildContext context) {
    return GtdAppLoading(
      child: BlocProvider(
        create: (context) => RebuildWidgetCubit()..configLoading(),
        child: BlocBuilder<RebuildWidgetCubit, RebuildWidgetState>(
          builder: (rebuildContext, state) {
            return InjectorWidget(
              viewModel: widget.viewModel,
              child: Builder(builder: (BuildContext inheritedtContext) {
                return Scaffold(
                  backgroundColor: Colors.grey.shade100,
                  appBar: widget.buildAppbar(inheritedtContext),
                  body: widget.buildBody(inheritedtContext),
                  bottomNavigationBar: widget.buildBottomBar(inheritedtContext),
                );
              }),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.dispose();
    super.dispose();
  }
}
