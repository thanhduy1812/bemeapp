import 'package:flutter/material.dart';
import 'package:gtd_utils/helpers/extension/colors_extension.dart';

class GtdRadio<T> extends StatelessWidget {
  final Widget? selectedIcon;
  final Widget? unselectedIcon;
  final Widget? disableIcon;
  final EdgeInsets? padding;
  final T? groupValue;
  final T value;
  final ValueChanged<T>? onChanged;

  const GtdRadio({
    Key? key,
    this.selectedIcon = const Icon(Icons.radio_button_checked),
    this.unselectedIcon = const Icon(Icons.radio_button_off),
    this.padding,
    this.disableIcon,
    this.groupValue,
    required this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = value == groupValue;
    return InkWell(
        onTap: onChanged == null
            ? null
            : () {
                onChanged?.call(value);
                // if (value != groupValue) {
                //   onChanged(value);
                // }
              },
        child: Padding(
          padding: padding ?? const EdgeInsets.all(0),
          child: isSelected ? selectedIcon : unselectedIcon,
        ));
  }
}

class GtdSimpleRadioWidget extends StatelessWidget {
  final bool isSelected;
  final double size;

  const GtdSimpleRadioWidget({
    super.key,
    this.isSelected = false,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 2),
        border: Border.all(
          color: GtdColors.blueGrey,
          width: 2,
        ),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: size / 2,
                height: size / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(size / 4),
                  color: GtdColors.appMainColor(context),
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
