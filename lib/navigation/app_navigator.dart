import 'package:flutter/material.dart';
import 'package:myapp/screens/home_screen/home_screen.dart';
import 'package:myapp/screens/identifier_screen/identifier_screen.dart';
import 'package:myapp/screens/library_screen/library_screen.dart';
import 'package:myapp/screens/profile_screen/profile_screen.dart';
import 'package:myapp/screens/search_screen/search_screen.dart';

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
