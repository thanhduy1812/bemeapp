import 'package:flutter/material.dart';

abstract class LocalState {}

class LocalInitState extends LocalState {}

class LocalLanguageState extends LocalState {
  final Locale locale;
  LocalLanguageState({required this.locale});
}

class LocalThemeState extends LocalState {
  final ThemeData themeData;
  LocalThemeState({required this.themeData});
}

class LocalSettingState extends LocalState {
  Locale locale;
  String packageResource;
  //MARK: Add setting for AppTheme [B2C/B2B/VIB] - [LIGHT/DARK] - [Transparent/Translucent/Visible App Bar]
  // ThemeData themeData;

  LocalSettingState({
    required this.locale,
    required this.packageResource,
  });
}
