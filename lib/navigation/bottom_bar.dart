import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/providers/gradient_provider.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;

  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    final gradientProvider = Provider.of<GradientProvider>(context);
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>(
          (Set<WidgetState> states) {
            if (states.contains(WidgetState.selected)) {
              return TextStyle(
                  color: snowWhite,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'LexendDeca');
            }
            return TextStyle(color: snowWhite);
          },
        ),
      ),
      child: NavigationBar(
        backgroundColor: gradientProvider.tertiaryColor,
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
              size: 25,
              color: snowWhite,
            ),
            selectedIcon: Icon(
              Broken.home_1,
              color: tharBlack,
            ),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(
              Broken.search_normal,
               size: 25,
              color: snowWhite,
            ),
            selectedIcon: Icon(
              Broken.search_normal,
              color: tharBlack,
            ),
            
            label: "Search",
          ),
          NavigationDestination(
            icon: Icon(
              Broken.music_library_2,
               size: 25,
              color: snowWhite,
            ),
            selectedIcon: Icon(
              Broken.music_library_2,
              color: tharBlack,
            ),
            label: "Library",
          ),
          NavigationDestination(
            icon: Icon(
              Broken.music,
               size: 25,
              color: snowWhite,
            ),
            selectedIcon: Icon(
              Broken.music,
              color: tharBlack,
            ),
            label: "Identify",
          ),
          NavigationDestination(
            icon: Icon(
              Broken.profile_2user,
               size: 25,
              color: snowWhite,
            ),
            selectedIcon: Icon(
              Broken.profile_2user,
              color: tharBlack,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
