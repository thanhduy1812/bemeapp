import 'package:flutter/material.dart';

class BottomNavBarItem extends BottomNavigationBarItem {
  final String initialLocation;

  const BottomNavBarItem(
      {required this.initialLocation,
      required Widget icon,
      String? label,
      Widget? activeIcon})
      : super(icon: icon, label: label, activeIcon: activeIcon ?? icon);
}
