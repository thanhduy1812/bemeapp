import 'package:flutter/material.dart';
import 'package:gtd_utils/data/configuration/color_config/app_color.dart';

class GtdBoxInfo extends StatelessWidget {
  final String title;
  final String? subTitle;
  const GtdBoxInfo({super.key, required this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade200, width: 1), borderRadius: BorderRadius.circular(8)),
      child: SizedBox(
        height: 61,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 13, color: AppColors.subText, fontWeight: FontWeight.w400),
              ),
              Text(
                subTitle ?? "",
                style: TextStyle(fontSize: 15, color: AppColors.boldText, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
