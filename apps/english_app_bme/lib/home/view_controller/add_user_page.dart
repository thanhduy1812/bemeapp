import 'package:beme_english/home/app_bottom_bar.dart';
import 'package:beme_english/home/view/input_text_field.dart';
import 'package:beme_english/home/view_model/add_user_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:gtd_utils/base/page/base_stateless_page.dart';
import 'package:gtd_utils/data/bme_repositories/bme_client/model/bme_user_rs.dart';
import 'package:gtd_utils/helpers/extension/date_time_extension.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_button.dart';
import 'package:gtd_utils/utils/popup/gtd_popup_message.dart';

class AddUserPage extends BaseStatelessPage<AddUserPageViewModel> {
  static const String route = '/addUser';
  const AddUserPage({super.key, required super.viewModel});

  @override
  Widget buildBody(BuildContext pageContext) {
    return SizedBox(
      height: double.infinity,
      child: ColoredBox(
        color: Colors.white,
        child: SingleChildScrollView(
          child: SizedBox(
            child: ListenableBuilder(
                listenable: viewModel,
                builder: (context, child) {
                  return Column(
                    children: [
                      Text(viewModel.headerTitle,
                          style: const TextStyle(fontSize: 24, color: appBlueDeepColor, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: InputTextField(
                            hintText: 'Please input full name',
                            labelText: "Full name",
                            initText: viewModel.fullName,
                            leadingIcon: Icon(
                              Icons.supervised_user_circle,
                              color: Colors.grey.shade400,
                            ),
                            onChanged: (value) {
                              viewModel.fullName = value;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: InputTextField(
                            hintText: 'Please input facebook name',
                            labelText: "Facebook name",
                            initText: viewModel.facebookName,
                            leadingIcon: Icon(
                              Icons.facebook,
                              color: Colors.grey.shade400,
                            ),
                            onChanged: (value) {
                              viewModel.facebookName = value;
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ListenableBuilder(
                          listenable: viewModel,
                          builder: (context, child) {
                            return InputTextField(
                                hintText: viewModel.role.toUpperCase() == BmeUserRole.user.roleValue
                                    ? '09xxxxxxxx'
                                    : "Username",
                                labelText: viewModel.role.toUpperCase() == BmeUserRole.user.roleValue
                                    ? "Phone Number"
                                    : "UserName",
                                initText: viewModel.phoneNumber,
                                leadingIcon: Icon(
                                  viewModel.role.toUpperCase() == BmeUserRole.user.roleValue
                                      ? Icons.phone
                                      : Icons.person_2,
                                  color: Colors.grey.shade400,
                                ),
                                onChanged: (value) {
                                  viewModel.phoneNumber = value;
                                });
                          },
                        ),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              showDatePicker(
                                context: pageContext,
                                firstDate: DateTime.now().subtract(const Duration(days: 36500)),
                                lastDate: DateTime.now(),
                                initialDate: viewModel.dob,
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
                                            foregroundColor: Colors.blueAccent,
                                            textStyle: const TextStyle(fontSize: 20)),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              ).then((value) {
                                if (value != null) {
                                  viewModel.setDobDate(value);
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
                                  Text(dateFormat.format(viewModel.dob),
                                      style: const TextStyle(
                                          fontSize: 17, fontWeight: FontWeight.w600, color: appBlueDeepColor))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Text(
                            "Role:  ",
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          StatefulBuilder(builder: (context, roleState) {
                            return DropdownButton<String>(
                              value: viewModel.role,
                              icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: appBlueDeepColor),
                              elevation: 16,
                              style:
                                  const TextStyle(color: appBlueDeepColor, fontSize: 17, fontWeight: FontWeight.w700),
                              underline: Container(
                                height: 2,
                                color: appBlueDeepColor,
                              ),
                              onChanged: (String? value) {
                                if (value != null) {
                                  roleState(
                                    () {
                                      viewModel.role = value;
                                      viewModel.updateRole();
                                    },
                                  );
                                }
                              },
                              items: viewModel.listRole.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            );
                          }),
                        ],
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
                                      await viewModel.validateExistPhoneNumber().then((value) {
                                        value.when((success) async {
                                          if (success.isNotEmpty) {
                                            GtdPopupMessage(pageContext).showError(error: "Số điện thoại đã tồn tại!");
                                          } else {
                                            await viewModel.createUser().then((value) {
                                              value.when((success) {
                                                pageContext.pop(success);
                                              }, (error) {
                                                GtdPopupMessage(pageContext).showError(error: error.message);
                                              });
                                            });
                                          }
                                        }, (error) {
                                          GtdPopupMessage(pageContext).showError(error: error.message);
                                        });
                                      });
                                    } else {
                                      GtdPopupMessage(pageContext).showError(error: "Please enter full information");
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
