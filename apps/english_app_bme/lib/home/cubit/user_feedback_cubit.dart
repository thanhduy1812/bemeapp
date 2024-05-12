import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/bme_client.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/user_feedback_rs.dart';
import 'package:gtd_utils/data/bme_repositories/bme_repositories/bme_repository.dart';
import 'package:gtd_utils/data/cache_helper/cache_helper.dart';
import 'package:meta/meta.dart';

part 'user_feedback_state.dart';

class UserFeedbackCubit extends Cubit<UserFeedbackState> {
  UserFeedbackCubit() : super(UserFeedbackInitial(userFeedbacks: const []));

  Future<void> loadUserFeedbackByKey({required int lessonRoadmapId}) async {
    var bmeUser = CacheHelper.shared.loadSavedObject(BmeUser.fromJson, key: CacheStorageType.accountBox.name);
    var queryParams = {"user_name": bmeUser?.username, "lesson_roadmap_id": lessonRoadmapId};
    await BmeRepository.shared.getUserFeedbackListByKey(queryParams).then((value) {
      value.when(
        (success) {
          emit(UserFeedbackInitial(userFeedbacks: success));
        },
        (error) => emit(
          UserFeedbackInitial(userFeedbacks: const []),
        ),
      );
    });
  }
}
