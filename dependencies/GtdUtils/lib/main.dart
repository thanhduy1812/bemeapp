import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gtd_utils/constants/app_const.dart';
import 'package:gtd_utils/data/cache_helper/cache_helper.dart';
import 'package:gtd_utils/data/configuration/gtd_app_config.dart';
import 'package:gtd_utils/data/network/gtd_app_logger.dart';
import 'package:gtd_utils/helpers/extension/string_extension.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  CacheHelper.shared.initCachedMemory();
  CacheHelper.shared.initCachedStorage();
  // String pathAsset = await rootBundle.loadString('assets/env/${GtdAppMode.prodvib.envFile}');
  AppConst.shared.appScheme = GtdAppScheme.beme;
  Logger.setLogLevel(Logger.DEBUG);
  runApp(const TestApiApp());
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TestResourcePackage(
        title: 'Test IMAGE',
      ),
    );
  }
}

class TestApiApp extends StatelessWidget {
  const TestApiApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test api",
      supportedLocales: const [Locale.fromSubtags(languageCode: 'vi'), Locale.fromSubtags(languageCode: 'en')],
      locale: const Locale('en', 'US'),
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      theme: ThemeData.light(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        ),
        onPressed: () async {},
        child: const Text('Call API'),
      ),
    );
  }
}

class TestResourcePackage extends StatefulWidget {
  const TestResourcePackage({super.key, required this.title});
  final String title;

  @override
  State<TestResourcePackage> createState() => _TestResourcePackageState();
}

class _TestResourcePackageState extends State<TestResourcePackage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('main app image'),
            SvgPicture.asset(
              GtdString.pathForAsset(AppConst.shared.supplierResource, 'assets/icons/airlines/VJ.svg'),
              bundle: rootBundle,
              width: 90,
              height: 90,
              // color: Colors.blue,
            ),
            const SizedBox(height: 40),
            const Text('package image'),
          ],
        ),
      ),
    );
  }
}
