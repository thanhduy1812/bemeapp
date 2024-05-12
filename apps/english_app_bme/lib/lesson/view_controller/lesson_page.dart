import 'package:beme_english/home/app_bottom_bar.dart';
import 'package:beme_english/home/view_controller/add_lesson_page.dart';
import 'package:beme_english/lesson/view_controller/lesson_detail_page.dart';
import 'package:beme_english/lesson/view_model/lesson_detail_page_viewmodel.dart';
import 'package:beme_english/lesson/view_model/lesson_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gtd_utils/base/page/base_stateless_page.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/bme_user_rs.dart';
import 'package:gtd_utils/data/configuration/color_config/app_color.dart';
import 'package:gtd_utils/helpers/extension/date_time_extension.dart';
import 'package:gtd_utils/helpers/extension/image_extension.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_call_back.dart';
import 'package:gtd_utils/utils/popup/gtd_present_view_helper.dart';

class LessonPage extends BaseStatelessPage<LessonPageViewModel> {
  static const String route = '/lessons';
  const LessonPage({super.key, required super.viewModel});

  @override
  Widget buildBody(BuildContext pageContext) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          return CustomScrollView(
            slivers: [
              //Image
              SliverToBoxAdapter(
                  child: SizedBox(
                      height: 170,
                      child: Card(
                        elevation: 0,
                        margin: EdgeInsets.zero,
                        color: appBlueDeepColor,
                        child: GtdImage.imgFromAsset(
                            assetPath: "assets/image/course-bg.jpg", fit: BoxFit.fitWidth, width: double.infinity),
                      ))),
              //HeaderTitle
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(viewModel.course.maLop ?? "-----",
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: appBlueDeepColor)),
                    const SizedBox(height: 8),
                    Text(viewModel.course.ngayKhaiGiang ?? "----"),
                    SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: GtdImage.svgFromAsset(
                                  assetPath: "assets/image/ico-contact.svg", color: appBlueDeepColor, width: 32),
                              title: Text(viewModel.course.giaoVienHienTai ?? "---"),
                              subtitle: Text("Teacher", style: TextStyle(color: AppColors.subText)),
                            ),
                          ),
                          // const Spacer(),
                          Expanded(
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: const Icon(
                                Icons.groups_outlined,
                                size: 32,
                                color: appBlueDeepColor,
                              ),
                              titleTextStyle: const TextStyle(fontSize: 14, color: appBlueDeepColor),
                              subtitleTextStyle: const TextStyle(fontSize: 14, color: appBlueDeepColor),
                              title: Text(
                                "Students: ${viewModel.classUsers.where((element) => element.role?.toUpperCase() == BmeUserRole.user.roleValue).length}",
                              ),
                              subtitle: Text("Teacher: ${viewModel.course.giaoVienHienTai != null ? 1 : 0}"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 125,
                          child: Card(
                              margin: EdgeInsets.zero,
                              elevation: 0,
                              color: appOrangeDarkColor,
                              child: Center(
                                child: Text(
                                  "${viewModel.lessonRoadmaps.length} Lessons",
                                  style:
                                      const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
                                ),
                              )),
                        ),
                        const Spacer(),
                        (viewModel.role.toUpperCase() != BmeUserRole.admin.roleValue || viewModel.classUsers.isEmpty)
                            ? const SizedBox()
                            : SizedBox(
                                height: 50,
                                width: 125,
                                child: InkWell(
                                  onTap: () async {
                                    GtdPresentViewHelper.presentSheet(
                                        title: "Add Feedback",
                                        context: pageContext,
                                        builder: Builder(
                                          builder: (feedbackContext) {
                                            return AddLessonPage.addLessonForm(
                                              pageContext,
                                              course: viewModel.course,
                                              onCompleted: (value) {
                                                feedbackContext.pop();
                                                viewModel.loadLessonRoadmaps();
                                              },
                                            );
                                          },
                                        ));
                                  },
                                  child: const Card(
                                      margin: EdgeInsets.zero,
                                      elevation: 0,
                                      color: appBlueDeepColor,
                                      child: Center(
                                        child: Text(
                                          "Feedback",
                                          style:
                                              TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14),
                                        ),
                                      )),
                                ),
                              )
                      ],
                    )
                  ],
                ),
              ),

              //List Lessons
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var lesson = viewModel.lessonRoadmaps[index];
                        var rating = viewModel.arrangeRating(lesson.id ?? 0);
                        return SizedBox(
                            // height: 90,
                            child: Card(
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          child: ListTile(
                            onTap: () {
                              var detailPageViewModel =
                                  LessonDetailPageViewModel(course: viewModel.course, lessonRoadmapRs: lesson);
                              context
                                  .push(LessonDetailPage.route, extra: detailPageViewModel)
                                  .then((value) => viewModel.loadLessonRoadmaps());
                            },
                            leading: const Icon(
                              Icons.menu_book,
                              color: appBlueDeepColor,
                            ),
                            title: Text(
                              dateFormat.format(lesson.startDate ?? DateTime.now()),
                              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                            ),
                            // title: Text(lesson.lessonName ?? "",
                            //     style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17)),
                            // subtitle: Text("Teacher: ${lesson.mentorName ?? "---"}"),
                            subtitle: Text.rich(
                              TextSpan(
                                  children: viewModel.role == BmeUserRole.user.roleValue
                                      ? [
                                          TextSpan(
                                              text: "Teacher: ${lesson.mentorName ?? "---"}",
                                              style: const TextStyle(color: Colors.blueAccent)),
                                        ]
                                      : [
                                          TextSpan(
                                              text: "Teacher: ${lesson.mentorName ?? "---"} \n",
                                              style: const TextStyle(color: Colors.blueAccent)),
                                          viewModel.role == BmeUserRole.user.roleValue
                                              ? const TextSpan()
                                              : TextSpan(
                                                  text:
                                                      "Total Feedback: ${viewModel.countFeedbacksForLesson(lesson.id!)}",
                                                  style: const TextStyle(color: Colors.deepOrange))
                                        ]),
                              textAlign: TextAlign.left,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Text.rich(
                                //   TextSpan(
                                //       text: "Total Feedback: \n",
                                //       children: [TextSpan(text: "${viewModel.countFeedbacks}")]),
                                //   textAlign: TextAlign.center,
                                // ),
                                // const SizedBox(width: 10),
                                rating == null
                                    ? const SizedBox()
                                    : Text(
                                        rating.$2.toStringAsFixed(1),
                                        style: const TextStyle(
                                            fontSize: 18, fontWeight: FontWeight.w500, color: appOrangeDarkColor),
                                      ),
                                const SizedBox(width: 7),
                                rating == null ? const SizedBox() : iconRating(rating.$1),
                              ],
                            ),
                          ),
                        ));
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemCount: viewModel.lessonRoadmaps.length),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  static Widget iconRating(LessonRating groupRating) {
    return GtdImage.svgFromAsset(
        assetPath: switch (groupRating) {
          LessonRating.happy => "assets/image/ico-happy.svg",
          LessonRating.sad => "assets/image/ico-sad.svg",
          LessonRating.normal => "assets/image/ico-normal.svg",
        },
        color: switch (groupRating) {
          LessonRating.happy => Colors.green,
          LessonRating.sad => Colors.red,
          LessonRating.normal => Colors.amberAccent,
        },
        width: 32);
  }

  static Widget rowIconRating(BuildContext context,
      {double spacing = 0, LessonRating groupRating = LessonRating.happy, GtdCallback<LessonRating>? onChanged}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () => onChanged?.call(LessonRating.sad),
          child: GtdImage.svgFromAsset(
              assetPath: "assets/image/ico-sad.svg",
              color: groupRating == LessonRating.sad ? Colors.red : appBlueLightColor,
              width: 32),
        ),
        SizedBox(width: spacing),
        InkWell(
          onTap: () => onChanged?.call(LessonRating.normal),
          child: GtdImage.svgFromAsset(
              assetPath: "assets/image/ico-normal.svg",
              color: groupRating == LessonRating.normal ? Colors.amberAccent : appBlueLightColor,
              width: 32),
        ),
        SizedBox(width: spacing),
        InkWell(
          onTap: () => onChanged?.call(LessonRating.happy),
          child: GtdImage.svgFromAsset(
              assetPath: "assets/image/ico-happy.svg",
              color: groupRating == LessonRating.happy ? Colors.green : appBlueLightColor,
              width: 32),
        ),
      ],
    );
  }
}
