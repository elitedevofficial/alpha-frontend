import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      backgroundColor: Color(0xFF101118),
        animationDuration: const Duration(seconds: 1),
        height: 64.0,
        elevation: 22,
        selectedIndex: currentIndex,
        onDestinationSelected: onTabSelected,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        destinations: [
          NavigationDestination(
              icon: Icon(
                Broken.home_1,
              ),
              label: "HOME"),
          NavigationDestination(
              icon: Icon(
                Broken.search_normal,
              ),
              label: "SEARCH"),
          NavigationDestination(
              icon: Icon(
                Broken.music_library_2,
              ),
              label: "LIBRARY"),
          NavigationDestination(
              icon: Icon(
                Broken.music,
              ),
              label: "IDENTIFY"),
          NavigationDestination(
              icon: Icon(
                Broken.profile_2user,
              ),
              label: "PROFILE"),
        ]);
  }
}
