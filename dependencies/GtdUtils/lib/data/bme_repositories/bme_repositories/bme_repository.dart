import 'package:gtd_utils/data/bme_repositories/bme_client/api/bme_client_resource_api.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/add_lesson_rq.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/bme_course_hocbu.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/bme_origin_course_rs.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/bme_user_rs.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/feedback_rs.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/lesson_roadmap_rs.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/user_feedback_rs.dart';
import 'package:gtd_utils/data/cache_helper/cache_helper.dart';

import '../../network/network.dart';
import '../../repositories/gtd_repository_error/gtd_api_error.dart';

class BmeRepository {
  final BmeClientResourceApi bmeClientResourceApi = BmeClientResourceApi.shared;

  BmeRepository._();
  static final shared = BmeRepository._();

//User
  Future<Result<List<BmeUser>, GtdApiError>> getListUser() async {
    try {
      final response = await bmeClientResourceApi.getListUser();
      return Success(response);
    } on GtdApiError catch (e) {
      Logger.e("getListUser: $e");
      return Error(e);
    }
  }

  Future<Result<List<BmeUser>, GtdApiError>> searchUserByKeyword(String keyword) async {
    try {
      final response = await bmeClientResourceApi.searchBmeUserByKey("phone_number", keyword);
      return Success(response);
    } on GtdApiError catch (e) {
      Logger.e("searchUserByKeyword: $e");
      return Error(e);
    }
  }

  Future<Result<List<BmeUser>, GtdApiError>> findUserByKey(String phoneNumber) async {
    try {
      final response = await bmeClientResourceApi.findBmeUserByKey({"username": phoneNumber});
      return Success(response);
    } on GtdApiError catch (e) {
      Logger.e("findUserByKey: $e");
      return Error(e);
    }
  }

  Future<Result<List<BmeUser>, GtdApiError>> findUserByRole(String role) async {
    try {
      final response = await bmeClientResourceApi.findBmeUserByKey({"role": role});
      return Success(response);
    } on GtdApiError catch (e) {
      Logger.e("findUserByRole: $e");
      return Error(e);
    }
  }

  Future<Result<List<BmeUser>, GtdApiError>> findUserByClassCode(String classCode) async {
    try {
      final response = await bmeClientResourceApi.findBmeUserByKey({"tag": classCode});
      return Success(response);
    } on GtdApiError catch (e) {
      Logger.e("findUserByClassCode: $e");
      return Error(e);
    }
  }

  Future<Result<BmeUser, GtdApiError>> createBmeUser({required BmeUser bmeUser}) async {
    try {
      final response = await bmeClientResourceApi.createBmeUser(bmeUser: bmeUser);
      return Success(response);
    } on GtdApiError catch (e) {
      Logger.e("createBmeUser: $e");
      return Error(e);
    }
  }

  Future<Result<BmeUser, GtdApiError>> updateBmeUser(BmeUser bmeUser) async {
    try {
      final response = await bmeClientResourceApi.updateBmeUser(bmeUser, bmeUser.id!);
      return Success(response);
    } on GtdApiError catch (e) {
      Logger.e("updateBmeUser: $e");
      return Error(e);
    }
  }

  Future<Result<List<BmeUser>, GtdApiError>> login(
      {required String username, required String password, bool rememberPassword = false}) async {
    try {
      var request = {"username": username, "password": password};
      final response = await bmeClientResourceApi.findBmeUserByKey(request);
      if (response.isNotEmpty) {
        var bmeUser = response.first;
        bmeUser.isRemember = rememberPassword;
        await CacheHelper.shared.saveSharedObject(bmeUser.toJson(), key: CacheStorageType.accountBox.name);
        return Success(response);
      }
      return Error(GtdApiError(code: "404", message: "User not found"));
    } on GtdApiError catch (e) {
      Logger.e("login: $e");
      return Error(e);
    }
  }

  //Course
  Future<Result<List<BmeOriginCourse>, GtdApiError>> getListBmeCourse() async {
    try {
      final response = await bmeClientResourceApi.getListCourse();
      return Success(response);
    } on GtdApiError catch (e) {
      Logger.e("getListBmeCourse: $e");
      return Error(e);
    }
  }

  Future<Result<List<BmeOriginCourse>, GtdApiError>> searchBmeCourseByKey(String keyword) async {
    try {
      final response = await bmeClientResourceApi.searchBmeCourseByKey("ma_lop", keyword);
      return Success(response);
    } on GtdApiError catch (e) {
      Logger.e("searchUserByKeyword: $e");
      return Error(e);
    }
  }

  Future<Result<List<BmeOriginCourse>, GtdApiError>> findBmeCourseByKey(String courseCode) async {
    try {
      final response = await bmeClientResourceApi.findBmeCourseByKey({"ma_lop": courseCode});
      return Success(response);
    } on GtdApiError catch (e) {
      Logger.e("findBmeCourseByKey: $e");
      return Error(e);
    }
  }

  Future<Result<BmeOriginCourse, GtdApiError>> createBmeCourse(BmeOriginCourse course) async {
    try {
      final response = await bmeClientResourceApi.createCourse(course);
      return Success(response);
    } on GtdApiError catch (e) {
      Logger.e("createBmeCourse: $e");
      return Error(e);
    }
  }

  Future<Result<BmeOriginCourse, GtdApiError>> updateBmeCourse(BmeOriginCourse course) async {
    try {
      final response = await bmeClientResourceApi.updateCourse(course, course.id!);
      return Success(response);
    } on GtdApiError catch (e) {
      Logger.e("updateBmeCourse: $e");
      return Error(e);
    }
  }

  Future<Result<bool, GtdApiError>> deleteBmeCourse(int id) async {
    try {
      final response = await bmeClientResourceApi.deleteCourse(id);
      return Success(response);
    } on GtdApiError catch (e) {
      Logger.e("deleteBmeCourse: $e");
      return Error(e);
    }
  }

  Future<List<BmeCourseHocBu>> findBmeCoursesHocBuByKey(String phoneNumber) async {
    try {
      final response = await bmeClientResourceApi.findBmeCoursesHocBuByKey({"so_dien_thoai": phoneNumber});
      return response;
    } on GtdApiError catch (e) {
      Logger.e("findBmeCoursesHocBuByKey: $e");
      return [];
    }
  }

  Future<Result<AddLessonRq, GtdApiError>> createLessonRoadmap({required AddLessonRq addLessonRq}) async {
    try {
      final response = await bmeClientResourceApi.createLessonRoadmap(addLessonRq: addLessonRq);
      return Success(response);
    } on GtdApiError catch (e) {
      Logger.e("createLessonRoadmap: $e");
      return Error(e);
    }
  }

  Future<Result<List<LessonRoadmapRs>, GtdApiError>> findLessonRoadmapByKey(String courseCode) async {
    try {
      final response = await bmeClientResourceApi.findLessonRoadmapByKey({"class_code": courseCode});
      return Success(response);
    } on GtdApiError catch (e) {
      Logger.e("findLessonRoadmapByKey: $e");
      return Error(e);
    }
  }

  Future<LessonRoadmapRs?> findLessonRoadmapById(int lessonRoadmapId) async {
    try {
      final response = await bmeClientResourceApi.findLessonRoadmapByKey({"id": lessonRoadmapId});
      return response.firstOrNull;
    } on GtdApiError catch (e) {
      Logger.e("findLessonRoadmapByKey: $e");
      return null;
    }
  }

  Future<Result<List<FeedbackAsk>, GtdApiError>> getFeedbackList() async {
    try {
      final response = await bmeClientResourceApi.getFeedbackList();
      return Success(response);
    } on GtdApiError catch (e) {
      Logger.e("getFeedbackList: $e");
      return Error(e);
    }
  }

  Future<Result<List<UserFeedback>, GtdApiError>> getUserFeedbackList() async {
    try {
      final response = await bmeClientResourceApi.getUserFeedbackList();
      return Success(response);
    } on GtdApiError catch (e) {
      Logger.e("getUserFeedbackList: $e");
      return Error(e);
    }
  }

  Future<Result<UserFeedback, GtdApiError>> createUserFeedback(UserFeedback userFeedback) async {
    try {
      final response = await bmeClientResourceApi.createUserFeedback(userFeedback: userFeedback);
      return Success(response);
    } on GtdApiError catch (e) {
      Logger.e("createUserFeedback: $e");
      return Error(e);
    }
  }

  Future<Result<List<UserFeedback>, GtdApiError>> getUserFeedbackListByKey(Map<String, dynamic> queryParams) async {
    try {
      final response = await bmeClientResourceApi.getUserFeedbacksByKey(queryParams);
      return Success(response);
    } on GtdApiError catch (e) {
      Logger.e("getUserFeedbackListByKey: $e");
      return Error(e);
    }
  }

  Future<Result<List<UserFeedback>, GtdApiError>> getUserFeedbackListByLessonIds(List<int> lessonIds) async {
    try {
      final response = await bmeClientResourceApi.getUserFeedbacksByLessonIds(lessonIds);
      return Success(response);
    } on GtdApiError catch (e) {
      Logger.e("getUserFeedbackListByLessonIds: $e");
      return Error(e);
    }
  }

  Future<Result<List<UserFeedback>, GtdApiError>> searchUserFeedbacksByDate(String feedbackDate) async {
    try {
      final response = await bmeClientResourceApi.searchUserFeedbacksByKey("feedback_date", feedbackDate);
      return Success(response);
    } on GtdApiError catch (e) {
      Logger.e("searchUserFeedbacksByDate: $e");
      return Error(e);
    }
  }
}
