import 'package:flutter/material.dart';
import 'package:gtd_utils/base/view/base_view.dart';
import 'package:gtd_utils/base/view_model/base_view_model.dart';
import 'package:gtd_utils/data/configuration/color_config/color_status.dart';

extension GtdBuildContext on BuildContext {
  T? viewModelOf<T extends BaseViewModel>() {
    return dependOnInheritedWidgetOfExactType<InjectorWidget>()?.viewModel as T?;
  }

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  DefaultTextStyle get defaultTextStyle => DefaultTextStyle.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);

  NavigatorState get navigator => Navigator.of(this);

  ScaffoldState get scaffold => Scaffold.of(this);

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

  FocusScopeNode get focusScope => FocusScope.of(this);

  // AppColors get appColors => AppColors();

  GtdColorStatus get colorStatus => Theme.of(this).extension<GtdColorStatus>()!;

  GtdColorBackgroundStatus get colorBackgroundStatus => Theme.of(this).extension<GtdColorBackgroundStatus>()!;
}
