import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gtd_utils/base/view/bottom_nav_bar_item.dart';

class BottomTabbarNavigation extends StatefulWidget {
  const BottomTabbarNavigation(
      {super.key,
      required this.child,
      required this.location,
      required this.tabs});
  final String location;
  final Widget child;
  final List<BottomNavBarItem> tabs;

  @override
  State<BottomTabbarNavigation> createState() => _BottomTabbarNavigationState();
}

class _BottomTabbarNavigationState extends State<BottomTabbarNavigation> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.labelMedium ??
        const TextStyle(fontFamily: 'Inter');
    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: true,
        child: widget.child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedLabelStyle: textStyle,
        unselectedLabelStyle: textStyle,
        selectedItemColor: Colors.green,
        selectedFontSize: 10,
        unselectedFontSize: 10.0,
        unselectedItemColor: Colors.black54,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          selectTab(context, index);
        },
        currentIndex: currentIndexWhenLoadView(),
        items: widget.tabs,
      ),
    );
  }

  void selectTab(BuildContext context, int index) {
    if (index == currentIndex) return;
    GoRouter router = GoRouter.of(context);
    String location = widget.tabs[index].initialLocation;

    setState(() {
      currentIndex = index;
    });
    //context.push(location);
    router.go(location);
  }

  int currentIndexWhenLoadView() {
    List<String> locations = widget.tabs.map((e) => e.initialLocation).toList();
    int currIndex = locations.indexOf(widget.location);
    return currIndex;
  }
}

// final List<BottomNavBarItem> tabs = [
//   BottomNavBarItem(
//     icon: SvgPicture.asset("assets/icons/home.svg", width: 24),
//     activeIcon: SvgPicture.asset("assets/icons/home.svg", width: 24),
//     label: 'Home',
//     initialLocation: '/',
//   ),
//   BottomNavBarItem(
//     icon: SvgPicture.asset("assets/icons/list-booking.svg", width: 24),
//     activeIcon: SvgPicture.asset("assets/icons/list-booking.svg", width: 24),
//     label: 'My Booking',
//     initialLocation: '/mybooking',
//   ),
//   BottomNavBarItem(
//     icon: SvgPicture.asset("assets/icons/promotion.svg", width: 24),
//     activeIcon: SvgPicture.asset("assets/icons/promotion.svg", width: 24),
//     label: 'Promotions',
//     initialLocation: '/promotions',
//   ),
//   BottomNavBarItem(
//     icon: SvgPicture.asset("assets/icons/account.svg", width: 24),
//     activeIcon: SvgPicture.asset("assets/icons/account.svg", width: 24),
//     label: 'Account',
//     initialLocation: '/account',
//   ),
// ];
