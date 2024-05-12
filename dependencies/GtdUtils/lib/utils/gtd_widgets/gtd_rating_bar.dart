import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gtd_utils/data/configuration/color_config/colors_extension.dart';

class GtdRatingBar extends StatelessWidget {
  const GtdRatingBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }

  static Widget ratingWithValue(double value, {double? itemSize}) {
    return RatingBar.builder(
      initialRating: value,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: itemSize ?? 26,
      itemPadding: const EdgeInsets.symmetric(horizontal: 0),
      ignoreGestures: true,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: CustomColors.mainOrange,
      ),
      onRatingUpdate: (rating) {
        if (kDebugMode) {
          print(rating);
        }
      },
    );
  }
}
