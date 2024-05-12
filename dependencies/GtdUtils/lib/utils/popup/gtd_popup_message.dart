import 'package:flutter/material.dart';
import 'package:gtd_utils/helpers/extension/colors_extension.dart';
import 'package:gtd_utils/helpers/extension/image_extension.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_button.dart';
import 'package:gtd_utils/utils/gtd_widgets/gtd_call_back.dart';

class GtdPopupMessage {
  late BuildContext context;

  GtdPopupMessage(this.context);

  Future<void> showError(
      {String title = "", String error = "", GtdVoidCallback? onCancel, GtdCallback? onConfirm}) async {
    //Show popup error and dismiss or callback handle if touch OK/ Cancel
    return await showDialog(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext builder) => AlertDialog(
        // title: Text(
        //   title,
        //   textAlign: TextAlign.center,
        // ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        content: Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
              child: Padding(
            padding: EdgeInsets.all(title.isEmpty ? 0.0 : 10.0),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          )),
          SizedBox(
              child: Padding(
            padding: EdgeInsets.all(error.isEmpty ? 0.0 : 10.0),
            child: Text(error),
          )),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GtdButton(
                    text: "Cancel",
                    height: 40,
                    borderRadius: 10,
                    border: Border.all(color: Colors.grey.shade200, width: 2),
                    colorText: Colors.black,
                    onPressed: (a) {
                      Navigator.of(context).pop<bool>(false);
                      onCancel?.call();
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GtdButton(
                    text: "OK",
                    height: 40,
                    borderRadius: 10,
                    gradient: GtdColors.appGradient(context),
                    onPressed: (a) {
                      Navigator.of(context).pop<bool>(true);
                      onConfirm?.call(a);
                    },
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }

  static void showConfirm(
      {required BuildContext context,
      String title = "",
      String error = "",
      Function()? onConfirm,
      Function()? onCancel}) async {
    //Show popup error and dismiss or callback handle if touch OK/ Cancel
    return await showDialog(
      context: context,
      builder: (BuildContext builder) => AlertDialog(
        backgroundColor: Colors.white,
        elevation: 0.0,
        content: Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
          SizedBox(
              child: Padding(
            padding: EdgeInsets.all(title.isEmpty ? 0.0 : 10.0),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          )),
          SizedBox(
              child: Padding(
            padding: EdgeInsets.all(error.isEmpty ? 0.0 : 10.0),
            child: Text(error),
          )),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GtdButton(
                    text: "Cancel",
                    height: 40,
                    borderRadius: 10,
                    border: Border.all(color: Colors.grey.shade200, width: 2),
                    colorText: Colors.black,
                    onPressed: (a) {
                      Navigator.of(context).pop<bool>(false);
                      onCancel?.call();
                    },
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GtdButton(
                    text: "OK",
                    height: 40,
                    borderRadius: 10,
                    gradient: GtdColors.appGradient(context),
                    onPressed: (a) {
                      Navigator.of(context).pop<bool>(true);
                      onConfirm?.call();
                    },
                  ),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }

  static Widget centerAlert(
      {required BuildContext context,
      String title = "",
      String error = "",
      GtdVoidCallback? onCancel,
      GtdCallback? onConfirm}) {
    return AlertDialog(
      backgroundColor: Colors.white,
      elevation: 0.0,
      content: Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
            child: Padding(
          padding: EdgeInsets.all(title.isEmpty ? 0.0 : 10.0),
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        )),
        SizedBox(
            child: Padding(
          padding: EdgeInsets.all(error.isEmpty ? 0.0 : 10.0),
          child: Text(error),
        )),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GtdButton(
                  text: "Cancel",
                  height: 40,
                  borderRadius: 10,
                  border: Border.all(color: Colors.grey.shade200, width: 2),
                  colorText: Colors.black,
                  onPressed: (a) {
                    Navigator.of(context).pop<bool>(false);
                    onCancel?.call();
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GtdButton(
                  text: "OK",
                  height: 40,
                  borderRadius: 10,
                  gradient: GtdColors.appGradient(context),
                  onPressed: (a) {
                    Navigator.of(context).pop<bool>(true);
                    onConfirm?.call(a);
                  },
                ),
              ),
            ),
          ],
        )
      ]),
    );
  }

  static void confirmPopUp({
    required BuildContext context,
    required String title,
    required String description,
    required String cancelText,
    required String confirmText,
    required VoidCallback onConfirm,
    bool barrierDismissible = true,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GtdButton(
                      text: cancelText,
                      height: 40,
                      borderRadius: 20,
                      border: Border.all(
                        color: Colors.grey.shade200,
                        width: 2,
                      ),
                      colorText: Colors.black,
                      onPressed: (_) {
                        Navigator.of(dialogContext).pop();
                      },
                    ),
                    const SizedBox(width: 8),
                    GtdButton(
                      text: confirmText,
                      height: 40,
                      borderRadius: 20,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      gradient: GtdColors.appGradient(context),
                      onPressed: (_) {
                        Navigator.of(dialogContext).pop();
                        onConfirm.call();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static void showPopUpWithIcon({
    required BuildContext context,
    String? cancelText,
    String? confirmText,
    VoidCallback? onConfirm,
    required String iconAssetPath,
    String? title,
    String? description,
    String? subtitle,
    Widget? titleWidget,
    Widget? descriptionWidget,
    bool barrierDismissible = true,
  }) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 60,
                  width: 60,
                  child: Center(
                    child: GtdImage.svgFromSupplier(
                      assetName: iconAssetPath,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                title != null
                    ? Text(
                        title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : titleWidget ?? const SizedBox(),
                const SizedBox(height: 16),
                description != null
                    ? Text(
                        description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      )
                    : descriptionWidget ?? const SizedBox(),
                if (subtitle != null) ...[
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (cancelText != null) ...[
                      GtdButton(
                        text: cancelText,
                        height: 40,
                        borderRadius: 20,
                        border: Border.all(
                          color: Colors.grey.shade200,
                          width: 2,
                        ),
                        colorText: Colors.black,
                        onPressed: (_) {
                          Navigator.of(dialogContext).pop();
                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                    if (confirmText != null)
                      GtdButton(
                        text: confirmText,
                        height: 40,
                        borderRadius: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        gradient: GtdColors.appGradient(context),
                        onPressed: (_) {
                          Navigator.of(dialogContext).pop();
                          onConfirm?.call();
                        },
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
