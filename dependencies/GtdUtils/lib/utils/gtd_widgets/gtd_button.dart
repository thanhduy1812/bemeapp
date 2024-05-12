library gtd_button;

import 'package:flutter/material.dart';
import 'package:gtd_utils/data/configuration/color_config/app_color.dart';

class GtdButton<T> extends StatelessWidget {
  final ValueChanged<bool?>? onPressed;
  final String text;
  final double? height;
  final double? width;
  final Color? colorText;
  final double? fontSize;
  final Widget? icon;
  final Widget? leadingIcon;
  final double? borderRadius;
  final FontWeight? fontWeight;
  final Gradient? gradient;
  final BoxBorder? border;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final bool isEnable;

  const GtdButton({
    super.key,
    this.onPressed,
    required this.text,
    this.height,
    this.width,
    this.colorText,
    this.icon,
    this.leadingIcon,
    this.borderRadius,
    this.fontWeight,
    this.gradient,
    this.color,
    this.border,
    this.padding,
    this.fontSize,
    this.isEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: InkWell(
        child: Container(
          padding: padding,
          height: height ?? 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 6)),
            gradient: gradient,
            border: border,
            color: isEnable
                ? color
                : (color ?? AppColors.buttonColor).withOpacity(0.4),
          ),
          child: TextButton(
              onPressed: !isEnable
                  ? null
                  : () {
                      if (onPressed != null) {
                        onPressed!(true);
                      }
                    },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.transparent),
                  padding: const MaterialStatePropertyAll(EdgeInsets.zero),
                  shape: borderRadius != null
                      ? MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular((borderRadius! - 10)),
                              side: const BorderSide(
                                color: Colors.transparent,
                              )))
                      : null),
              child: Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.center,
                runSpacing: icon != null ? 10 : 0,
                children: [
                  leadingIcon ?? const SizedBox(),
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      color: colorText ?? Colors.white,
                      fontWeight: fontWeight ?? FontWeight.w600,
                      fontSize: fontSize ?? 13,
                    ),
                  ),
                  icon ?? const SizedBox()
                ],
              )),
        ),
      ),
    );
  }
}
