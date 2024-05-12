// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gtd_utils/data/configuration/color_config/app_color.dart';

import 'gtd_radio.dart';

class GtdRadioTitle<T> extends StatelessWidget {
  final String label;
  final TextStyle? labelStyle;
  final Widget? selectedIcon;
  final Widget? unselectedIcon;
  final Widget? disableIcon;
  final EdgeInsets padding;
  final double spacing;
  final TextDirection direction;
  final T? groupValue;
  final T value;
  final ValueChanged<T> onChanged;
  final bool shrinkWrap;
  const GtdRadioTitle(
      {super.key,
      required this.label,
      this.selectedIcon,
      this.unselectedIcon,
      this.disableIcon,
      this.padding = EdgeInsets.zero,
      this.groupValue,
      required this.value,
      this.labelStyle,
      this.spacing = 8,
      this.shrinkWrap = false,
      this.direction = TextDirection.ltr,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(value);
        // if (value != groupValue) {
        //   onChanged(value);
        // }
      },
      child: Padding(
        padding: padding,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textDirection: direction,
          children: <Widget>[
            // Radio<T>(
            //   activeColor: AppColors.mainColor,
            //   groupValue: groupValue,
            //   value: value,
            //   onChanged: (T? newValue) {
            //     onChanged(newValue as T);
            //   },
            // ),

            GtdRadio<T>(
                selectedIcon: selectedIcon ?? Icon(Icons.radio_button_checked, color: AppColors.mainColor),
                unselectedIcon: unselectedIcon ?? Icon(Icons.radio_button_off, color: AppColors.mainColor),
                groupValue: groupValue,
                value: value,
                onChanged: onChanged),
            SizedBox(
              width: spacing,
            ),
            Text(
              label,
              style: labelStyle,
            ),
            shrinkWrap ? const Spacer() : const SizedBox()
          ],
        ),
      ),
    );
  }
}
