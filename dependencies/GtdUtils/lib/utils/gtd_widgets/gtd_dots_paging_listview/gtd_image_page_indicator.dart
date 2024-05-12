import 'package:flutter/material.dart';
import 'package:gtd_utils/helpers/extension/colors_extension.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GtdImagePageIndicator {
  Widget scrollingDotsIndicator({
    required PageController controller,
    required int count,
    required BuildContext context,
  }) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: ScrollingDotsEffect(
        dotColor: GtdColors.blueGrey,
        activeDotColor: GtdColors.appMainColor(context),
        dotHeight: 8,
        dotWidth: 8,
      ),
    );
  }
}
