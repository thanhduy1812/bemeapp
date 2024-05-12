import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:gtd_utils/utils/list_view_helper/gtd_paging_scroll_physics.dart';

class GtdDotsPagingListView extends StatelessWidget {
  // final double widthDimension;
  final int itemCount;
  final Widget Function(int index) builder;
  final int numberDots;
  final ScrollController imagesController = ScrollController();
  GtdDotsPagingListView({super.key, required this.builder, this.numberDots = 5, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    ScrollController imagesController = ScrollController();
    int minDot = [numberDots, itemCount].min;
    
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          child: DefaultTabController(
            length: minDot,
            child: StatefulBuilder(builder: (context, setState) {
              TabController tabController = DefaultTabController.of(context);
              imagesController.addListener(
                () {
                  var pageIndex =
                      (((imagesController.offset + constraints.maxWidth / 2) / constraints.maxWidth).abs() % numberDots)
                          .floor();
                  tabController.index = pageIndex;
                },
              );
              return Stack(alignment: Alignment.bottomCenter, children: [
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: GtdPagingScrollPhysics(itemDimension: constraints.maxWidth),
                  controller: imagesController,
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: constraints.maxWidth,
                      child: builder(index), //For get tabcontroller from context
                    );
                  },
                ),
                (minDot > 1)
                    ? TabPageSelector(
                        color: Colors.grey.shade200,
                        borderStyle: BorderStyle.none,
                        selectedColor: Colors.green,
                        indicatorSize: 8,
                        controller: tabController,
                      )
                    : const SizedBox(),
              ]);
            }),
          ),
        );
      },
    );
  }
}
