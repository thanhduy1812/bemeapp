import 'package:beme_english/home/view_model/home_page_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:gtd_utils/base/view/bottom_nav_bar_item.dart';
import 'package:gtd_utils/helpers/extension/image_extension.dart';

final List<BottomNavBarItem> tabs = [
  BottomNavBarItem(
    icon: const ColorFiltered(
        colorFilter: ColorFilter.mode(Colors.black54, BlendMode.srcIn), child: Icon(Icons.home_sharp, size: 24)),
    activeIcon: const ColorFiltered(
        colorFilter: ColorFilter.mode(Colors.orangeAccent, BlendMode.srcIn), child: Icon(Icons.home_sharp, size: 24)),
    label: 'Home',
    initialLocation: HomePageTab.home.location,
  ),
  BottomNavBarItem(
    icon: ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
        child: GtdImage.svgFromAsset(assetPath: "assets/image/bottom-course.svg", width: 24)),
    activeIcon: ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.orangeAccent, BlendMode.srcIn),
        child: GtdImage.svgFromAsset(assetPath: "assets/image/bottom-course.svg", width: 24)),
    label: 'Courses',
    initialLocation: HomePageTab.course.location,
  ),
  BottomNavBarItem(
    icon: ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
        child: GtdImage.svgFromAsset(assetPath: "assets/image/bottom-mentor.svg", width: 24)),
    activeIcon: ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.orangeAccent, BlendMode.srcIn),
        child: GtdImage.svgFromAsset(assetPath: "assets/image/bottom-mentor.svg", width: 24)),
    label: 'Teachers',
    initialLocation: HomePageTab.mentor.location,
  ),
  BottomNavBarItem(
    icon: ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
        child: GtdImage.svgFromAsset(assetPath: "assets/image/bottom-student.svg", width: 24)),
    activeIcon: ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.orangeAccent, BlendMode.srcIn),
        child: GtdImage.svgFromAsset(assetPath: "assets/image/bottom-student.svg", width: 24)),
    label: 'Student',
    initialLocation: HomePageTab.student.location,
  ),
  BottomNavBarItem(
    icon: const ColorFiltered(
        colorFilter: ColorFilter.mode(Colors.black54, BlendMode.srcIn),
        child: Icon(Icons.account_circle_rounded, size: 24)),
    activeIcon: const ColorFiltered(
        colorFilter: ColorFilter.mode(Colors.orangeAccent, BlendMode.srcIn),
        child: Icon(Icons.account_circle_rounded, size: 24)),
    label: 'Account',
    initialLocation: HomePageTab.account.location,
  ),
];

final List<BottomNavBarItem> usertabs = [
  BottomNavBarItem(
    icon: const ColorFiltered(
        colorFilter: ColorFilter.mode(Colors.black54, BlendMode.srcIn), child: Icon(Icons.home_sharp, size: 24)),
    activeIcon: const ColorFiltered(
        colorFilter: ColorFilter.mode(Colors.orangeAccent, BlendMode.srcIn), child: Icon(Icons.home_sharp, size: 24)),
    label: 'Home',
    initialLocation: HomePageTab.home.location,
  ),
  BottomNavBarItem(
    icon: ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
        child: GtdImage.svgFromAsset(assetPath: "assets/image/bottom-course.svg", width: 24)),
    activeIcon: ColorFiltered(
        colorFilter: const ColorFilter.mode(Colors.orangeAccent, BlendMode.srcIn),
        child: GtdImage.svgFromAsset(assetPath: "assets/image/bottom-course.svg", width: 24)),
    label: 'Courses',
    initialLocation: HomePageTab.course.location,
  ),
  BottomNavBarItem(
    icon: const ColorFiltered(
        colorFilter: ColorFilter.mode(Colors.black54, BlendMode.srcIn),
        child: Icon(Icons.account_circle_rounded, size: 24)),
    activeIcon: const ColorFiltered(
        colorFilter: ColorFilter.mode(Colors.orangeAccent, BlendMode.srcIn),
        child: Icon(Icons.account_circle_rounded, size: 24)),
    label: 'Account',
    initialLocation: HomePageTab.account.location,
  ),
];

const appBlueDeepColor = Color(0xFF005248);
const appBlueLightColor = Color(0xFFCCDCDA);
// const appBlueDeepColor = Colors.blueAccent;
// final appBlueLightColor = Colors.blue.shade50;
const appOrangeLightColor = Color(0xFFFFB057);
const appOrangeDarkColor = Color(0xFFFFB057);
