import 'package:flutter/material.dart';
import 'package:gtd_utils/helpers/extension/image_extension.dart';
import 'package:path/path.dart' as p;

extension GtdAppIcon on Icon {
  static Widget iconNamedSupplier({
    required String iconName,
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) {
    String pathExtension = p.extension(iconName);
    if (pathExtension.toLowerCase() == ".svg") {
      return GtdImage.svgFromSupplier(
        assetName: "assets/icons/$iconName",
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
        color: color,
      );
    } else {
      return GtdImage.imgFromSupplier(
        assetName: "assets/icons/$iconName",
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
      );
    }
  }

  // static Widget iconNamedCommon(
  //     {required String iconName, double? width, double? height, BoxFit? fit}) {
  //   String pathExtension = p.extension(iconName);
  //   if (pathExtension.toLowerCase() == ".svg") {
  //     return GtdImage.svgFromCommon(
  //         assetName: "assets/icons/$iconName",
  //         width: width,
  //         height: height,
  //         fit: fit ?? BoxFit.contain);
  //   } else {
  //     return GtdImage.imgFromCommon(
  //         assetName: "assets/icons/$iconName",
  //         width: width,
  //         height: height,
  //         fit: fit ?? BoxFit.contain);
  //   }
  // }

  static Widget get radioCircle {
    return GtdImage.svgFromSupplier(assetName: "assets/icons/radio/radio-circle.svg");
  }

  static Widget get radioCircleActive {
    return GtdImage.svgFromSupplier(assetName: "assets/icons/radio/radio-circle-active.svg");
  }

  static Widget get radioCheckbox {
    return GtdImage.svgFromSupplier(assetName: "assets/icons/radio/radio-checkbox.svg");
  }

  static Widget get radioCheckboxActive {
    return GtdImage.svgFromSupplier(assetName: "assets/icons/radio/radio-checkbox-active.svg");
  }

  static Widget iconInsurance({required String status}) {
    return GtdImage.svgFromSupplier(assetName: "assets/icons/status/booking-status-success.svg");
  }
}
