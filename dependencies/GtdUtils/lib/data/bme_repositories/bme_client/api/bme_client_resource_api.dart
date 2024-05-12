import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/bme_api_endpoint.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/add_lesson_rq.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/bme_course_hocbu.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/bme_origin_course_rs.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/bme_user_rs.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/feedback_rs.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/lesson_roadmap_rs.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/user_feedback_rs.dart';
import 'package:gtd_utils/data/network/gtd_json_parser.dart';
import 'package:gtd_utils/data/repositories/gtd_repository_error/gtd_api_error.dart';

import '../../../network/network.dart';

class BmeClientResourceApi {
  GtdNetworkService networkService = GtdNetworkService.shared;
  GTDEnvType envType = GTDEnvType.BmeEnglish;

  BmeClientResourceApi._();
  static final shared = BmeClientResourceApi._();

  Future<List<BmeUser>> getListUser() async {
    try {
      final networkRequest = GTDNetworkRequest(type: GtdMethod.get, enpoint: BmeApiEndpoint.getListBmeUser(envType));
      networkService.request = networkRequest;
      final Response response = await networkService.execute();
      var result = JsonParser.jsonArrayToModel(BmeUser.fromJson, response.data["data"]);
      return result;
    } on DioException catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}');
      GtdDioException dioException = GtdDioException.fromDioError(e);
      throw GtdApiError(message: dioException.message);
    } catch (e) {
      Logger.e("Error getListUser: $e");
      throw GtdApiError.handleObjectError(e);
    }
  }

  Future<BmeUser> createBmeUser({required BmeUser bmeUser}) async {
    try {
      final networkRequest = GTDNetworkRequest(
          type: GtdMethod.post, enpoint: BmeApiEndpoint.createBmeUser(envType), data: bmeUser.toJson());
      networkService.request = networkRequest;
      final Response response = await networkService.execute();
      var result = JsonParser.jsonToModel(BmeUser.fromJson, response.data);
      return result;
    } on DioException catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}');
      GtdDioException dioException = GtdDioException.fromDioError(e);
      throw GtdApiError(message: dioException.message);
    } catch (e) {
      Logger.e("Error createBmeUser: $e");
      throw GtdApiError.handleObjectError(e);
    }
  }

  Future<BmeUser> updateBmeUser(BmeUser user, int id) async {
    try {
      final networkRequest = GTDNetworkRequest(
          type: GtdMethod.put, enpoint: BmeApiEndpoint.updateBmeUser(envType, id), data: user.toJson());
      networkService.request = networkRequest;
      final Response response = await networkService.execute();
      var result = JsonParser.jsonToModel(BmeUser.fromJson, response.data);
      return result;
    } on DioException catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}');
      GtdDioException dioException = GtdDioException.fromDioError(e);
      throw GtdApiError(message: dioException.message);
    } catch (e) {
      Logger.e("Error updateBmeUser: $e");
      throw GtdApiError.handleObjectError(e);
    }
  }

  Future<List<BmeUser>> findBmeUserByKey(Map<String, dynamic> dict) async {
    try {
      final networkRequest = GTDNetworkRequest(type: GtdMethod.get, enpoint: BmeApiEndpoint.findBmeUserByKey(envType));
      networkRequest.queryParams = dict;
      networkService.request = networkRequest;
      final Response response = await networkService.execute();
      var result = JsonParser.jsonArrayToModel(BmeUser.fromJson, response.data);
      return result;
    } on DioException catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}');
      GtdDioException dioException = GtdDioException.fromDioError(e);
      throw GtdApiError(message: dioException.message);
    } catch (e) {
      Logger.e("Error findBmeUserByKey: $e");
      throw GtdApiError.handleObjectError(e);
    }
  }

  Future<List<BmeUser>> searchBmeUserByKey(String column, String substring) async {
    try {
      final networkRequest = GTDNetworkRequest(type: GtdMethod.get, enpoint: BmeApiEndpoint.findBmeUserByKey(envType));
      networkRequest.queryParams = {"column": column, "substring": substring};
      networkService.request = networkRequest;
      final Response response = await networkService.execute();
      var result = JsonParser.jsonArrayToModel(BmeUser.fromJson, response.data);
      return result;
    } on DioException catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}');
      GtdDioException dioException = GtdDioException.fromDioError(e);
      throw GtdApiError(message: dioException.message);
    } catch (e) {
      Logger.e("Error searchBmeUserByKey: $e");
      throw GtdApiError.handleObjectError(e);
    }
  }

  //Courses
  Future<List<BmeOriginCourse>> getListCourse() async {
    try {
      final networkRequest =
          GTDNetworkRequest(type: GtdMethod.get, enpoint: BmeApiEndpoint.getListBmeOriginCourse(envType));
      networkService.request = networkRequest;
      final Response response = await networkService.execute();
      var result = JsonParser.jsonArrayToModel(BmeOriginCourse.fromJson, response.data);
      return result;
    } on DioException catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}');
      GtdDioException dioException = GtdDioException.fromDioError(e);
      throw GtdApiError(message: dioException.message);
    } catch (e) {
      Logger.e("Error getListCourse: $e");
      throw GtdApiError.handleObjectError(e);
    }
  }

  Future<BmeOriginCourse> createCourse(BmeOriginCourse course) async {
    try {
      final networkRequest = GTDNetworkRequest(
          type: GtdMethod.post, enpoint: BmeApiEndpoint.createBmeCourse(envType), data: course.toRequest());
      networkService.request = networkRequest;
      final Response response = await networkService.execute();
      var result = JsonParser.jsonToModel(BmeOriginCourse.fromJson, response.data);
      return result;
    } on DioException catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}');
      GtdDioException dioException = GtdDioException.fromDioError(e);
      throw GtdApiError(message: dioException.message);
    } catch (e) {
      Logger.e("Error createCourse: $e");
      throw GtdApiError.handleObjectError(e);
    }
  }

  Future<BmeOriginCourse> updateCourse(BmeOriginCourse course, int id) async {
    try {
      final networkRequest = GTDNetworkRequest(
          type: GtdMethod.put, enpoint: BmeApiEndpoint.updateBmeCourse(envType, id), data: course.toRequest());
      networkService.request = networkRequest;
      final Response response = await networkService.execute();
      var result = JsonParser.jsonToModel(BmeOriginCourse.fromJson, response.data);
      return result;
    } on DioException catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}');
      GtdDioException dioException = GtdDioException.fromDioError(e);
      throw GtdApiError(message: dioException.message);
    } catch (e) {
      Logger.e("Error updateCourse: $e");
      throw GtdApiError.handleObjectError(e);
    }
  }

  Future<bool> deleteCourse(int id) async {
    try {
      final networkRequest =
          GTDNetworkRequest(type: GtdMethod.delete, enpoint: BmeApiEndpoint.deleteBmeCourse(envType, id));
      networkService.request = networkRequest;
      final Response response = await networkService.execute();
      Logger.i(response.toString());
      return true;
    } on DioException catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}');
      GtdDioException dioException = GtdDioException.fromDioError(e);
      throw GtdApiError(message: dioException.message);
    } catch (e) {
      Logger.e("Error deleteCourse: $e");
      throw GtdApiError.handleObjectError(e);
    }
  }

  Future<List<BmeOriginCourse>> findBmeCourseByKey(Map<String, dynamic> dict) async {
    try {
      final networkRequest =
          GTDNetworkRequest(type: GtdMethod.get, enpoint: BmeApiEndpoint.findBmeCoursesByKey(envType));
      networkRequest.queryParams = dict;
      networkService.request = networkRequest;
      final Response response = await networkService.execute();
      var result = JsonParser.jsonArrayToModel(BmeOriginCourse.fromJson, response.data);
      return result;
    } on DioException catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}');
      GtdDioException dioException = GtdDioException.fromDioError(e);
      throw GtdApiError(message: dioException.message);
    } catch (e) {
      Logger.e("Error findBmeCourseByKey: $e");
      throw GtdApiError.handleObjectError(e);
    }
  }

  Future<List<BmeOriginCourse>> searchBmeCourseByKey(String column, String substring) async {
    try {
      final networkRequest = GTDNetworkRequest(type: GtdMethod.get, enpoint: BmeApiEndpoint.findBmeUserByKey(envType));
      networkRequest.queryParams = {"column": column, "substring": substring};
      networkService.request = networkRequest;
      final Response response = await networkService.execute();
      var result = JsonParser.jsonArrayToModel(BmeOriginCourse.fromJson, response.data);
      return result;
    } on DioException catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}');
      GtdDioException dioException = GtdDioException.fromDioError(e);
      throw GtdApiError(message: dioException.message);
    } catch (e) {
      Logger.e("Error searchBmeCourseByKey: $e");
      throw GtdApiError.handleObjectError(e);
    }
  }

  Future<List<BmeCourseHocBu>> getListBmeCourseHocBu() async {
    try {
      final networkRequest =
          GTDNetworkRequest(type: GtdMethod.get, enpoint: BmeApiEndpoint.getListBmeCourseHocBu(envType));
      networkService.request = networkRequest;
      final Response response = await networkService.execute();
      var result = JsonParser.jsonArrayToModel(BmeCourseHocBu.fromJson, response.data);
      return result;
    } on DioException catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}');
      GtdDioException dioException = GtdDioException.fromDioError(e);
      throw GtdApiError(message: dioException.message);
    } catch (e) {
      Logger.e("Error getListBmeCourseHocBu: $e");
      throw GtdApiError.handleObjectError(e);
    }
  }

  Future<List<BmeCourseHocBu>> findBmeCoursesHocBuByKey(Map<String, dynamic> dict) async {
    try {
      final networkRequest =
          GTDNetworkRequest(type: GtdMethod.get, enpoint: BmeApiEndpoint.findBmeCoursesHocBuByKey(envType));
      networkRequest.queryParams = dict;
      networkService.request = networkRequest;
      final Response response = await networkService.execute();
      var result = JsonParser.jsonArrayToModel(BmeCourseHocBu.fromJson, response.data);
      return result;
    } on DioException catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}');
      GtdDioException dioException = GtdDioException.fromDioError(e);
      throw GtdApiError(message: dioException.message);
    } catch (e) {
      Logger.e("Error findBmeCoursesHocBuByKey: $e");
      throw GtdApiError.handleObjectError(e);
    }
  }

  //Lesson
  Future<AddLessonRq> createLessonRoadmap({required AddLessonRq addLessonRq}) async {
    try {
      final networkRequest = GTDNetworkRequest(
          type: GtdMethod.post, enpoint: BmeApiEndpoint.createRoadmapLesson(envType), data: addLessonRq.toJson());
      networkService.request = networkRequest;
      final Response response = await networkService.execute();
      var result = JsonParser.jsonToModel(AddLessonRq.fromJson, response.data["data"]);
      return result;
    } on DioException catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}');
      GtdDioException dioException = GtdDioException.fromDioError(e);
      throw GtdApiError(message: dioException.message);
    } catch (e) {
      Logger.e("Error createRoadmapLesson: $e");
      throw GtdApiError.handleObjectError(e);
    }
  }

  Future<List<LessonRoadmapRs>> findLessonRoadmapByKey(Map<String, dynamic> dict) async {
    try {
      final networkRequest = GTDNetworkRequest(type: GtdMethod.get, enpoint: BmeApiEndpoint.findLessonByKey(envType));
      networkRequest.queryParams = dict;
      networkService.request = networkRequest;
      final Response response = await networkService.execute();
      var result = JsonParser.jsonArrayToModel(LessonRoadmapRs.fromJson, response.data);
      return result;
    } on DioException catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}');
      GtdDioException dioException = GtdDioException.fromDioError(e);
      throw GtdApiError(message: dioException.message);
    } catch (e) {
      Logger.e("Error findLessonRoadmapByKey: $e");
      throw GtdApiError.handleObjectError(e);
    }
  }

  //Feedback
  Future<UserFeedback> createUserFeedback({required UserFeedback userFeedback}) async {
    try {
      final networkRequest = GTDNetworkRequest(
          type: GtdMethod.post,
          enpoint: BmeApiEndpoint.createUserFeedback(envType),
          data: userFeedback.toRequestJson());
      networkService.request = networkRequest;
      final Response response = await networkService.execute();
      var result = JsonParser.jsonToModel(UserFeedback.fromJson, response.data["data"]);
      return result;
    } on DioException catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}');
      GtdDioException dioException = GtdDioException.fromDioError(e);
      throw GtdApiError(message: dioException.message);
    } catch (e) {
      Logger.e("Error createUserFeedback: $e");
      throw GtdApiError.handleObjectError(e);
    }
  }

  Future<List<UserFeedback>> getListFeedbackQuestion() async {
    try {
      final networkRequest = GTDNetworkRequest(
        type: GtdMethod.get,
        enpoint: BmeApiEndpoint.getListFeedbackQuestion(envType),
      );
      networkService.request = networkRequest;
      final Response response = await networkService.execute();
      var result = JsonParser.jsonArrayToModel(UserFeedback.fromJson, response.data["data"]);
      return result;
    } on DioException catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}');
      GtdDioException dioException = GtdDioException.fromDioError(e);
      throw GtdApiError(message: dioException.message);
    } catch (e) {
      Logger.e("Error getListFeedbackQuestion: $e");
      throw GtdApiError.handleObjectError(e);
    }
  }

  Future<List<FeedbackAsk>> getFeedbackList() async {
    try {
      final networkRequest = GTDNetworkRequest(
        type: GtdMethod.get,
        enpoint: BmeApiEndpoint.getListFeedbackQuestion(envType),
      );
      networkService.request = networkRequest;
      final Response response = await networkService.execute();
      var result = JsonParser.jsonArrayToModel(FeedbackAsk.fromJson, response.data["data"]);
      return result;
    } on DioException catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}');
      GtdDioException dioException = GtdDioException.fromDioError(e);
      throw GtdApiError(message: dioException.message);
    } catch (e) {
      Logger.e("Error getFeedbackList: $e");
      throw GtdApiError.handleObjectError(e);
    }
  }

  Future<List<UserFeedback>> getUserFeedbackList() async {
    try {
      final networkRequest = GTDNetworkRequest(
        type: GtdMethod.get,
        enpoint: BmeApiEndpoint.getListUserFeedbacks(envType),
      );
      networkService.request = networkRequest;
      final Response response = await networkService.execute();
      var result = JsonParser.jsonArrayToModel(UserFeedback.fromJson, response.data["data"]);
      return result;
    } on DioException catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}');
      GtdDioException dioException = GtdDioException.fromDioError(e);
      throw GtdApiError(message: dioException.message);
    } catch (e) {
      Logger.e("Error getUserFeedbackList: $e");
      throw GtdApiError.handleObjectError(e);
    }
  }

  Future<List<UserFeedback>> getUserFeedbacksByKey(Map<String, dynamic> queryParams) async {
    try {
      final networkRequest = GTDNetworkRequest(
        type: GtdMethod.get,
        enpoint: BmeApiEndpoint.getListUserFeedbackByKey(envType),
      );
      networkRequest.queryParams = queryParams;
      networkService.request = networkRequest;
      final Response response = await networkService.execute();
      var result = JsonParser.jsonArrayToModel(UserFeedback.fromJson, response.data);
      return result;
    } on DioException catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}');
      GtdDioException dioException = GtdDioException.fromDioError(e);
      throw GtdApiError(message: dioException.message);
    } catch (e) {
      Logger.e("Error getUserFeedbackList: $e");
      throw GtdApiError.handleObjectError(e);
    }
  }

  Future<List<UserFeedback>> getUserFeedbacksByLessonIds(List<int> lessonIds) async {
    try {
      var data = json.encode(lessonIds);
      final networkRequest = GTDNetworkRequest(
          type: GtdMethod.post, enpoint: BmeApiEndpoint.getListUserFeedbackByLessonids(envType), data: data);

      networkService.request = networkRequest;
      final Response response = await networkService.execute();
      var result = JsonParser.jsonArrayToModel(UserFeedback.fromJson, response.data);
      return result;
    } on DioException catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}');
      GtdDioException dioException = GtdDioException.fromDioError(e);
      throw GtdApiError(message: dioException.message);
    } catch (e) {
      Logger.e("Error getUserFeedbackList: $e");
      throw GtdApiError.handleObjectError(e);
    }
  }

  Future<List<UserFeedback>> searchUserFeedbacksByKey(String column, String substring) async {
    try {
      final networkRequest =
          GTDNetworkRequest(type: GtdMethod.get, enpoint: BmeApiEndpoint.searchUserFeedbackByColumn(envType));
      networkRequest.queryParams = {"column": column, "substring": substring};
      networkService.request = networkRequest;
      final Response response = await networkService.execute();
      var result = JsonParser.jsonArrayToModel(UserFeedback.fromJson, response.data);
      return result;
    } on DioException catch (e) {
      Logger.e('Trace: ${e.stackTrace} \nErrorMess: ${e.toString()}');
      GtdDioException dioException = GtdDioException.fromDioError(e);
      throw GtdApiError(message: dioException.message);
    } catch (e) {
      Logger.e("Error searchUserFeedbacksByKey: $e");
      throw GtdApiError.handleObjectError(e);
    }
  }
}
