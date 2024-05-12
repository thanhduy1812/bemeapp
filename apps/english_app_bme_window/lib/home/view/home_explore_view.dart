import 'package:beme_english/home/app_bottom_bar.dart';
import 'package:beme_english/home/view_model/home_explore_viewmodel.dart';
import 'package:flutter/material.dart';

import 'package:gtd_utils/base/view/base_view.dart';
import 'package:gtd_utils/helpers/extension/build_context_extension.dart';
import 'package:gtd_utils/helpers/extension/image_extension.dart';

class HomeExploreView extends BaseView<HomeExploreViewModel> {
  const HomeExploreView({super.key, required super.viewModel});

  @override
  Widget buildWidget(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // SliverAppBar.large()
        SliverAppBar(
          pinned: true,
          snap: false,
          floating: false,
          expandedHeight: context.mediaQuery.size.width / 2.6,
          stretch: true,
          backgroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            background: GtdImage.imgFromAsset(assetPath: "assets/image/bemebanner.jpeg", fit: BoxFit.fitWidth),
          ),
        ),
        SliverToBoxAdapter(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            margin: EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: GtdImage.imgFromAsset(
                  assetPath: "assets/image/courseintro.jpg", fit: BoxFit.fitWidth, width: double.infinity),
            ),
          ),
        )),
        SliverToBoxAdapter(
            child: Card(
          margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32.0),
              topRight: Radius.circular(32.0),
            ),
          ),
          child: SizedBox(
            height: 350,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox(
                      child: Text("Why choose Beme Class?",
                          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: appBlueDeepColor),
                          textAlign: TextAlign.start)),
                ),
                Expanded(
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          height: 50,
                          child: Card(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: GtdImage.imgFromAsset(
                                    assetPath: "assets/image/course${index + 1}.JPG",
                                    fit: BoxFit.fitHeight,
                                    height: 50)),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(width: 16),
                      itemCount: 2),
                )
              ],
            ),
          ),
        )),
      ],
    );
  }
}
