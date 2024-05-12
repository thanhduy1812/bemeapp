import 'package:flutter/material.dart';
import 'package:gtd_utils/helpers/extension/image_extension.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_dots_paging_listview/gtd_image_page_indicator.dart';

class GtdImagePageView extends StatelessWidget {
  final List<String> images;
  final Function(int)? onImageTap;
  final PageController pageController;

  const GtdImagePageView({
    required this.images,
    required this.pageController,
    this.onImageTap,
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: pageController,
          itemCount: images.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                onImageTap?.call(index);
              },
              child: Hero(
                tag: images[index],
                child: GtdImage.cachedImgUrlWithPlaceholder(
                  url: images[index],
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        Positioned(
          bottom: 8,
          left: 0,
          right: 0,
          child: Center(
            child: GtdImagePageIndicator().scrollingDotsIndicator(
              controller: pageController,
              count: images.length,
              context: context,
            ),
          ),
        ),
      ],
    );
  }
}
