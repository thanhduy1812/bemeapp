import 'package:flutter/material.dart';
import 'package:gtd_utils/data/configuration/color_config/app_color.dart';
import 'package:gtd_utils/helpers/extension/colors_extension.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_call_back.dart';

class GtdInputSelectCell extends StatelessWidget {
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final String title;
  final String defaultSubTitle;
  final String subTitle;
  final bool hasData;
  final bool isEnable;
  final GtdVoidCallback? onSelect;

  const GtdInputSelectCell({
    super.key,
    this.leadingIcon,
    this.trailingIcon,
    required this.title,
    required this.subTitle,
    this.hasData = true,
    this.defaultSubTitle = "",
    this.isEnable = true,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnable ? 1 : 0.4,
      child: InkWell(
        onTap: onSelect,
        child: SizedBox(
          height: 72,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: ListTile(
                  leading: leadingIcon == null
                      ? null
                      : SizedBox(
                          height: 40,
                          width: 40,
                          child: FittedBox(
                            child: leadingIcon,
                          ),
                        ),
                  title: Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.boldText,
                    ),
                  ),
                  subtitle: Text(
                    hasData ? subTitle : defaultSubTitle,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color:
                          !hasData ? AppColors.currencyText : AppColors.subText,
                    ),
                  ),
                ),
              ),
              trailingIcon ??
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: SizedBox(
                      height: 30,
                      child: FittedBox(
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          color: GtdColors.appMainColor(context),
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
