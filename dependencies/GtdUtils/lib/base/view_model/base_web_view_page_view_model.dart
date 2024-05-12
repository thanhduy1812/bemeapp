// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:gtd_utils/base/view_model/base_page_view_model.dart';

class BaseWebViewPageViewModel extends BasePageViewModel {
  String url;
  bool isLoading = true;
  bool isFirstLoad = false;
  StreamController<bool> loadingController = StreamController();
  BaseWebViewPageViewModel({
    super.title,
    super.subTitle,
    required this.url,
  });
}
