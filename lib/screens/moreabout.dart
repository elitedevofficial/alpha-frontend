import 'package:flutter/material.dart';

class MoreAboutSettingsScreen extends StatelessWidget {
  final Function(String) onNavigateToSubScreen;

  const MoreAboutSettingsScreen({super.key, required this.onNavigateToSubScreen});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => onNavigateToSubScreen("more_more_about_home"),
        child: Text("Go to More More About Home"),
      ),
    );
  }
}
