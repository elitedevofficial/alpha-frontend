import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/navigation/app_bar.dart';
import 'package:myapp/navigation/bottom_bar.dart';
import 'package:myapp/navigation/drawer_menu.dart';
import 'package:myapp/providers/slide_gesture_provider.dart';
import 'package:myapp/screens/home_screen/home_screen.dart';
import 'package:myapp/screens/identifier_screen/identifier_screen.dart';
import 'package:myapp/screens/library_screen/library_screen.dart';
import 'package:myapp/screens/profile_screen/profile_screen.dart';
import 'package:myapp/screens/search_screen/search_screen.dart';
import 'package:myapp/screens/settings_screens/settings_screen.dart';
import 'package:myapp/screens/settings_screens/settings_subscreen/customization_screen.dart';
import 'package:myapp/widgets/homewidget/home_catagory_sub.dart';
import 'package:provider/provider.dart';
import 'package:myapp/providers/gradient_provider.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  String? _currentSidebarScreen;

  final advanceddrawerController = AdvancedDrawerController();

  void _onBottomNavSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _currentSidebarScreen = null;
    });
  }

  void _onSidebarScreenSelected(String screen) {
    setState(() {
      _currentSidebarScreen = screen;
    });
  }

  Future<bool> _onWillPop() async {
  List<String> settingsSubScreens = ["settings_customization"];
  List<String> categorySubScreens = ["recent_listened", "new_releases", "popular_albums", "best_of_artist"];

  setState(() {
    if (_currentSidebarScreen != null) {
      if (settingsSubScreens.contains(_currentSidebarScreen)) {
        _currentSidebarScreen = "settings"; // Go back to main Settings screen
      } else if (categorySubScreens.contains(_currentSidebarScreen)) {
        _currentSidebarScreen = null; // Go back to Home screen
      } else {
        _currentSidebarScreen = null; // Go back to BottomBar screen
      }
    }
  });

  return false; // Prevent default back behavior
}

  // Future<bool> _onWillPop() async {
  //   // List of all Settings sub-screens
  //   List<String> settingsSubScreens = [
  //     "settings_customization",
  //   ];

  //   setState(() {
  //     if (_currentSidebarScreen != null) {
  //       if (settingsSubScreens.contains(_currentSidebarScreen)) {
  //         _currentSidebarScreen = "settings"; // Go back to main Settings screen
  //       } else {
  //         _currentSidebarScreen = null; // Go back to BottomBar screen
  //       }
  //     }
  //   });

  //   return false; // Prevent default back behavior
  // }

  @override
  Widget build(BuildContext context) {
        final gradientProvider = Provider.of<GradientProvider>(context);

    final slideGestureProvider = Provider.of<SlideGestureProvider>(context);
    return AdvancedDrawer(
      backdropColor: gradientProvider.secondaryColor, 
      controller: advanceddrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 500),
      animateChildDecoration: true,
      openScale: 1,
      openRatio: 0.50,
      
     disabledGestures: !slideGestureProvider.isSlideEnabled,
      drawer: DrawerMenu(
        onScreenSelected: _onSidebarScreenSelected,
        advanceddrawerController: advanceddrawerController,
      ),
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          backgroundColor: Colors.red,
          extendBodyBehindAppBar: true,
          
          appBar: CustomAppBar(
            title: _getAppBarTitle(),
            currentIndex: _selectedIndex,
            onProfileTap: () => _onBottomNavSelected(4),
            actions: _getAppBarActions(),
            drawerControl: _drawerControl,
          ),
          body: _currentSidebarScreen == null
              ? AppNavigator(currentIndex: _selectedIndex)
              : _getSidebarScreen(),
          bottomNavigationBar: BottomNavBar(
            currentIndex: _selectedIndex,
            onTabSelected: _onBottomNavSelected,
          ),
        ),
      ),
    );
  }

  String _getAppBarTitle() {
    if (_currentSidebarScreen != null) {
      switch (_currentSidebarScreen) {
        case "settings":
          return "Settings";
        case "settings_customization":
          return "Customization";
        case "settings_advanced":
          return "Advanced Settings";
        case "listening_history":
          return "Listening History";
        case "whats_new":
          return "What's New";
        case "sound_capsule":
          return "Sound Capsule";
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
    switch (_selectedIndex) {
      case 2:
        return [
          IconButton(icon: const Icon(Broken.search_normal_1), onPressed: () {})
        ];
      case 3:
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
      return SettingsScreen(onNavigateToSubScreen: _onSidebarScreenSelected);
    case "settings_customization":
      return const CustomizationScreen();
    case "recent_listened":
      return const CategoryDetailScreen(categoryTitle: "Recent Listened");
    case "new_releases":
      return const CategoryDetailScreen(categoryTitle: "New Releases");
    case "popular_albums":
      return const CategoryDetailScreen(categoryTitle: "Popular Albums");
    case "best_of_artist":
      return const CategoryDetailScreen(categoryTitle: "Best Of Artist");
    default:
      return const Center(child: Text("Unknown Screen"));
  }
}

  // Widget _getSidebarScreen() {
  //   switch (_currentSidebarScreen) {
  //     case "settings":
  //       return SettingsScreen(onNavigateToSubScreen: _onSidebarScreenSelected);
  //     case "settings_customization":
  //       return const CustomizationScreen();
  //     case "settings_advanced":
  //       return const CustomizationScreen();
  //     default:
  //       return const Center(child: Text("Unknown Screen"));
  //   }
  // }

  void _drawerControl() {
    advanceddrawerController.showDrawer();
  }
}


class AppNavigator extends StatelessWidget {
  final int currentIndex;

  const AppNavigator({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: currentIndex,
      children: const [
        HomeScreen(),
        SearchScreen(),
        LibraryScreen(),
        IdentifyScreen(),
        ProfileScreen(),
      ],
    );
  }
}