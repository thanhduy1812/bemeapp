import 'package:beme_english/home/app_bottom_bar.dart';
import 'package:beme_english/home/view/input_text_field.dart';
import 'package:beme_english/home/view_model/user_list_viewmodel.dart';
import 'package:beme_english/lesson/view_controller/lesson_page.dart';
import 'package:beme_english/lesson/view_model/lesson_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:gtd_utils/base/view/base_view.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/bme_user_rs.dart';
import 'package:gtd_utils/data/configuration/color_config/app_color.dart';
import 'package:gtd_utils/helpers/extension/image_extension.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_button.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_call_back.dart';
import 'package:gtd_utils/utils/popup/gtd_present_view_helper.dart';

class UserListView extends BaseView<UserListViewModel> {
  final bool isShowRating;
  final GtdCallback<BmeUser>? onSelected;
  const UserListView({super.key, required super.viewModel, this.isShowRating = false, this.onSelected});

  @override
  Widget buildWidget(BuildContext context) {
    if (viewModel.bmeUsers.isEmpty) {
      return const Center(
          child:
              Text("No content", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: appBlueDeepColor)));
    }
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        return ListView.separated(
            itemBuilder: (context, index) {
              var user = viewModel.bmeUsers[index];
              return SizedBox(
                // height: 50,
                child: ListTile(
                  leading: GtdImage.svgFromAsset(
                      assetPath: "assets/image/ico-contact.svg", color: appBlueDeepColor, width: 32),
                  title: Text(user.fullName ?? "--",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: AppColors.boldText)),
                  subtitle: Row(
                    children: [
                      isShowRating
                          ? Card(
                              elevation: 0,
                              color: appOrangeDarkColor,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  BmeUserRole.roleFromValue(user.role ?? "").localizeValue,
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                            )
                          : const SizedBox(),
                      SizedBox(width: isShowRating ? 8 : 0),
                      Text(user.phoneNumber ?? "--",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.subText)),
                    ],
                  ),
                  trailing: isShowRating
                      ? Builder(builder: (context) {
                          (LessonRating, double)? rating;
                          switch (viewModel.viewMode) {
                            case UserListViewMode.user:
                              rating = viewModel.ratingByUsername(user.username ?? "");
                              break;
                            case UserListViewMode.mentor:
                              rating = viewModel.ratingByFeedbackTo(user.username ?? "");
                              break;
                          }
                          return rating != null
                              ? Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      rating.$2.toStringAsFixed(1),
                                      style: const TextStyle(
                                          fontSize: 18, fontWeight: FontWeight.w500, color: appOrangeDarkColor),
                                    ),
                                    const SizedBox(width: 7),
                                    LessonPage.iconRating(rating.$1),
                                  ],
                                )
                              : const SizedBox();
                        })
                      : Card(
                          elevation: 0,
                          color: appOrangeDarkColor,
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              BmeUserRole.roleFromValue(user.role ?? "").localizeValue,
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ),
                  onTap: () {
                    if (onSelected != null) {
                      onSelected?.call(user);
                      // context.pop();
                      return;
                    }
                    GtdPresentViewHelper.presentSheet(
                        title: "",
                        context: context,
                        builder: Builder(
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: _accountInfo(context, user),
                            );
                          },
                        ));
                  },
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(color: Colors.grey.shade300),
            itemCount: viewModel.bmeUsers.length);
      },
    );
  }

  Widget _accountInfo(BuildContext context, BmeUser user) {
    return StatefulBuilder(builder: (context, accountInfoState) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // CircleAvatar(
          //   radius: 50.0,
          //   backgroundImage: AssetImage('images/profile.jpg'),
          // ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            user.fullName ?? "",
            style: const TextStyle(
              fontFamily: 'DancingScript',
              fontSize: 28.0,
              color: appBlueDeepColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            user.socialName ?? "",
            style: const TextStyle(
              fontFamily: 'SourceSansPro',
              color: appOrangeDarkColor,
              letterSpacing: 5,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 20,
            width: 180,
            child: Divider(
              color: appOrangeDarkColor,
            ),
          ),
          Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 60.0,
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              leading: const Icon(
                Icons.call,
                size: 40.0,
                color: appOrangeLightColor,
              ),
              title: Text(
                (user.role?.toUpperCase() == BmeUserRole.user.roleValue) ? 'Phone' : "Teacher Code",
                style: const TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'SourceSansPro',
                  color: appBlueDeepColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(user.username ?? "---"),
            ),
          ),
          Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 60.0,
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              leading: const Icon(
                Icons.date_range,
                size: 40.0,
                color: appOrangeDarkColor,
              ),
              title: const Text(
                'BirthDate',
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'SourceSansPro',
                  color: appBlueDeepColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(user.dob ?? "---"),
            ),
          ),
          Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(
              vertical: 15.0,
              horizontal: 60.0,
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              leading: const Icon(
                Icons.class_rounded,
                size: 40.0,
                color: appOrangeDarkColor,
              ),
              title: const Text(
                'Class',
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'SourceSansPro',
                  color: appBlueDeepColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(user.tag ?? "---"),
              // onTap: () {
              //   String? classCode = user.tag;
              //   GtdPresentViewHelper.presentSheet(
              //       title: "Update Class",
              //       context: context,
              //       builder: Builder(
              //         builder: (popupContext) {
              //           return Padding(
              //             padding: const EdgeInsets.all(16.0),
              //             child: Column(
              //               children: [
              //                 InputTextField(
              //                   hintText: "Course Code",
              //                   initText: classCode ?? "",
              //                   onChanged: (value) {
              //                     classCode = value;
              //                   },
              //                 ),
              //                 const SizedBox(height: 16),
              //                 SizedBox(
              //                     width: double.infinity,
              //                     child: GtdButton(
              //                       text: "Confirm",
              //                       height: 60,
              //                       color: appOrangeDarkColor,
              //                       onPressed: (value) async {
              //                         await viewModel.updateUser(user, classCode ?? "").then((value) {
              //                           accountInfoState(
              //                             () {
              //                               popupContext.pop();
              //                             },
              //                           );
              //                         });
              //                       },
              //                     )),
              //                 const SizedBox(height: 40),
              //               ],
              //             ),
              //           );
              //         },
              //       ));
              // },
            ),
          ),
        ],
      );
    });
  }
}
