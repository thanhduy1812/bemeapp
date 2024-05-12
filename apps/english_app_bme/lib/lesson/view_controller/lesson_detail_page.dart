import 'package:beme_english/home/app_bottom_bar.dart';
import 'package:beme_english/home/cubit/bme_user_cubit.dart';
import 'package:beme_english/home/view/feed_back_view.dart';
import 'package:beme_english/home/view/user_list_view.dart';
import 'package:beme_english/home/view_model/feed_back_viewmodel.dart';
import 'package:beme_english/home/view_model/user_list_viewmodel.dart';
import 'package:beme_english/lesson/view_controller/lesson_page.dart';
import 'package:beme_english/lesson/view_model/lesson_detail_page_viewmodel.dart';
import 'package:beme_english/lesson/view_model/lesson_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gtd_utils/base/page/base_stateless_page.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/bme_client.dart';
import 'package:gtd_utils/utils/popup/gtd_present_view_helper.dart';

class LessonDetailPage extends BaseStatelessPage<LessonDetailPageViewModel> {
  static const String route = '/lessonDetail';
  const LessonDetailPage({super.key, required super.viewModel});

  @override
  Widget buildBody(BuildContext pageContext) {
    return BlocProvider(
      create: (context) => BmeUserCubit()..loadBmeUsersByClassCode(viewModel.course.maLop ?? ""),
      child: BlocBuilder<BmeUserCubit, BmeUserState>(
        builder: (context, state) {
          if (state is BmeUserLoading) {
            return const CircularProgressIndicator();
          }
          if (state is BmeUserInitial) {
            viewModel.bmeUsers = state.bmeUsers;
          }
          return ListenableBuilder(
              listenable: viewModel,
              builder: (context, child) {
                return ColoredBox(
                  color: Colors.white,
                  child: DefaultTabController(
                      length: _tabViews().length,
                      child: Column(
                        children: [
                          _tabViews().length == 1
                              ? const SizedBox()
                              : ColoredBox(
                                  color: appBlueDeepColor,
                                  child: TabBar(
                                    labelStyle: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                                    tabs: _tabViews(),
                                    unselectedLabelColor: Colors.orangeAccent,
                                    labelColor: Colors.orangeAccent,
                                    indicatorColor: Colors.orangeAccent,
                                    // dividerColor: appBlueDeepColor,
                                  ),
                                ),
                          Expanded(
                            child: TabBarView(children: _generateTabarView(pageContext)),
                          )
                        ],
                      )),
                );
              });
        },
      ),
    );
  }

  List<Widget> _tabViews() {
    if (viewModel.role.toUpperCase() == BmeUserRole.admin.roleValue) {
      return [
        const Tab(text: "Students"),
        const Tab(text: "Teachers"),
      ];
    } else if (viewModel.role.toUpperCase() == BmeUserRole.mentor.roleValue) {
      return [
        const Tab(text: "Students"),
        // const Tab(text: "Rating"),
      ];
    } else {
      return [const Tab(text: "Rating")];
    }
  }

  List<Widget> _generateTabarView(BuildContext context) {
    if (viewModel.role.toUpperCase() == BmeUserRole.admin.roleValue) {
      return [
        UserListView(
            viewModel: UserListViewModel(
                bmeUsers: viewModel.bmeUsers
                    .where((element) => element.role?.toUpperCase() == BmeUserRole.user.roleValue)
                    .toList(),
                userFeedbacks: viewModel.studentFeedbacks,
                rating: viewModel.filterRating),
            onSelected: (value) {
              var userFeedbacks = viewModel.userFeedbacksByUserName(value.username!);
              if (userFeedbacks.isEmpty) {
                return;
              }
              GtdPresentViewHelper.presentView(
                title: "${value.fullName} feedback!",
                context: context,
                builder: Builder(
                  builder: (feedbackContext) {
                    return FeedbackView(
                      viewModel: FeedbackViewModel.loadExistFeedback(viewModel.lessonRoadmapRs.id ?? 0, userFeedbacks),
                      onConfirm: () {
                        feedbackContext.pop();
                        Future.delayed(const Duration(seconds: 1)).then((value) {
                          viewModel.reloadDataDetailPage(() {
                            viewModel.reloadDetailPage();
                          });
                        });
                      },
                    );
                  },
                ),
              );
            },
            isShowRating: true),
        Column(
          children: [
            Builder(builder: (context) {
              return SizedBox(
                  // height: 48,
                  child: Card(
                color: appBlueLightColor,
                child: ListTile(
                  title: Text("Teacher Name: ${viewModel.mentorUser?.fullName ?? "---"}",
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: appBlueDeepColor)),
                  subtitle: Text("Teacher ID: ${viewModel.mentorUser?.username ?? "---"}",
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17, color: appBlueDeepColor)),
                ),
              ));
            }),
            Expanded(
              child: UserListView(
                  viewModel: UserListViewModel(
                      bmeUsers: viewModel.bmeUsers
                          .where((element) => element.role?.toUpperCase() == BmeUserRole.user.roleValue)
                          .toList(),
                      userFeedbacks: viewModel.mentorFeedbacks,
                      viewMode: UserListViewMode.mentor,
                      rating: viewModel.filterRating),
                  onSelected: (value) {
                    var userFeedbacks = viewModel.userFeedbacksByFeedbackTo(value.username!);
                    if (userFeedbacks.isEmpty) {
                      return;
                    }
                    GtdPresentViewHelper.presentView(
                      title: "${value.fullName} feedback!",
                      context: context,
                      builder: Builder(
                        builder: (feedbackContext) {
                          return FeedbackView(
                            viewModel:
                                FeedbackViewModel.loadExistFeedback(viewModel.lessonRoadmapRs.id ?? 0, userFeedbacks),
                            onConfirm: () {
                              feedbackContext.pop();
                              Future.delayed(const Duration(seconds: 1)).then((value) {
                                viewModel.reloadDataDetailPage(() {
                                  viewModel.reloadDetailPage();
                                });
                              });
                            },
                          );
                        },
                      ),
                    );
                  },
                  isShowRating: true),
            ),
          ],
        ),
      ];
    } else if (viewModel.role.toUpperCase() == BmeUserRole.mentor.roleValue) {
      return [
        UserListView(
            viewModel: UserListViewModel(
                bmeUsers: viewModel.bmeUsers
                    .where((element) => element.role?.toUpperCase() == BmeUserRole.user.roleValue)
                    .toList(),
                viewMode: UserListViewMode.mentor,
                userFeedbacks: viewModel.mentorFeedbacks),
            onSelected: (value) {
              var userFeedbacks = viewModel.userFeedbacksByFeedbackTo(value.username!);
              // if (userFeedbacks.isEmpty) {
              //   return;
              // }
              GtdPresentViewHelper.presentView(
                title: "${value.fullName} feedback!",
                context: context,
                builder: Builder(
                  builder: (feedbackContext) {
                    return FeedbackView(
                      viewModel: FeedbackViewModel.loadExistFeedback(viewModel.lessonRoadmapRs.id ?? 0, userFeedbacks,
                          feedbackTo: value.username),
                      onConfirm: () {
                        feedbackContext.pop();
                        Future.delayed(const Duration(seconds: 1)).then((value) {
                          viewModel.reloadDataDetailPage(() {
                            viewModel.reloadDetailPage();
                          });
                        });
                      },
                    );
                  },
                ),
              );
            },
            isShowRating: true),
        // FeedbackView(viewModel: FeedbackViewModel(viewModel.lessonRoadmapRs.id ?? 0))
      ];
    } else {
      return [FeedbackView(viewModel: FeedbackViewModel(viewModel.lessonRoadmapRs.id ?? 0))];
    }
  }

  @override
  List<Widget> buildTrailingActions(BuildContext pageContext) {
    if (viewModel.role.toUpperCase() != BmeUserRole.admin.roleValue) {
      return super.buildTrailingActions(pageContext);
    }
    return [
      StatefulBuilder(builder: (context, setState) {
        return IconButton(
            onPressed: () {
              showDialog(
                context: context,
                useRootNavigator: false,
                builder: (contextChip) {
                  return Center(
                    child: SizedBox(
                      // width: 200,
                      // height: 200,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ChoiceChip(
                                label: const Text('7-10', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500)),
                                avatar: LessonPage.iconRating(LessonRating.happy),
                                backgroundColor: Colors.white,
                                selectedColor: appOrangeLightColor,
                                showCheckmark: false,
                                selected: viewModel.filterRating == LessonRating.happy,
                                onSelected: (bool selected) {
                                  setState(
                                    () {
                                      contextChip.pop();
                                      viewModel.filterRating = selected ? LessonRating.happy : null;
                                      viewModel.reloadDetailPage();
                                    },
                                  );
                                },
                              ),
                              ChoiceChip(
                                label: const Text('4-7', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500)),
                                avatar: LessonPage.iconRating(LessonRating.normal),
                                backgroundColor: Colors.white,
                                selectedColor: appOrangeLightColor,
                                showCheckmark: false,
                                selected: viewModel.filterRating == LessonRating.normal,
                                onSelected: (bool selected) {
                                  setState(
                                    () {
                                      contextChip.pop();
                                      viewModel.filterRating = selected ? LessonRating.normal : null;
                                      viewModel.reloadDetailPage();
                                    },
                                  );
                                },
                              ),
                              ChoiceChip(
                                label: const Text('0-4', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500)),
                                avatar: LessonPage.iconRating(LessonRating.sad),
                                backgroundColor: Colors.white,
                                selectedColor: appOrangeLightColor,
                                showCheckmark: false,
                                selected: viewModel.filterRating == LessonRating.sad,
                                onSelected: (bool selected) {
                                  setState(
                                    () {
                                      contextChip.pop();
                                      viewModel.filterRating = selected ? LessonRating.sad : null;
                                      viewModel.reloadDetailPage();
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            icon: Icon((viewModel.filterRating != null) ? Icons.filter_alt : Icons.filter_alt_outlined,
                size: 36, color: appBlueDeepColor));
      }),
    ];
  }
}
