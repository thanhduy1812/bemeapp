import 'package:beme_english/home/app_bottom_bar.dart';
import 'package:beme_english/home/view/input_text_field.dart';
import 'package:beme_english/home/view/user_list_view.dart';
import 'package:beme_english/home/view_model/add_course_page_viewmodel.dart';
import 'package:beme_english/home/view_model/user_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:gtd_utils/base/page/base_stateless_page.dart';
import 'package:gtd_utils/data/configuration/color_config/app_color.dart';
import 'package:gtd_utils/helpers/extension/date_time_extension.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_button.dart';
import 'package:gtd_utils/utils/popup/gtd_popup_message.dart';
import 'package:gtd_utils/utils/popup/gtd_present_view_helper.dart';
import 'package:intl/intl.dart';

class AddCoursePage extends BaseStatelessPage<AddCoursePageViewModel> {
  static const String route = '/addCourse';
  const AddCoursePage({super.key, required super.viewModel});

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
                    Text(viewModel.title ?? "",
                        style: const TextStyle(fontSize: 24, color: appBlueDeepColor, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: InputTextField(
                          hintText: viewModel.isAddLesson ? 'Please input lesson title' : 'Please input course title',
                          labelText: viewModel.isAddLesson ? 'Lesson name' : "Course title",
                          initText: viewModel.titleField,
                          leadingIcon: Icon(
                            Icons.menu_book,
                            color: Colors.grey.shade400,
                          ),
                          onChanged: (value) {
                            viewModel.titleField = value;
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: StatefulBuilder(
                        builder: (context, setStateMentor) {
                          return InputTextField(
                            hintText: 'Please input Teacher name',
                            labelText: "Teacher name",
                            initText: viewModel.seletedMentor?.fullName ?? "",
                            leadingIcon: Icon(
                              Icons.person,
                              color: Colors.grey.shade400,
                            ),
                            isSelection: true,
                            // onChanged: (value) {},
                            onTap: () {
                              GtdPresentViewHelper.presentView(
                                  title: "Teachers",
                                  context: pageContext,
                                  builder: Builder(
                                    builder: (context) {
                                      return UserListView(
                                        viewModel: UserListViewModel(bmeUsers: viewModel.mentors),
                                        onSelected: (value) {
                                          setStateMentor(
                                            () {
                                              context.pop();
                                              viewModel.seletedMentor = value;
                                            },
                                          );
                                        },
                                      );
                                    },
                                  ));
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: StatefulBuilder(
                        builder: (context, setState) {
                          return Wrap(
                            runSpacing: 6,
                            spacing: 20,
                            children: [
                              ChoiceChip(
                                label: Text('Orient',
                                    style: TextStyle(
                                        color: !viewModel.isOrient ? AppColors.subText : Colors.white, fontSize: 17)),
                                avatar: null,
                                showCheckmark: false,
                                selected: viewModel.isOrient,
                                onSelected: (bool selected) {
                                  setState(() {
                                    viewModel.isOrient = !viewModel.isOrient;
                                  });
                                },
                              ),
                              ChoiceChip(
                                label: Text('IPA',
                                    style: TextStyle(
                                        color: !viewModel.isIPA ? AppColors.subText : Colors.white, fontSize: 17)),
                                avatar: null,
                                showCheckmark: false,
                                selected: viewModel.isIPA,
                                onSelected: (bool selected) {
                                  setState(() {
                                    viewModel.isIPA = !viewModel.isIPA;
                                  });
                                },
                              ),
                              ChoiceChip(
                                label: Text('Speaking',
                                    style: TextStyle(
                                        color: !viewModel.isSpeaking ? AppColors.subText : Colors.white, fontSize: 17)),
                                avatar: null,
                                showCheckmark: false,
                                selected: viewModel.isSpeaking,
                                onSelected: (bool selected) {
                                  setState(() {
                                    viewModel.isSpeaking = !viewModel.isSpeaking;
                                  });
                                },
                              ),
                              ChoiceChip(
                                label: Text('Listening',
                                    style: TextStyle(
                                        color: !viewModel.isListening ? AppColors.subText : Colors.white,
                                        fontSize: 17)),
                                avatar: null,
                                showCheckmark: false,
                                selected: viewModel.isListening,
                                onSelected: (bool selected) {
                                  setState(() {
                                    viewModel.isListening = !viewModel.isListening;
                                  });
                                },
                              ),
                              ChoiceChip(
                                label: Text('Grammar',
                                    style: TextStyle(
                                        color: !viewModel.isGrammar ? AppColors.subText : Colors.white, fontSize: 17)),
                                avatar: null,
                                showCheckmark: false,
                                selected: viewModel.isGrammar,
                                onSelected: (bool selected) {
                                  setState(() {
                                    viewModel.isGrammar = !viewModel.isGrammar;
                                  });
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: SizedBox(
                          width: double.infinity,
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  const Text("Color: ",
                                      style: TextStyle(
                                          fontSize: 17, fontWeight: FontWeight.w700, color: appBlueDeepColor)),
                                  StatefulBuilder(
                                    builder: (context, setStateColor) {
                                      return SizedBox(
                                          height: 60,
                                          width: 100,
                                          child: InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: pageContext,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                        content: MaterialColorPicker(
                                                      allowShades: false,
                                                      alignment: WrapAlignment.start,
                                                      spacing: 9,
                                                      onMainColorChange: (value) {
                                                        if (value != null) {
                                                          setStateColor(
                                                            () {
                                                              viewModel.selectedColor = Color(value.value);
                                                            },
                                                          );
                                                        }
                                                      },
                                                      // onColorChange: (value) {
                                                      //   setStateColor(
                                                      //     () {
                                                      //       viewModel.selectedColor = value;
                                                      //     },
                                                      //   );
                                                      // },
                                                      selectedColor: viewModel.selectedColor,
                                                      colors: const [Colors.red, Colors.green],
                                                    ));
                                                  },
                                                );
                                              },
                                              child: Card(color: viewModel.selectedColor)));
                                    },
                                  ),
                                ],
                              ))),
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
                        // GtdCalendarHelper.presentLunaCalendar(
                        //   context: pageContext,
                        //   lunaDateMode: GtdLunarDateMode.single,
                        //   title: "Choose Date",
                        //   dayStartLabel: "Start",
                        //   selectDayViewStartLabel: "Selected Date",
                        //   initStartDate: viewModel.startDate,
                        //   onSelected: (value) {
                        //     if (value.startDate != null) {
                        //       viewModel.setStartDate(value.startDate!);
                        //     }
                        //   },
                        // );
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
                                    if (!viewModel.isEditMode) {
                                      await viewModel.createCourse().then((value) {
                                        value.when((success) {
                                          pageContext.pop(success);
                                        }, (error) {
                                          GtdPopupMessage(context).showError(error: error.message);
                                        });
                                      });
                                    } else {
                                      await viewModel.updateCourse().then((value) {
                                        value.when((success) {
                                          pageContext.pop(success);
                                        }, (error) {
                                          GtdPopupMessage(context).showError(error: error.message);
                                        });
                                      });
                                    }
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
}
