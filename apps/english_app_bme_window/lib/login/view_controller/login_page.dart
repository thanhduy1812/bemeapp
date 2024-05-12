import 'package:beme_english/home/app_bottom_bar.dart';
import 'package:beme_english/home/view_controller/home_page.dart';
import 'package:beme_english/home/view_model/home_page_viewmodel.dart';
import 'package:beme_english/login/view_model/login_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:gtd_utils/base/page/base_stateless_page.dart';
import 'package:gtd_utils/data/configuration/color_config/app_color.dart';
import 'package:gtd_utils/helpers/extension/build_context_extension.dart';
import 'package:gtd_utils/helpers/extension/image_extension.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_button.dart';
import 'package:gtd_utils/utils/popup/gtd_loading.dart';
import 'package:gtd_utils/utils/popup/gtd_popup_message.dart';

class LoginPage extends BaseStatelessPage<LoginPageViewModel> {
  static const String route = '/login';
  const LoginPage({super.key, required super.viewModel});

  @override
  Widget buildBody(BuildContext pageContext) {
    return ColoredBox(
      color: Colors.white,
      child: SizedBox(
          // height: double.infinity,
          height: pageContext.mediaQuery.size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(child: GtdImage.imgFromAsset(assetPath: "assets/icon/beme-logo.png", width: 150)),
                const Text("Welcome",
                    style: TextStyle(fontSize: 24, color: appBlueDeepColor, fontWeight: FontWeight.w700)),
                Text("Login to your account",
                    style: TextStyle(fontSize: 20, color: AppColors.subText, fontWeight: FontWeight.w400)),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.grey.shade500, width: 1.0, style: BorderStyle.solid)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: Colors.grey.shade500, width: 1.0, style: BorderStyle.solid)),
                      hintText: 'Please input your username',
                      labelText: "Username",
                      labelStyle: TextStyle(color: AppColors.subText),
                      floatingLabelStyle: const TextStyle(color: appBlueDeepColor),
                      hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey.shade300),
                      filled: false,
                      fillColor: Colors.white,
                      focusColor: appBlueDeepColor,
                      hoverColor: appBlueDeepColor,
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    onChanged: (value) {
                      viewModel.username = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: StatefulBuilder(builder: (context, statePass) {
                    return TextField(
                      obscureText: !viewModel.isShowPassword,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade500, width: 1.0, style: BorderStyle.solid)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade500, width: 1.0, style: BorderStyle.solid)),
                          hintText: 'Please input your password',
                          labelText: "Password",
                          labelStyle: TextStyle(color: AppColors.subText),
                          floatingLabelStyle: const TextStyle(color: appBlueDeepColor),
                          hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey.shade300),
                          filled: false,
                          fillColor: Colors.white,
                          focusColor: appBlueDeepColor,
                          hoverColor: appBlueDeepColor,
                          prefixIcon: Icon(
                            Icons.key,
                            color: Colors.grey.shade500,
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                statePass(
                                  () {
                                    viewModel.isShowPassword = !viewModel.isShowPassword;
                                  },
                                );
                              },
                              icon: Icon(!viewModel.isShowPassword ? Icons.visibility : Icons.visibility_off))),
                      onChanged: (value) {
                        viewModel.password = value;
                      },
                    );
                  }),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: SizedBox(
                        width: 200,
                        height: 60,
                        child: StatefulBuilder(builder: (context, setStateRemember) {
                          return CheckboxListTile(
                            value: viewModel.rememberPassword,
                            controlAffinity: ListTileControlAffinity.leading,
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              "Remember me!",
                              style: TextStyle(color: appOrangeDarkColor),
                            ),
                            onChanged: (value) {
                              setStateRemember(
                                () {
                                  viewModel.rememberPassword = value ?? false;
                                },
                              );
                            },
                          );
                        }),
                      ),
                    ),
                    const Spacer()
                  ],
                ),
                // const SizedBox(
                //   width: 100,
                //   height: 80,
                //   child: Row(
                //     children: [
                //       // Spacer(),
                //       // SizedBox(
                //       //   width: 150,
                //       //   height: 60,
                //       //   child: CheckboxListTile(
                //       //     value: false,
                //       //     onChanged: (value) {},
                //       //     title: const Text("Remember me!"),
                //       //   ),
                //       // ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GtdButton(
                      text: "Login",
                      fontSize: 20,
                      colorText: Colors.white,
                      color: Colors.orange,
                      height: 60,
                      onPressed: (value) async {
                        FocusScope.of(pageContext).unfocus();
                        GtdLoading.show();
                        await viewModel.login().then((value) {
                          GtdLoading.hide();
                          value.when((success) {
                            var viewModel = HomePageViewModel();
                            pageContext.pushReplacement(HomePage.route, extra: viewModel);
                          }, (error) {
                            GtdPopupMessage(pageContext).showError(error: error.message);
                          });
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
