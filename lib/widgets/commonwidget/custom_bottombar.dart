import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  CustomBottomBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home,color: Colors.blue,), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search,color: Colors.blue,), label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.library_music,color: Colors.blue,), label: 'Library'),
        BottomNavigationBarItem(icon: Icon(Icons.mic,color: Colors.blue,), label: 'Identify'),
        BottomNavigationBarItem(icon: Icon(Icons.person,color: Colors.blue,), label: 'Profile'),
      ],
    );
  }
}
