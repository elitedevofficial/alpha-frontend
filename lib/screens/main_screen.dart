import 'package:flutter/material.dart';
import 'package:myapp/screens/home_screen/home_screen.dart';
import 'package:myapp/screens/identifier_screen/identifier_screen.dart';
import 'package:myapp/screens/library_screen/library_screen.dart';
import 'package:myapp/screens/profile_screen/profile_screen.dart';
import 'package:myapp/screens/search_screen/search_screen.dart';
import 'package:myapp/screens/settings_screens/settings_screen.dart';
import 'package:myapp/widgets/commonwidget/custom_appbar.dart';
import 'package:myapp/widgets/commonwidget/custom_bottombar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  int _currentIndex = 0;
  bool _hideAppBar = false;

  final List<String> _titles = [
    'Home',
    'Search',
    'Library',
    'Identify',
    'Profile',
  ];

  final List<Widget> _screens = [
    HomeScreen(),
    SearchScreen(),
    LibraryScreen(),
    IdentifyScreen(),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
        _hideAppBar = (index == 4); // Hide AppBar for Profile tab
      });
      _navigatorKey.currentState?.pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => _screens[index],
          transitionsBuilder: (_, animation, __, child) {
            const curve = Curves.easeInOut;
            var begin = Offset(_currentIndex > index ? -1.0 : 1.0, 0.0);
            var end = Offset.zero;
            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _hideAppBar
          ? null
          : CustomAppBar(
              title: _titles[_currentIndex] == 'Profile'
                  ? null
                  : _titles[_currentIndex],
              showBackButton: false,
              onSettings: () {
                _navigatorKey.currentState?.push(
                  MaterialPageRoute(
                    builder: (_) => SettingsScreen(
                      onUpdateAppBar: (title) {
                        setState(() {
                          _titles[_currentIndex] = title;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (_) => _screens[_currentIndex],
          );
        },
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
