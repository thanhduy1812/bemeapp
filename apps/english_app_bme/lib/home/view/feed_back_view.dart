import 'package:beme_english/home/app_bottom_bar.dart';
import 'package:beme_english/home/cubit/user_feedback_cubit.dart';
import 'package:beme_english/lesson/view_controller/lesson_page.dart';
import 'package:beme_english/lesson/view_model/lesson_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtd_utils/base/view/base_view.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_button.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_call_back.dart';
import 'package:gtd_utils/utils/popup/gtd_popup_message.dart';

import '../view_model/feed_back_viewmodel.dart';

class FeedbackView extends BaseView<FeedbackViewModel> {
  final GtdCallback<LessonRating>? onChanged;
  final GtdVoidCallback? onConfirm;
  const FeedbackView({super.key, required super.viewModel, this.onChanged, this.onConfirm});

  @override
  Widget buildWidget(BuildContext context) {
    return BlocProvider(
      create: (context) {
        if (viewModel.neeReloadUserFeedbacks) {
          return UserFeedbackCubit()..loadUserFeedbackByKey(lessonRoadmapId: viewModel.lessonRoadmapId);
        }
        return UserFeedbackCubit();
      },
      child: BlocListener<UserFeedbackCubit, UserFeedbackState>(
        listener: (context, state) {
          if (state is UserFeedbackInitial) {
            viewModel.updateDataFromUserFeedbacks(state.userFeedbacks);
          }
        },
        child: BlocBuilder<UserFeedbackCubit, UserFeedbackState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: 1,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var focusNode = FocusNode();
                  return Material(
                    child: Ink(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: appBlueDeepColor),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white),
                      child: StatefulBuilder(builder: (context, setState) {
                        return SizedBox(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                            child: IgnorePointer(
                              ignoring: viewModel.userFeedbacks.isNotEmpty,
                              child: Column(
                                children: [
                                  ListView.separated(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        var feedBackModel = viewModel.feedbackModels[index];
                                        return Column(
                                          children: [
                                            SizedBox(
                                                width: double.infinity,
                                                child: Text(
                                                  feedBackModel.question,
                                                  style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                                                )),
                                            const SizedBox(height: 16),
                                            LessonPage.rowIconRating(
                                              context,
                                              spacing: 16,
                                              groupRating: feedBackModel.rating,
                                              onChanged: (value) {
                                                setState(
                                                  () {
                                                    feedBackModel.rating = value;
                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                                      itemCount: viewModel.feedbackModels.length),
                                  const SizedBox(height: 16),
                                  TextField(
                                    controller: TextEditingController.fromValue(
                                        TextEditingValue(text: viewModel.feedbackComment)),
                                    focusNode: focusNode,
                                    onTapOutside: (event) {
                                      focusNode.unfocus();
                                    },
                                    maxLines: 20,
                                    minLines: 1,
                                    keyboardType: TextInputType.multiline,
                                    maxLength: 1000,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade500, width: 1.0, style: BorderStyle.solid)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade500, width: 1.0, style: BorderStyle.solid)),
                                      hintText: 'Hôm nay tâm trạng bạn thế nào, chia sẻ với bé me nhé!',
                                      hintStyle: TextStyle(
                                          fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey.shade300),
                                      filled: false,
                                      fillColor: Colors.white,
                                      focusColor: appBlueDeepColor,
                                      hoverColor: appBlueDeepColor,
                                    ),
                                    onChanged: (value) {
                                      viewModel.feedbackComment = value;
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: double.infinity,
                                    child: viewModel.userFeedbacks.isNotEmpty || !viewModel.isEnableFeedbackSubmit
                                        ? const SizedBox()
                                        : GtdButton(
                                            text: "Submit",
                                            height: 60,
                                            isEnable: viewModel.isEnableFeedbackSubmit,
                                            color: appOrangeDarkColor,
                                            colorText: Colors.white,
                                            fontSize: 17,
                                            onPressed: (value) async {
                                              // await GtdLoading.showSuccess();
                                              GtdPopupMessage(context).showError(
                                                error: "Do you want to confirm?",
                                                onConfirm: (value) async {
                                                  await viewModel.createUserFeedback().then(
                                                    (value) {
                                                      viewModel.isEnableFeedbackSubmit = false;
                                                    },
                                                  ).whenComplete(() {
                                                    BlocProvider.of<UserFeedbackCubit>(context).loadUserFeedbackByKey(
                                                        lessonRoadmapId: viewModel.lessonRoadmapId);
                                                    onConfirm?.call();
                                                  });
                                                },
                                              );
                                            },
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
