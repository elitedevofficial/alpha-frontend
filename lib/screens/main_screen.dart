import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/navigation/app_bar.dart';
import 'package:myapp/navigation/app_navigator.dart';
import 'package:myapp/navigation/bottom_bar.dart';
import 'package:myapp/navigation/drawer_menu.dart';
import 'package:myapp/screens/moreabout.dart';
import 'package:myapp/screens/settings_screens/settings_screen.dart';
import 'dart:io';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  String? _currentSidebarScreen;
  String? _currentSubScreen;

  void _onBottomNavSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _currentSidebarScreen = null;
      _currentSubScreen = null; // Reset sub-screen when switching tabs
    });
  }

  void _onSidebarScreenSelected(String screen) {
    setState(() {
      _currentSidebarScreen = screen;
      _currentSubScreen =
          null; // Reset sub-screen when switching Sidebar screen
    });
    // Navigator.of(context).pop(); // Close the drawer
  }

  void _navigateToSubScreen(String screen) {
    setState(() {
      _currentSubScreen = screen;
    });
  }

  Future<bool> _onWillPop() async {
    if (_currentSubScreen != null) {
      setState(() {
        _currentSubScreen = null; // Go back to previous screen inside Sidebar
      });
      return false;
    }
    if (_currentSidebarScreen != null) {
      setState(() {
        _currentSidebarScreen = null;
      });
      return false; // Go back to BottomBar screen
    }
    if (_selectedIndex == 0) {
      exit(0); // Exit app if on Home
    }
    setState(() {
      _selectedIndex = 0;
    });
    return false; // Prevent default back navigation
  }

  final advanceddrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
        controller: advanceddrawerController,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 500),
        animateChildDecoration: true,
        openScale: 1,
        openRatio: 0.50,
        drawer: DrawerMenu(
          onScreenSelected: _onSidebarScreenSelected,
          advanceddrawerController: advanceddrawerController,
        ),
        child: WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
            appBar: CustomAppBar(
              title: _getAppBarTitle(),
              currentIndex: _selectedIndex,
              onProfileTap: () => _onBottomNavSelected(4),
              actions: _getAppBarActions(),
              drawerControl: drawerControl,
            ),
            // drawer: DrawerMenu(onScreenSelected: _onSidebarScreenSelected),
            body: _currentSidebarScreen == null
                ? AppNavigator(currentIndex: _selectedIndex)
                : _getSidebarScreen(),
            bottomNavigationBar: BottomNavBar(
              currentIndex: _selectedIndex,
              onTabSelected: _onBottomNavSelected,
            ),
          ),
        ));
  }

  String _getAppBarTitle() {
    if (_currentSidebarScreen != null) {
      switch (_currentSidebarScreen) {
        case "settings":
          return _currentSubScreen ?? "Settings";
        case "listening_history":
          return _currentSubScreen ?? "Listening History";
        case "whats_new":
          return _currentSubScreen ?? "What's New";
        case "sound_capsule":
          return _currentSubScreen ?? "Sound Capsule";
      }
    }
    switch (_selectedIndex) {
      case 0:
        return "";
      case 1:
        return "Search";
      case 2:
        return "Library";
      case 3:
        return "Identify Song";
      case 4:
        return "Profile";
      default:
        return "Your App";
    }
  }

  List<Widget> _getAppBarActions() {
    // if (_selectedIndex == 4) return []; // Hide actions on Profile screen

    switch (_selectedIndex) {
      case 1: // Search screen: add a settings icon
        return [];
      case 2: // Library screen: add a favorite icon
        return [
          IconButton(icon: const Icon(Broken.search_normal_1), onPressed: () {})
        ];
      case 3: // Identify screen: add a refresh icon
        return [IconButton(icon: const Icon(Broken.clock), onPressed: () {})];
      case 4:
        return [IconButton(icon: const Icon(Broken.edit), onPressed: () {})];
      default:
        return [];
    }
  }

  Widget _getSidebarScreen() {
    switch (_currentSidebarScreen) {
      case "settings":
        return _currentSubScreen == null
            ? SettingsScreen(onNavigateToSubScreen: _navigateToSubScreen)
            : _getSubScreen("settings", _currentSubScreen!);
      // case "listening_history":
      //   return _currentSubScreen == null
      //       ? ListeningHistoryScreen(onNavigateToSubScreen: _navigateToSubScreen)
      //       : _getSubScreen("listening_history", _currentSubScreen!);
      // case "whats_new":
      //   return _currentSubScreen == null
      //       ? WhatsNewScreen(onNavigateToSubScreen: _navigateToSubScreen)
      //       : _getSubScreen("whats_new", _currentSubScreen!);
      // case "sound_capsule":
      //   return _currentSubScreen == null
      //       ? SoundCapsuleScreen(onNavigateToSubScreen: _navigateToSubScreen)
      //       : _getSubScreen("sound_capsule", _currentSubScreen!);
      default:
        return const Center(child: Text("Unknown Screen"));
    }
  }

  Widget _getSubScreen(String baseScreen, String subScreen) {
    if (baseScreen == "settings") {
      if (subScreen == "more_about_settings") {
        return MoreAboutSettingsScreen(
            onNavigateToSubScreen: _navigateToSubScreen);
      }
    }
    // } else if (baseScreen == "listening_history") {
    //   if (subScreen == "more_about_listening_history") {
    //     return MoreAboutListeningHistoryScreen(onNavigateToSubScreen: _navigateToSubScreen);
    //   }
    // } else if (baseScreen == "whats_new") {
    //   if (subScreen == "more_about_whats_new") {
    //     return MoreAboutWhatsNewScreen(onNavigateToSubScreen: _navigateToSubScreen);
    //   }
    // } else if (baseScreen == "sound_capsule") {
    //   if (subScreen == "more_about_sound_capsule") {
    //     return MoreAboutSoundCapsuleScreen(onNavigateToSubScreen: _navigateToSubScreen);
    //   }
    // }
    return const Center(child: Text("Unknown Subscreen"));
  }

  void drawerControl() {
    advanceddrawerController.showDrawer();
  }
}
