import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gtd_utils/data/configuration/color_config/app_color.dart';

part 'rebuild_widget_state.dart';

class RebuildWidgetCubit extends Cubit<RebuildWidgetState> {
  RebuildWidgetCubit() : super(RebuildWidgetInitial());
  void rebuildWidget() {
    emit(RebuildWidgetInitial());
  }

  void rebuildAppbar() {
    emit(RebuildWidgetAppBar());
  }

  void rebuildBody() {
    emit(RebuildWidgetBody());
  }

  void rebuildBottom() {
    emit(RebuildWidgetBottom());
  }

  void rebuildWidgetUnique(dynamic data) {
    emit(RebuildWidgetUnique(data));
  }

  void configLoading() {
    EasyLoading.instance
      ..backgroundColor = Colors.transparent
      ..maskColor = Colors.black.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false
      // ..indicatorType = EasyLoadingIndicatorType.circle
      // ..loadingStyle = EasyLoadingStyle.dark
      ..boxShadow = <BoxShadow>[]
      ..maskType = EasyLoadingMaskType.custom
      ..loadingStyle = EasyLoadingStyle.custom
      ..textColor = Colors.white
      ..indicatorColor = Colors.transparent
      ..progressColor = AppColors.mainColor;
  }
}
