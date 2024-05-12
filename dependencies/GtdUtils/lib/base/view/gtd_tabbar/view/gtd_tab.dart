import 'package:flutter/material.dart';

class GtdTab<T> extends Tab {
  final T data;

  const GtdTab({super.key, required this.data, super.text, super.child, super.icon, super.iconMargin});
}
