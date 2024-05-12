import 'package:beme_english/home/view_model/home_page_viewmodel.dart';
import 'package:beme_english/login/view_controller/login_page.dart';
import 'package:beme_english/login/view_model/login_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gtd_utils/helpers/extension/image_extension.dart';

import '../home/view_controller/home_page.dart';

class SplashScreen extends StatefulWidget {
  static const String route = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Future.delayed(const Duration(seconds: 1)).then((value) {
      context.pushReplacement(HomePage.route, extra: HomePageViewModel());
      // var viewModel = LoginPageViewModel();
      // if (viewModel.cachedUser?.isRemember == true) {
      //   viewModel.login().whenComplete(() {
      //     context.pushReplacement(HomePage.route, extra: HomePageViewModel());
      //   });
      // } else {
      //   context.pushReplacement(LoginPage.route, extra: viewModel);
      // }
    });
    return ColoredBox(
      color: Colors.white,
      child: SizedBox(
        height: size.height,
        width: size.width,
        child: Center(
          child: GtdImage.imgFromAsset(assetPath: "assets/icon/beme-logo.png"),
        ),
      ),
    );
  }
}
