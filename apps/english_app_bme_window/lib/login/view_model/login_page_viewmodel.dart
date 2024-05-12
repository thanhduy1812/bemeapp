import 'package:gtd_utils/base/view_model/base_page_view_model.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/bme_client.dart';
import 'package:gtd_utils/data/bme_repositories/bme_repositories/bme_repository.dart';
import 'package:gtd_utils/data/cache_helper/cache_helper.dart';
import 'package:gtd_utils/data/network/models/wrapped_result/result.dart';
import 'package:gtd_utils/data/repositories/gtd_repository_error/gtd_api_error.dart';

class LoginPageViewModel extends BasePageViewModel {
  String username = "";
  String password = "";
  bool isShowPassword = false;
  bool rememberPassword = false;
  BmeUser? cachedUser;

  LoginPageViewModel() {
    cachedUser = CacheHelper.shared.loadSavedObject(BmeUser.fromJson, key: CacheStorageType.accountBox.name);
  }

  Future<Result<List<BmeUser>, GtdApiError>> login() async {
    if (cachedUser?.isRemember == true) {
      return BmeRepository.shared.login(
          username: cachedUser!.username!,
          password: cachedUser!.password!,
          rememberPassword: cachedUser!.isRemember ?? false);
    }
    return BmeRepository.shared.login(username: username, password: password, rememberPassword: rememberPassword);
  }
}
