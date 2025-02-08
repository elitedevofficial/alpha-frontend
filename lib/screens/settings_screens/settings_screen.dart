import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final Function(String) onNavigateToSubScreen;

  const SettingsScreen({super.key, required this.onNavigateToSubScreen});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => onNavigateToSubScreen("more_about_search"),
        child: Text("Go to More About Search"),
      ),
    );
  }
}