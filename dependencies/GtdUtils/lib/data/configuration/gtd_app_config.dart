import 'package:flutter/material.dart';
import 'package:gtd_utils/data/configuration/gtd_app_theme.dart';

enum GtdAppScheme {
  beme('env.uat', GtdAppSupplier.beme, GtdPackageResoure.beme, true);

  final String envFile;
  final GtdAppSupplier appSupplier;
  final GtdPackageResoure packageResoure;
  final bool hasPayment;
  const GtdAppScheme(this.envFile, this.appSupplier, this.packageResoure, this.hasPayment);

  static GtdAppScheme getAppScheme(String env, String partner) {
    switch (partner) {
      case "beme":
        return (env == "prod") ? GtdAppScheme.beme : GtdAppScheme.beme;
      default:
        return (env == "prod") ? GtdAppScheme.beme : GtdAppScheme.beme;
    }
  }
}

enum GtdAppSupplier {
  beme(GtdAppTheme.beme);

  final GtdAppTheme appTheme;
  const GtdAppSupplier(this.appTheme);
}

enum GtdAppTheme {
  beme;

  const GtdAppTheme();
}

extension GtdAppThemeData on GtdAppTheme {
  ThemeData get lightTheme {
    switch (this) {
      case GtdAppTheme.beme:
        return GtdThemeData.beme;
    }
  }

  ThemeData get darkTheme {
    switch (this) {
      case GtdAppTheme.beme:
        return GtdThemeData.beme;
    }
  }
}

// Define Resource Asset Package Name here
enum GtdPackageResoure {
  beme('gotadi_resource');

  final String resource;
  const GtdPackageResoure(this.resource);
}
