import 'package:flutter/material.dart';
import 'package:gtd_utils/data/configuration/color_config/app_color.dart';

class GtdInfoRow extends StatelessWidget {
  final String leftText;
  final TextStyle? leftTextStyle;
  final String rightText;
  final Widget? rightWidget;
  final TextStyle? rightTextStyle;
  final Widget? rightIcon;
  final Color? rightColor;
  final EdgeInsets? padding;
  final MainAxisAlignment mainAxisAlignment;
  const GtdInfoRow(
      {super.key,
      required this.leftText,
      this.rightText = "",
      this.rightWidget,
      this.leftTextStyle,
      this.rightIcon,
      this.rightTextStyle,
      this.rightColor,
      this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: _createTwoTextRow(leftText: leftText, rightText: rightText, rightWidget: rightWidget),
    );
  }

  Row _createTwoTextRow({required String leftText, required String rightText, Widget? rightWidget}) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Text(
          leftText,
          style: leftTextStyle ?? TextStyle(fontSize: 15, color: Colors.grey.shade600, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: rightWidget ??
              Text(
                rightText,
                style: rightTextStyle ??
                    TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: rightColor ?? AppColors.boldText,
                    ),
                textAlign: TextAlign.right,
              ),
        ),
        rightIcon ?? const SizedBox()
      ],
    );
  }

  static Row seperatedRow({required Widget title, Color? color}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        child: title,
      ),
      const SizedBox(
        width: 8,
      ),
      Icon(
        Icons.keyboard_arrow_right,
        size: 26,
        color: color ?? AppColors.mainColor,
      )
    ]);
  }

  static Row twoColumn(
      {required Widget leftWidget,
      required Widget rightWidget,
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.spaceBetween,}) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [leftWidget, rightWidget]);
  }
}
