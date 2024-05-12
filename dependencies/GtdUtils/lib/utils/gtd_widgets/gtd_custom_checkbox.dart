import 'package:flutter/material.dart';

class GtdCheckbox extends StatefulWidget {
  /// [GFCheckbox] is a small box (as in a checklist) in which to place a check mark to make a selection with various customization options.
  const GtdCheckbox(
      {Key? key,
      this.size = 24,
      this.activeBgColor = Colors.white,
      this.inactiveBgColor = Colors.transparent,
      this.activeBorderColor = Colors.white,
      this.inactiveBorderColor,
      required this.onChanged,
      required this.value,
      this.activeIcon = const Icon(
        Icons.check,
        size: 20,
        color: Colors.white,
      ),
      this.inactiveIcon,
      this.gradient,
      this.customBgColor = Colors.green,
      this.autofocus = false,
      this.focusNode})
      : super(key: key);

  /// type of [double] which is GFSize ie, small, medium and large and can use any double value
  final double size;

  /// type of [Color] used to change the backgroundColor of the active checkbox
  final Color activeBgColor;

  /// type of [Color] used to change the backgroundColor of the inactive checkbox
  final Color inactiveBgColor;

  /// type of [Color] used to change the border color of the active checkbox
  final Color activeBorderColor;

  /// type of [Color] used to change the border color of the inactive checkbox
  final Color? inactiveBorderColor;

  /// Called when the user checks or unchecks the checkbox.
  final ValueChanged<bool>? onChanged;

  /// Used to set the current state of the checkbox
  final bool value;

  /// type of [Widget] used to change the  checkbox's active icon
  final Widget activeIcon;

  /// type of [Widget] used to change the  checkbox's inactive icon
  final Widget? inactiveIcon;

  final Gradient? gradient;

  /// type of [Color] used to change the background color of the custom active checkbox only
  final Color customBgColor;

  /// on true state this widget will be selected as the initial focus
  /// when no other node in its scope is currently focused
  final bool autofocus;

  /// an optional focus node to use as the focus node for this widget.
  final FocusNode? focusNode;

  @override
  GtdCheckboxState createState() => GtdCheckboxState();
}

class GtdCheckboxState extends State<GtdCheckbox> {
  bool get enabled => widget.onChanged != null;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => FocusableActionDetector(
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        enabled: enabled,
        child: InkResponse(
          highlightShape: BoxShape.rectangle,
          containedInkWell: true,
          canRequestFocus: enabled,
          onTap: widget.onChanged != null
              ? () {
                  widget.onChanged!(!widget.value);
                }
              : null,
          child: Container(
            height: widget.size,
            width: widget.size,
            decoration: BoxDecoration(
                color: widget.value ? widget.activeBgColor : Colors.white,
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: Colors.grey.shade200, width: 2)),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              child: widget.value
                  ? Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                        ),
                        Container(
                          margin: const EdgeInsets.all(4),
                          width: widget.size * 0.8,
                          height: widget.size * 0.8,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: widget.customBgColor,
                            borderRadius: const BorderRadius.all(Radius.circular(1)),
                            gradient: widget.gradient,
                          ),
                        )
                      ],
                    )
                  : widget.inactiveIcon,
            ),
          ),
        ),
      );
}
