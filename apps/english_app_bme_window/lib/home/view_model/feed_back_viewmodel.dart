import 'package:beme_english/home/model/feed_back_model.dart';
import 'package:beme_english/lesson/view_model/lesson_page_viewmodel.dart';
import 'package:gtd_utils/base/view_model/base_view_model.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/bme_user_rs.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/user_feedback_rs.dart';
import 'package:gtd_utils/data/bme_repositories/bme_repositories/bme_repository.dart';
import 'package:gtd_utils/data/cache_helper/cache_helper.dart';

class FeedbackViewModel extends BaseViewModel {
  List<FeedbackModel> feedbackModels = [];
  final int lessonRoadmapId;
  String feedbackComment = "";
  bool isEnableFeedbackSubmit = true;
  List<UserFeedback> userFeedbacks = [];
  String? feedbackTo;
  String? role;
  BmeUser? bmeUser;
  bool neeReloadUserFeedbacks = true;
  FeedbackViewModel(this.lessonRoadmapId, {this.feedbackTo = ""}) {
    feedbackModels = [
      FeedbackModel(id: 1, question: "Bạn đã thật sự hiểu bài chưa?", rating: LessonRating.happy),
      FeedbackModel(id: 2, question: "Bạn có tập trung học bài không đó?", rating: LessonRating.happy),
      FeedbackModel(id: 3, question: "Bạn có hài lòng về buổi học ngày hôm nay không nè?", rating: LessonRating.happy)
    ];
    bmeUser = CacheHelper.shared.loadSavedObject(BmeUser.fromJson, key: CacheStorageType.accountBox.name);
    role = bmeUser?.role;
    isEnableFeedbackSubmit = role?.toUpperCase() != BmeUserRole.admin.roleValue;
  }

  factory FeedbackViewModel.loadExistFeedback(int lessonRoadmapId, List<UserFeedback> userFeedbacks,
      {String? feedbackTo}) {
    FeedbackViewModel viewModel = FeedbackViewModel(lessonRoadmapId);
    viewModel.neeReloadUserFeedbacks = false;
    viewModel.userFeedbacks = userFeedbacks;
    // viewModel.isEnableFeedbackSubmit = userFeedbacks.isEmpty;
    viewModel.feedbackTo = feedbackTo;
    viewModel.updateDataFromUserFeedbacks(userFeedbacks);
    return viewModel;
  }

  void updateDataFromUserFeedbacks(List<UserFeedback> userFeedbacks) {
    if (role?.toUpperCase() == BmeUserRole.mentor.roleValue) {
      userFeedbacks = userFeedbacks.where((element) => element.feedbackTo == feedbackTo).toList();
    }
    if (role?.toUpperCase() == BmeUserRole.user.roleValue) {
      userFeedbacks = userFeedbacks.where((element) => element.userName == bmeUser?.username).toList();
    }
    this.userFeedbacks = userFeedbacks;
    this.userFeedbacks.map((e) {
      if (e.feedbackId == 1) {
        feedbackModels[0].rating = LessonRating.fromValue(int.tryParse(e.feedbackAnswer ?? "10") ?? 10);
      }
      if (e.feedbackId == 2) {
        feedbackModels[1].rating = LessonRating.fromValue(int.tryParse(e.feedbackAnswer ?? "10") ?? 10);
      }
      if (e.feedbackId == 3) {
        feedbackModels[2].rating = LessonRating.fromValue(int.tryParse(e.feedbackAnswer ?? "10") ?? 10);
      }
      if (e.feedbackId == 4) {
        feedbackComment = e.feedbackAnswer ?? "";
      }
    }).toList();
    notifyListeners();
  }

  Future<void> createUserFeedback() async {
    var bmeUser = CacheHelper.shared.loadSavedObject(BmeUser.fromJson, key: CacheStorageType.accountBox.name);
    feedbackModels.map((e) {
      var userFeedback = UserFeedback(
        userName: bmeUser?.username ?? "",
        lessonRoadmapId: lessonRoadmapId,
        feedbackId: e.id,
        feedbackAnswer: "${e.rating.score}",
        feedbackTo: feedbackTo,
        feedbackDate: DateTime.now().toUtc(),
      );
      BmeRepository.shared.createUserFeedback(userFeedback);
    }).toList();

    var userFeedback = UserFeedback(
      userName: bmeUser?.username ?? "",
      lessonRoadmapId: lessonRoadmapId,
      feedbackId: 4,
      feedbackAnswer: feedbackComment,
      feedbackTo: feedbackTo,
      feedbackDate: DateTime.now().toUtc(),
    );
    BmeRepository.shared.createUserFeedback(userFeedback);
  }
}
