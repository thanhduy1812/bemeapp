import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtd_utils/constants/app_const.dart';
import 'package:gtd_utils/data/configuration/gtd_app_config.dart';

class SettingCubit extends Cubit<ThemeData> {
  SettingCubit() : super(AppConst.shared.appScheme.appSupplier.appTheme.lightTheme);

  void toggleTheme() {
    if (state == AppConst.shared.appScheme.appSupplier.appTheme.lightTheme) {
      AppConst.shared.themeMode = ThemeMode.light;
      emit(AppConst.shared.appScheme.appSupplier.appTheme.darkTheme);
    } else {
      AppConst.shared.themeMode = ThemeMode.dark;
      emit(AppConst.shared.appScheme.appSupplier.appTheme.lightTheme);
    }
  }
}
