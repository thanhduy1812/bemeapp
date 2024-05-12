import 'package:gtd_utils/data/cache_helper/cache_helper.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_call_back.dart';
import 'package:rxdart/rxdart.dart';

class UserManager {
  UserManager._() {
    if (token.isNotEmpty) {
      isLoggedInStream.add(true);
    }
  }

  String get token => CacheHelper.shared.getCachedAppToken();
  static final shared = UserManager._();
  final isLoggedInStream = BehaviorSubject<bool>.seeded(false);
  late GtdCallback<String> bookingResultWebViewCallback;
  late GtdVoidCallback popToHomeCallback;


  setLoggedIn(bool isLoggedIn) {
    isLoggedInStream.add(isLoggedIn);
  }
}
