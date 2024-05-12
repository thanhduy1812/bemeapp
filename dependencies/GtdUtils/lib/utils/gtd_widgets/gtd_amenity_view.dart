import 'package:flutter/material.dart';

class GtdAmenityView extends StatelessWidget {
  final Widget? leadingIcon;
  final String title;
  final Color? backgroundColor;
  const GtdAmenityView({super.key, this.leadingIcon, required this.title, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(2),
      color: backgroundColor ?? Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100), side: BorderSide(color: Colors.grey.shade200)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        child: IntrinsicWidth(
          child: Row(
            children: [
              leadingIcon ?? const SizedBox(),
              SizedBox(
                width: leadingIcon != null ? 4 : 0,
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
