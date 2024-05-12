import 'package:flutter/material.dart';
import 'package:gtd_utils/data/configuration/gtd_app_config.dart';

/// App name and info constants.
class AppConst {
  // This class is not meant to be instantiated or extended; this constructor
  // prevents instantiation and extension.
  AppConst._();

  static final shared = AppConst._();

  /// AppScheme
  late final GtdAppScheme appScheme;

  /// AppThemeMode
  ThemeMode? themeMode;

  ThemeData get currentThemeData => (themeMode == ThemeMode.dark)
      ? appScheme.appSupplier.appTheme.darkTheme
      : appScheme.appSupplier.appTheme.lightTheme;

  /// Link to the FlexColorScheme package.
  static final Uri packageUri = Uri(
    scheme: 'https',
    host: 'pub.dev',
    path: 'packages/flex_color_scheme',
  );

  /// AppAssetPackage
  String get supplierResource {
    return appScheme.packageResoure.resource;
  }
}
