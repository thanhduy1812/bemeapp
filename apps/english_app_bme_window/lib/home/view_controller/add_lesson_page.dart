import 'package:beme_english/home/app_bottom_bar.dart';
import 'package:beme_english/home/view/input_text_field.dart';
import 'package:beme_english/home/view_model/add_course_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gtd_utils/base/page/base_stateless_page.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/add_lesson_rq.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/bme_origin_course_rs.dart';
import 'package:gtd_utils/helpers/extension/date_time_extension.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_button.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_call_back.dart';
import 'package:gtd_utils/utils/popup/gtd_popup_message.dart';
import 'package:intl/intl.dart';

class AddLessonPage extends BaseStatelessPage<AddCoursePageViewModel> {
  static const String route = '/addLesson';
  const AddLessonPage({super.key, required super.viewModel});

  @override
  Widget? titleWidget() {
    return const SizedBox();
  }

  @override
  Widget buildBody(BuildContext pageContext) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        return ColoredBox(
          color: Colors.white,
          child: SizedBox(
              height: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(viewModel.isEditMode ? "Edit this lesson" : "Add a lesson",
                        style: const TextStyle(fontSize: 24, color: appBlueDeepColor, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InputTextField(
                          hintText: 'Please input lesson title',
                          labelText: 'Lesson name',
                          leadingIcon: Icon(
                            Icons.menu_book,
                            color: Colors.grey.shade400,
                          ),
                          onChanged: (value) {
                            viewModel.titleField = value;
                          }),
                    ),
                    InkWell(
                      onTap: () {
                        showDatePicker(
                          context: pageContext,
                          firstDate: DateTime.now().subtract(const Duration(days: 36500)),
                          lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                          initialDate: viewModel.startDate,
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                colorScheme: const ColorScheme.light(
                                  primary: appOrangeDarkColor, // header background color
                                  onPrimary: Colors.black, // header text color
                                  onSurface: appBlueDeepColor, // body text color
                                ),
                                textButtonTheme: TextButtonThemeData(
                                  style: TextButton.styleFrom(
                                      foregroundColor: Colors.blueAccent, textStyle: const TextStyle(fontSize: 20)),
                                ),
                              ),
                              child: child!,
                            );
                          },
                        ).then((value) {
                          if (value != null) {
                            viewModel.setStartDate(value);
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const SizedBox(
                              height: 48,
                              width: 48,
                              child: Card(
                                shadowColor: Colors.black,
                                child: Icon(Icons.calendar_month, color: appBlueDeepColor),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(dateFormat.format(viewModel.startDate),
                                style:
                                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: appBlueDeepColor))
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await showTimePicker(
                          context: pageContext,
                          initialTime: TimeOfDay(hour: viewModel.startDate.hour, minute: viewModel.startDate.minute),
                          // initialEntryMode: TimePickerEntryMode.inputOnly,
                        ).then((value) {
                          if (value != null) {
                            viewModel.setHourDate(value);
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const SizedBox(
                              height: 48,
                              width: 48,
                              child: Card(
                                shadowColor: Colors.black,
                                child: Icon(Icons.timer, color: appOrangeDarkColor),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(DateFormat('hh:mm a').format(viewModel.startDate),
                                style:
                                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: appBlueDeepColor))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: GtdButton(
                                text: "Cancel",
                                fontSize: 18,
                                borderRadius: 18,
                                colorText: Colors.red,
                                color: Colors.red.shade50,
                                height: 60,
                                onPressed: (value) {
                                  pageContext.pop();
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: GtdButton(
                                text: "Confirm",
                                fontSize: 18,
                                borderRadius: 18,
                                colorText: Colors.white,
                                color: Colors.orange,
                                height: 60,
                                onPressed: (value) async {
                                  if (viewModel.validateForm()) {
                                    await viewModel.createLessonRoadmap().then((value) {
                                      value.when((success) {
                                        pageContext.pop(success);
                                      }, (error) {
                                        GtdPopupMessage(context).showError(error: error.message);
                                      });
                                    });
                                  } else {
                                    GtdPopupMessage(context).showError(error: "Please input full field!");
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }

  static Widget addLessonForm(BuildContext pageContext,
      {required BmeOriginCourse course, GtdCallback<AddLessonRq?>? onCompleted}) {
    // DateTime selectedDate = DateTime.now();
    AddCoursePageViewModel viewModel = AddCoursePageViewModel.initAddLessonPage(course: course);

    return StatefulBuilder(builder: (context, setState) {
      return Column(
        children: [
          // const Text("Add a lesson",
          //     style: TextStyle(fontSize: 24, color: appBlueDeepColor, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              showDatePicker(
                context: pageContext,
                firstDate: DateTime.now().subtract(const Duration(days: 36500)),
                lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                initialDate: viewModel.startDate,
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                        primary: appOrangeDarkColor, // header background color
                        onPrimary: Colors.black, // header text color
                        onSurface: appBlueDeepColor, // body text color
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.blueAccent, textStyle: const TextStyle(fontSize: 20)),
                      ),
                    ),
                    child: child!,
                  );
                },
              ).then((value) {
                if (value != null) {
                  setState(
                    () {
                      viewModel.setStartDate(value);
                    },
                  );
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const SizedBox(
                    height: 48,
                    width: 48,
                    child: Card(
                      shadowColor: Colors.black,
                      child: Icon(Icons.calendar_month, color: appBlueDeepColor),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(dateFormat.format(viewModel.startDate),
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: appBlueDeepColor))
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await showTimePicker(
                context: pageContext,
                initialTime: TimeOfDay(hour: viewModel.startDate.hour, minute: viewModel.startDate.minute),
                // initialEntryMode: TimePickerEntryMode.inputOnly,
              ).then((value) {
                if (value != null) {
                  setState(() {
                    viewModel.setHourDate(value);
                  });
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const SizedBox(
                    height: 48,
                    width: 48,
                    child: Card(
                      shadowColor: Colors.black,
                      child: Icon(Icons.timer, color: appOrangeDarkColor),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(DateFormat('hh:mm a').format(viewModel.startDate),
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: appBlueDeepColor))
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: GtdButton(
                      text: "Cancel",
                      fontSize: 18,
                      borderRadius: 18,
                      colorText: Colors.red,
                      color: Colors.red.shade50,
                      height: 60,
                      onPressed: (value) {
                        // pageContext.pop();
                        onCompleted?.call(null);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GtdButton(
                      text: "Confirm",
                      fontSize: 18,
                      borderRadius: 18,
                      colorText: Colors.white,
                      color: Colors.orange,
                      height: 60,
                      onPressed: (value) async {
                        await viewModel.createLessonRoadmap().then((value) {
                          value.when((success) {
                            onCompleted?.call(success);
                          }, (error) {
                            GtdPopupMessage(pageContext).showError(error: error.message);
                          });
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16)
        ],
      );
    });
  }
}
