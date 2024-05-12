library gtd_list_title;
import 'package:flutter/material.dart';

class GtdListTitle<T> extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final bool? borderLine;
  final String? leading;
  final String? trailing;
  final TextStyle? trailingStyle;
  final TextStyle? leadingStyle;
  
  const GtdListTitle({
    super.key,
    required this.title,
    this.titleStyle,
    this.borderLine = true,
    this.leading,
    this.trailing,
    this.trailingStyle,
    this.leadingStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.grey.shade600,
          fontSize: 15,
          fontWeight: FontWeight.w400
        ).merge(titleStyle),
      ),
      leading: leading != null? Text(
        '$leading',
        style: TextStyle(
          fontSize: 15,
          color: Colors.grey.shade900,
          fontWeight: FontWeight.w500
        ).merge(leadingStyle),
      ): null,
      trailing: trailing != null? Text(
        '$trailing',
        style: TextStyle(
          fontSize: 15,
          color: Colors.grey.shade900,
          fontWeight: FontWeight.w500
        ).merge(trailingStyle),
      ): null,
      shape: borderLine != false? Border(
        bottom: BorderSide(
          color: Colors.grey.shade300,
          width: 0.5
        ),
      ): null,
    );
  }
}
