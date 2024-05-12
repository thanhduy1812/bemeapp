// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import 'package:gtd_utils/data/cache_helper/cache_helper.dart';
import 'package:gtd_utils/data/configuration/gtd_app_config.dart';

class GtdChannelSettingObject {
  GtdChannelSettingObject._();
  static final shared = GtdChannelSettingObject._();
  GtdAppScheme? appScheme;
  String? token;
  String? locale;
  ThemeMode? theme;

  @override
  String toString() => 'GtdChannelSettingObject(appScheme: $appScheme, token: $token, locale: $locale)';
}

class GtdNativeChannel {
  static const channelName = 'gtd.messageToNativeChannel';
  MethodChannel? methodChannel;
  MethodChannel navigationChannel = SystemChannels.navigation;
  MethodChannel localizationChannel = SystemChannels.localization;
  BasicMessageChannel lifeCycleChannel = SystemChannels.lifecycle;

  static final GtdNativeChannel shared = GtdNativeChannel._init();
  GtdNativeChannel._init() {
    methodChannel = const OptionalMethodChannel(channelName);
  }

  Future<void> gotoPaymentPartner(String bookingNumber) async {
    try {
      var _ = await navigationChannel.invokeMethod("push.partner.payment", bookingNumber);
    } catch (e) {
      if (kDebugMode) {
        print("Failed to navigate to payment partner");
      }
    }
  }

  Future<void> gotoFinalBooking(String bookingNumber) async {
    try {
      var _ = await navigationChannel.invokeMethod("push.partner.finalBooking", bookingNumber);
    } catch (e) {
      if (kDebugMode) {
        print("Failed to navigate to final booking");
      }
    }
  }

  Future<void> gotoBookingInvoice(String bookingNumber) async {
    try {
      var _ = await navigationChannel.invokeMethod("push.partner.bookingInvoice", bookingNumber);
    } catch (e) {
      if (kDebugMode) {
        print("Failed to navigate to final booking");
      }
    }
  }

  Future<void> popToPartnerHome() async {
    try {
      var _ = await navigationChannel.invokeMethod("pop.partner.home");
    } catch (e) {
      if (kDebugMode) {
        print("Failed to navigate to payment partner");
      }
    }
  }

  Future<void> receivePartnerConfig() async {
    var result = await GtdNativeChannel.shared.localizationChannel.invokeMethod("partner.app.scheme");
    Map<String, dynamic>? scheme = result as Map<String, dynamic>?;
    if (kDebugMode) {
      print("Gotadi - Partner Scheme: $scheme");
    }
    if (scheme != null) {
      String? env = scheme["env"];
      String? partner = scheme["partner"];
      String? token = scheme["token"];
      String? locale = scheme["locale"];
      String? theme = scheme["theme"];

      GtdChannelSettingObject.shared.locale = locale;
      GtdChannelSettingObject.shared.token = token;
      if (env != null && partner != null) {
        GtdChannelSettingObject.shared.appScheme = GtdAppScheme.getAppScheme(env, partner);
      }
      switch (theme) {
        case "primary":
          GtdChannelSettingObject.shared.theme = ThemeMode.light;
          break;
        case "secondary":
          GtdChannelSettingObject.shared.theme = ThemeMode.dark;
          break;
        default:
          GtdChannelSettingObject.shared.theme = ThemeMode.light;
      }

      if (kDebugMode) {
        print(GtdChannelSettingObject.shared.toString());
      }
    }
  }

  Future<void> handleNativeNavigation(BuildContext context) async {
    navigationChannel.setMethodCallHandler((call) {
      if (call.method == "pushRoute") {
        String? pathRouter = call.arguments as String?;
        if (pathRouter != null) {
          if (pathRouter == "/vibInvoice") {
            context.go(pathRouter);
          } else {
            context.push(pathRouter);
          }
        }
        return Future.value(true);
      }
      return Future.value(true);
    });
  }

  void handleNativeSettingMessage() async {
    if (kDebugMode) {
      print("Init handleNativeSettingMessage");
    }
    localizationChannel.setMethodCallHandler((call) {
      if (call.method == "partner.app.locale") {
        String? locale = call.arguments as String?;
        if (locale != null) {
          CacheHelper.shared.cacheLanguage(locale);
        }
        return Future.value(true);
      }
      if (call.method == "partner.app.token") {
        String? token = call.arguments as String?;
        if (token != null) {
          CacheHelper.shared.cacheAppToken(token);
        }
        return Future.value(true);
      }

      if (call.method == "partner.app.scheme") {
        Map<String, String>? scheme = call.arguments as Map<String, String>?;
        if (kDebugMode) {
          print("Gotadi - Partner Scheme: $scheme");
        }
        if (scheme != null) {
          String? env = scheme["env"];
          String? partner = scheme["partner"];
          String? token = scheme["token"];
          String? locale = scheme["locale"];
          String? theme = scheme["theme"];
          // if (locale != null) {
          //   CacheHelper.shared.cacheLanguage(locale);
          // }
          // if (token != null) {
          //   CacheHelper.shared.cacheAppToken(token);
          // }
          // if (env != null && partner != null) {
          //   var appScheme = GtdAppScheme.getAppScheme(env, partner);
          //   AppConst.shared.appScheme = appScheme;
          // }
          // if (theme != null) {
          //   switch (theme) {
          //     case "theme1":
          //       AppConst.shared.themeMode = ThemeMode.light;
          //       break;
          //     case "theme2":
          //       AppConst.shared.themeMode = ThemeMode.dark;
          //       break;
          //     default:
          //       AppConst.shared.themeMode = ThemeMode.light;
          //   }
          // }
        }
        return Future.value(true);
      }
      return Future.value(true);
    });
  }
}
