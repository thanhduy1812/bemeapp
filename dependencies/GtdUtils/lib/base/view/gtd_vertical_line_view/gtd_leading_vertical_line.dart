import 'package:flutter/material.dart';
import 'package:gtd_utils/data/configuration/color_config/colors_extension.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_dash_border/gtd_dashed_border.dart';

class GtdLeadingVerticalLine extends StatelessWidget {
  final Widget child;
  final EdgeInsets linePadding;
  const GtdLeadingVerticalLine({super.key, required this.child, this.linePadding = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return GtdDashedBorder(
        color: CustomColors.mainOrange,
        strokeWidth: 1,
        dashPattern: const [1, 1],
        strokeCap: StrokeCap.square,
        padding: linePadding,
        customPath: (size) => Path()
          ..addOval(Rect.fromCircle(center: const Offset(0, 1), radius: 2))
          ..addOval(Rect.fromCircle(center: const Offset(0, 1), radius: 1))
          ..moveTo(0, 1)
          ..lineTo(0, size.height)
          ..addOval(Rect.fromCircle(center: Offset(0, size.height - 1), radius: 2))
          ..addOval(Rect.fromCircle(center: Offset(0, size.height - 1), radius: 1)),
        child: child);
  }
}
