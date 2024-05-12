import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtd_utils/base/bloc/cubit/rebuild_widget_cubit.dart';
import 'package:gtd_utils/base/view/base_view.dart';
import 'package:gtd_utils/base/view/gtd_tabbar/view/gtd_tabbar_helper.dart';
import 'package:gtd_utils/base/view_model/base_page_view_model.dart';
import 'package:gtd_utils/utils/popup/gtd_app_loading.dart';
import 'package:meta/meta.dart';

class BaseTabbarPage<T extends BasePageViewModel> extends StatelessWidget {
  final T viewModel;

  const BaseTabbarPage({super.key, required this.viewModel});

  static String get route => "baseRoute";

  String getRoute() => route;

  // @mustBeOverridden
  TabBar get _tabBar => GtdTabbarHelper.buildGotadiTabbar(tabs: tabs);

  @protected
  List<Tab> get tabs => [];

  @protected
  Widget? titleWidget() {
    return null;
  }

  @protected
  PreferredSizeWidget? buildAppbarBottom() {
    return (tabs.isEmpty || tabs.length == 1)
        ? null
        : PreferredSize(preferredSize: _tabBar.preferredSize, child: _tabBar);
  }

  @protected
  AppBar? buildAppbar(BuildContext pageContext) {
    return AppBar(
      scrolledUnderElevation: 0,
      // systemOverlayStyle: SystemUiOverlayStyle.dark,
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light),
      elevation: 0,
      backgroundColor: Colors.white,
      title: ValueListenableBuilder(
        valueListenable: viewModel.subTitleNotifer,
        builder: (context, value, child) {
          return titleWidget() != null
              ? titleWidget()!
              : Column(
                  children: [
                    (viewModel.title != null)
                        ? Text(viewModel.title!)
                        : const SizedBox(),
                    (viewModel.subTitle != null)
                        ? Text(
                            value,
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 13,
                            ),
                          )
                        : const SizedBox(),
                  ],
                );
        },
      ),
      // bottom: (tabs.isEmpty || tabs.length == 1)
      //     ? null
      //     : PreferredSize(preferredSize: _tabBar.preferredSize, child: _tabBar),
      bottom: buildAppbarBottom(),
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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RebuildWidgetCubit()..configLoading(),
      child: GtdAppLoading(
        child: BlocBuilder<RebuildWidgetCubit, RebuildWidgetState>(
          builder: (rebuildContext, state) {
            return InjectorWidget(
              viewModel: viewModel,
              child: DefaultTabController(
                length: tabs.length,
                child: Scaffold(
                  backgroundColor:
                      viewModel.backgroundColor ?? Colors.grey.shade100,
                  // extendBody: true,
                  appBar: buildAppbar(rebuildContext),
                  body: buildBody(rebuildContext),
                  bottomNavigationBar: buildBottomBar(rebuildContext),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
