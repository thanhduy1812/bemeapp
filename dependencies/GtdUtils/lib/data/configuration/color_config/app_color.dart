import 'package:flutter/material.dart';
import 'package:gtd_utils/constants/app_const.dart';
import 'package:gtd_utils/data/configuration/color_config/colors_extension.dart';
import 'package:gtd_utils/data/configuration/gtd_app_config.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_tuple.dart';

class AppColors {
  static MaterialColor get mainColor {
    ThemeMode? themMode = AppConst.shared.themeMode;
    GtdAppSupplier supplier = AppConst.shared.appScheme.appSupplier;
    return CustomColors.mainAppColor(supplier: supplier, themeMode: themMode ?? ThemeMode.system);
  }

  static Color get lightMainColor {
    ThemeMode? themMode = AppConst.shared.themeMode;
    GtdAppSupplier supplier = AppConst.shared.appScheme.appSupplier;
    return CustomColors.lightMainAppColor(supplier: supplier, themeMode: themMode ?? ThemeMode.system);
  }

  static Color get mediumMainColor {
    ThemeMode? themMode = AppConst.shared.themeMode;
    GtdAppSupplier supplier = AppConst.shared.appScheme.appSupplier;
    return CustomColors.mediumMainAppColor(supplier: supplier, themeMode: themMode ?? ThemeMode.system);
  }

  static Color get errorColor {
    return CustomColors.mainRed;
  }

  static Color get boldText {
    return Colors.grey.shade900;
  }

  static Color get normalText {
    return Colors.grey.shade900;
  }

  static Color get subText {
    return Colors.grey.shade600;
  }

  static Color get strikeText {
    return Colors.grey.shade500;
  }

  static Color get currencyText {
    return CustomColors.mainOrange;
  }

  static Color get buttonColor {
    ThemeMode? themMode = AppConst.shared.themeMode;
    GtdAppSupplier supplier = AppConst.shared.appScheme.appSupplier;
    return CustomColors.mainAppColor(supplier: supplier, themeMode: themMode ?? ThemeMode.system);
  }

  static LinearGradient get appGradient {
    ThemeMode? themMode = AppConst.shared.themeMode;
    GtdAppSupplier supplier = AppConst.shared.appScheme.appSupplier;
    Tuple<Color, Color> tuple =
        CustomColors.gradientColors(supplier: supplier, themeMode: themMode ?? ThemeMode.system);
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: const [0.1, 1],
      colors: [tuple.item1, tuple.item2],
    );
  }

  static LinearGradient get boxGreyGradient {
    Tuple<Color, Color> tuple = Tuple(item1: Colors.grey.shade200, item2: Colors.white);
    return LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: const [0.1, 1],
      colors: [tuple.item1, tuple.item2],
    );
  }
}
