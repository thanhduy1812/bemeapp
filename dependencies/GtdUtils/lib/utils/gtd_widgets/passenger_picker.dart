library passenger_picker;

import 'package:flutter/material.dart';

typedef OnTapCallback = void Function(int newValue);

class PassengerPicker extends StatelessWidget {
  /// Value default */
  final int defaultValue;

  /// Max value */
  final int max;

  /// Min value */
  final int min;

  /// Controller to retrieve the current value */
  final StepperController? controller;

  /// Space between the buttons and the text */
  final double space;

  /// Callback onPressed */
  final OnTapCallback? onPressed;

  /// Icon from increment action, default value is Icon(Icons.add_circle) */
  late final Widget iconIncrement;

  /// iconIncrement color, if the property is filled, it will overwrite the color informed in iconColor*/
  final Color? iconIncrementColor;

  /// Icon from Decrement action, default value is Icon(Icons.remove_circle_outline) */
  late final Widget iconDecrement;

  /// IconDecrement color, if the property is filled, it will overwrite the color informed in iconColor*/
  final Color? iconDecrementColor;

  /// Color default from buttons */
  final Color? iconColor;

  /// Radius of buttons */
  final double splashRadius;

  /// TextStyle of text*/
  final TextStyle? textStyle;

  PassengerPicker({
    Key? key,
    this.controller,
    this.defaultValue = 0,
    this.max = 9,
    this.min = 0,
    this.space = 16,
    this.onPressed,
    Widget? iconIncrement,
    Widget? iconDecrement,
    this.iconIncrementColor,
    this.iconDecrementColor,
    this.iconColor,
    this.splashRadius = 15.0,
    this.textStyle,
  }) : super(key: key) {
    this.iconIncrement = iconIncrement ??
        Icon(Icons.add, color: iconIncrementColor ?? iconColor);
    this.iconDecrement = iconDecrement ??
        Icon(Icons.remove, color: iconDecrementColor ?? iconColor);
  }

  @override
  Widget build(BuildContext context) {
    int actual = defaultValue;
    controller?.currentValue = actual;
    return Row(
      children: [
        InkWell(
          child: SizedBox(
            width: 32,
            height: 32,
            child: IconButton(
              padding: EdgeInsets.zero,
              splashRadius: splashRadius,
              icon: iconDecrement,
              constraints: const BoxConstraints(),
              onPressed: (actual == min)
                  ? null
                  : () {
                      if (actual > min) {
                        actual--;
                        if (onPressed != null) onPressed!(actual);
                      }
                    },
            ),
          ),
        ),
        SizedBox(width: space),
        SizedBox(
          width: 15,
          child: Text(
            actual.toString(),
            style: textStyle,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(width: space),
        InkWell(
          child: SizedBox(
            width: 32,
            height: 32,
            child: IconButton(
              padding: EdgeInsets.zero,
              splashRadius: splashRadius,
              icon: iconIncrement,
              constraints: const BoxConstraints(),
              onPressed: (actual == max)
                  ? null
                  : () {
                      if (actual < max) {
                        actual++;
                        if (onPressed != null) onPressed!(actual);
                      }
                    },
            ),
          ),
        ),
      ],
    );
  }
}

class StepperController {
  int currentValue = 0;
}
