library gtd_button;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gtd_utils/constants/app_const.dart';
import 'package:gtd_utils/helpers/extension/colors_extension.dart';
import 'package:gtd_utils/helpers/extension/string_extension.dart';

enum GtdButtonRadioType { underline, circleCheck, checkMark }

class GtdButtonRadio<T> extends StatelessWidget {
  final ValueChanged<T?> onChanged;
  final T groupValue;
  final String text;
  final bool? isLoading;
  final T value;
  final BorderRadius? borderRadius;
  final GtdButtonRadioType type;

  const GtdButtonRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.borderRadius,
    this.type = GtdButtonRadioType.circleCheck,
    this.isLoading,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: InkWell(
        child: Container(
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadius ?? const BorderRadius.all(Radius.circular(100)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton.tonal(
                onPressed: () {
                  onChanged(value);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.transparent),
                ),
                child: Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: type == GtdButtonRadioType.underline ? 0 : 12,
                  children: [
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: isSelected ? Colors.grey.shade900 : Colors.grey.shade500),
                    ),
                    type == GtdButtonRadioType.circleCheck
                        ? (isSelected
                            ? Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: SvgPicture.asset(GtdString.pathForAsset(
                                    AppConst.shared.supplierResource, "assets/icons/checked.svg")),
                              )
                            : const SizedBox())
                        : const SizedBox(),
                  ],
                ),
              ),
              type == GtdButtonRadioType.underline
                  ? (Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xffed9922) : Colors.transparent,
                        borderRadius: BorderRadius.circular(2),
                        gradient: isSelected ? GtdColors.appGradient(context) : null,
                      ),
                      child: const Divider(
                        height: 4,
                        color: Colors.transparent,
                      ),
                    ))
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
