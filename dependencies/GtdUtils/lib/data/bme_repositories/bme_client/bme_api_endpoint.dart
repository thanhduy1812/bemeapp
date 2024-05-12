import 'package:gtd_utils/data/network/network_service/gtd_end_points.dart';
import 'package:gtd_utils/data/network/network_service/gtd_environment.dart';

class BmeApiEndpoint extends GtdEndpoint {
  BmeApiEndpoint({required super.env, required super.path});
  static const String kUsers = "v1/users";
  static const String kUserCreate = "v1/users/create";
  static const String kUserUpdate = "v1/users/update";
  static const String kUserFindByKey = "v1/users/find-by-key";
  static const String kUserSearchByColumn = "v1/users/search-by-column";

  static const String kBmeCourses = "v1/bme/courses";
  static const String kBmeCoursesCreate = "v1/bme/courses/create";
  static const String kBmeCoursesUpdate = "v1/bme/courses/update";
  static const String kBmeCoursesFindByKey = "v1/bme/courses/find-by-key";
  static const String kBmeCoursesSearchByColumn = "v1/bme/Courses/search-by-column";

  static const String kBmeCoursesHocBu = "v1/bme/courses-other";
  static const String kBmeCoursesHocBuFindByKey = "v1/bme/courses-other/find-by-key";

  //Lesson
  static const String kBmeLessonRoadmapCreate = "v1/lesson-roadmap/create";
  static const String kLessonRoadmapFindByKey = "v1/lesson-roadmap/find-by-key";

  //Feedback
  static const String kFeedbackList = "v1/feedbacks";
  //UserFeedback
  static const String kUserFeedbackCreate = "v1/user-feedback/create";
  static const String kUserFeedbacks = "v1/user-feedback";
  static const String kUserFeedbackFindByKey = "v1/user-feedback/find-by-key";
  static const String kUserFeedbackFindByLessonRoadmapIds = "v1/user-feedback/find-by-lessons";
  static const String kUserFeedbackSearchByColumn = "v1/user-feedback/search-by-column";

//User
  static GtdEndpoint getListBmeUser(GTDEnvType envType) {
    const path = kUsers;
    return GtdEndpoint(env: GtdEnvironment(env: envType), path: path);
  }

  static GtdEndpoint createBmeUser(GTDEnvType envType) {
    const path = kUserCreate;
    return GtdEndpoint(env: GtdEnvironment(env: envType), path: path);
  }

  static GtdEndpoint updateBmeUser(GTDEnvType envType, int id) {
    const path = kUserUpdate;
    return GtdEndpoint(env: GtdEnvironment(env: envType), path: "$path/$id");
  }

  static GtdEndpoint findBmeUserByKey(GTDEnvType envType) {
    const path = kUserFindByKey;
    return GtdEndpoint(env: GtdEnvironment(env: envType), path: path);
  }

//BME
  static GtdEndpoint getListBmeOriginCourse(GTDEnvType envType) {
    const path = kBmeCourses;
    return GtdEndpoint(env: GtdEnvironment(env: envType), path: path);
  }

  static GtdEndpoint createBmeCourse(GTDEnvType envType) {
    const path = kBmeCoursesCreate;
    return GtdEndpoint(env: GtdEnvironment(env: envType), path: path);
  }

  static GtdEndpoint updateBmeCourse(GTDEnvType envType, int id) {
    const path = kBmeCoursesUpdate;
    return GtdEndpoint(env: GtdEnvironment(env: envType), path: "$path/$id");
  }

  static GtdEndpoint deleteBmeCourse(GTDEnvType envType, int id) {
    const path = kBmeCourses;
    return GtdEndpoint(env: GtdEnvironment(env: envType), path: "$path/$id");
  }

  static GtdEndpoint findBmeCoursesByKey(GTDEnvType envType) {
    const path = kBmeCoursesFindByKey;
    return GtdEndpoint(env: GtdEnvironment(env: envType), path: path);
  }

  static GtdEndpoint getListBmeCourseHocBu(GTDEnvType envType) {
    const path = kBmeCoursesHocBu;
    return GtdEndpoint(env: GtdEnvironment(env: envType), path: path);
  }

  static GtdEndpoint findBmeCoursesHocBuByKey(GTDEnvType envType) {
    const path = kBmeCoursesHocBuFindByKey;
    return GtdEndpoint(env: GtdEnvironment(env: envType), path: path);
  }

  //Lesson
  static GtdEndpoint createRoadmapLesson(GTDEnvType envType) {
    const path = kBmeLessonRoadmapCreate;
    return GtdEndpoint(env: GtdEnvironment(env: envType), path: path, hasScheme: false);
  }

  static GtdEndpoint findLessonByKey(GTDEnvType envType) {
    const path = kLessonRoadmapFindByKey;
    return GtdEndpoint(env: GtdEnvironment(env: envType), path: path);
  }

  //Feedback
  static GtdEndpoint getListFeedbackQuestion(GTDEnvType envType) {
    const path = kFeedbackList;
    return GtdEndpoint(env: GtdEnvironment(env: envType), path: path);
  }

  static GtdEndpoint createUserFeedback(GTDEnvType envType) {
    const path = kUserFeedbackCreate;
    return GtdEndpoint(env: GtdEnvironment(env: envType), path: path);
  }

  static GtdEndpoint getListUserFeedbacks(GTDEnvType envType) {
    const path = kUserFeedbacks;
    return GtdEndpoint(env: GtdEnvironment(env: envType), path: path);
  }

  static GtdEndpoint getListUserFeedbackByKey(GTDEnvType envType) {
    const path = kUserFeedbackFindByKey;
    return GtdEndpoint(env: GtdEnvironment(env: envType), path: path);
  }

  static GtdEndpoint getListUserFeedbackByLessonids(GTDEnvType envType) {
    const path = kUserFeedbackFindByLessonRoadmapIds;
    return GtdEndpoint(env: GtdEnvironment(env: envType), path: path);
  }

  static GtdEndpoint searchUserFeedbackByColumn(GTDEnvType envType) {
    const path = kUserFeedbackSearchByColumn;
    return GtdEndpoint(env: GtdEnvironment(env: envType), path: path);
  }
}
