import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtd_utils/base/bloc/cubit/rebuild_widget_cubit.dart';
import 'package:gtd_utils/base/view/base_view.dart';
import 'package:gtd_utils/base/view_model/base_page_view_model.dart';
import 'package:gtd_utils/utils/popup/gtd_app_loading.dart';
import 'package:meta/meta.dart';

// typedef BuilderCallBack = Builder Function(BuildContext callbackContext);
typedef BaseWidgetBuilder<T> = Widget Function(BuildContext context);
// typedef BaseWidgetBuilder<T> = Widget Function(BuildContext context, T state);

class BaseStatelessPage<T extends BasePageViewModel> extends StatelessWidget {
  final T viewModel;

  const BaseStatelessPage({super.key, required this.viewModel});

  static String get route => "baseRoute";

  String getRoute() => route;

  // static String get route => runtimeType.toString();
  @protected
  List<Widget> buildTrailingActions(BuildContext pageContext) {
    return [];
  }

  @protected
  Widget? titleWidget() {
    return null;
  }

  @protected
  Widget? floatingButton(BuildContext context) {
    return null;
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
                        ? Text(
                            viewModel.title!,
                            style: const TextStyle(
                              fontSize: 17,
                            ),
                          )
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
      actions: buildTrailingActions(pageContext),
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

  // Widget buildComposite({required BuildContext pageContext, required WidgetCallBack callBack}) {
  //   return callBack.call(pageContext);
  // }
  BaseWidgetBuilder widgetBuild() {
    return (context) {
      return const SizedBox();
    };
  }

  @protected
  List<BlocProvider> initProviders() {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return GtdAppLoading(
      child: BlocProvider(
        create: (context) => RebuildWidgetCubit()..configLoading(),
        child: BlocBuilder<RebuildWidgetCubit, RebuildWidgetState>(
          builder: (rebuildContext, state) {
            return InjectorWidget(
              viewModel: viewModel,
              child: Builder(builder: (BuildContext inheritedtContext) {
                return Scaffold(
                  backgroundColor: viewModel.backgroundColor ?? Colors.grey.shade100,
                  extendBodyBehindAppBar: viewModel.extendBodyBehindAppBar,
                  // resizeToAvoidBottomInset: false,
                  appBar: buildAppbar(inheritedtContext),
                  body: buildBody(inheritedtContext),
                  bottomNavigationBar: buildBottomBar(inheritedtContext),
                  floatingActionButton: floatingButton(inheritedtContext),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
