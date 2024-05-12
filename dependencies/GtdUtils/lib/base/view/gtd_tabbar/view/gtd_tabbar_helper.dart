import 'package:flutter/material.dart';
import 'package:gtd_utils/data/configuration/color_config/app_color.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_call_back.dart';

import 'gtd_tab.dart';

class GtdTabbarHelper with ChangeNotifier {
  static TabBar buildGotadiTabbar(
      {required List<Widget> tabs, bool isScrollable = false, TabController? tabController}) {
    return TabBar(
      controller: tabController,
      indicator: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            spreadRadius: 0,
            blurRadius: 8,
            offset: Offset(2, 2), // changes position of shadow
          ),
        ],
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      dividerColor: Colors.white,
      labelColor: AppColors.boldText,
      unselectedLabelColor: AppColors.subText,
      overlayColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
      isScrollable: isScrollable,
      tabAlignment: TabAlignment.start,
      tabs: tabs,
    );
  }

  static TabBar buildGotadiUnderLineTabbar(
      {required List<Widget> tabs, bool isScrollable = false, TabController? tabController}) {
    return TabBar(
      controller: tabController,
      indicator: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(color: AppColors.mainColor, width: 3),
          )),
      // indicatorColor: Colors.lightGreen,
      indicatorSize: TabBarIndicatorSize.tab,
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      dividerColor: Colors.white,
      labelColor: AppColors.mainColor,
      unselectedLabelColor: AppColors.subText,
      overlayColor: const MaterialStatePropertyAll<Color>(Colors.transparent),
      isScrollable: isScrollable,
      tabs: tabs,
    );
  }

  static Widget gotadiSelectTabbars<T>(
      {required List<GtdTab> tabs, GtdCallback<({int index, T data})>? onSelected, bool isScrollable = false}) {
    return DefaultTabController(
        length: tabs.length,
        child: Builder(
          builder: (tabContext) {
            TabBar tabBar = buildGotadiTabbar(tabs: tabs, isScrollable: isScrollable);
            TabController tabController = DefaultTabController.of(tabContext);
            if (!tabController.hasListeners) {
              tabController.addListener(() {
                if (tabController.indexIsChanging) {
                  var index = tabController.index;
                  onSelected?.call((index: index, data: tabs[index].data));
                }
              });
            }

            return PreferredSize(preferredSize: tabBar.preferredSize, child: tabBar);
          },
        ));
  }
}
