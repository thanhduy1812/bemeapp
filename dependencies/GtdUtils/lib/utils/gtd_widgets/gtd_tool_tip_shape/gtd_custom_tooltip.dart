import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class GtdCustomTooltip {
  static Widget tooltipWidget({
    required Widget contentWidget,
    required Widget tooltipWidget,
    required Color backgroundColor,
    /// -> color for background , mainly use for the tail in this situation
    /// Set the color of the contentWidget
  }) {
    return JustTheTooltip(
      content: contentWidget,
      isModal: true,
      preferredDirection: AxisDirection.down,
      tailBaseWidth: 8,
      tailLength: 5,
      backgroundColor: backgroundColor,
      child: tooltipWidget,
    );
  }
}
