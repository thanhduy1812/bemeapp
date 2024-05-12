import 'package:flutter/material.dart';
import 'package:gtd_utils/helpers/extension/colors_extension.dart';

class GtdTapWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final double? radius;

  const GtdTapWidget({
    required this.child,
    required this.onTap,
    this.backgroundColor,
    this.radius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(radius ?? 0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            radius: radius ?? 0,
            highlightColor: GtdColors.steelGrey.withOpacity(0.15),
            onTap: onTap,
            child: child,
          ),
        ),
      ),
    );
  }
}
