import 'package:flutter/material.dart';
import 'package:gtd_utils/base/view_model/base_view_model.dart';

class BasePageViewModel extends BaseViewModel {
  late String? title;
  late String? subTitle;
  Color? backgroundColor;
  bool extendBodyBehindAppBar = false;
  final ValueNotifier<String> subTitleNotifer = ValueNotifier("");

  BasePageViewModel({this.title, this.subTitle, this.backgroundColor}) {
    subTitleNotifer.value = subTitle ?? "";
  }
}
