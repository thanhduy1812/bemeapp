import 'package:beme_english/home/view_model/home_page_viewmodel.dart';
import 'package:gtd_utils/base/view_model/base_page_view_model.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/bme_user_rs.dart';
import 'package:gtd_utils/data/bme_repositories/bme_repositories/bme_repository.dart';
import 'package:gtd_utils/data/network/models/wrapped_result/result.dart';
import 'package:gtd_utils/data/repositories/gtd_repository_error/gtd_api_error.dart';
import 'package:gtd_utils/helpers/extension/date_time_extension.dart';

class AddUserPageViewModel extends BasePageViewModel {
  final HomePageTab homePageTab;
  late final String headerTitle;
  // final List<String> listRole = <String>['USER', 'MENTOR', 'ADMIN'];
  final List<String> listRole = <String>['USER', 'MENTOR'];
  String fullName = "";
  String facebookName = "";
  String phoneNumber = "";
  String role = "";
  DateTime dob = DateTime.now();
  AddUserPageViewModel({this.homePageTab = HomePageTab.mentor}) {
    role = listRole.first;
    switch (homePageTab) {
      case HomePageTab.mentor:
        // title = "Mentor";
        headerTitle = "Add a User";
        break;
      case HomePageTab.student:
        // title = "Student";
        headerTitle = "Add a student";
        break;
      default:
        headerTitle = "";
    }
  }

  void setDobDate(DateTime date) {
    dob = DateTime(date.year, date.month, date.day);
    notifyListeners();
  }

  // void setRole(String role) {
  //   this.role = role;
  //   notifyListeners();
  // }

  bool validateForm() {
    if (fullName.isEmpty || facebookName.isEmpty || phoneNumber.isEmpty) {
      return false;
    }
    return true;
  }

  Future<Result<List<BmeUser>, GtdApiError>> validateExistPhoneNumber() {
    return BmeRepository.shared.findUserByKey(phoneNumber);
  }

  Future<Result<BmeUser, GtdApiError>> createUser() async {
    var bmeUser = BmeUser(
        fullName: fullName,
        socialName: facebookName,
        phoneNumber: phoneNumber,
        dob: dateFormat.format(dob),
        role: role);
    return BmeRepository.shared.createBmeUser(bmeUser: bmeUser);
  }

  void updateRole() {
    notifyListeners();
  }
}
