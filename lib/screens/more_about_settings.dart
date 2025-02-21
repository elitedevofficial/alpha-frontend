import 'package:flutter/material.dart';

class MoreAboutSettingsScreen extends StatelessWidget {
  final Function(String) onNavigate;

  const MoreAboutSettingsScreen({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("More About Settings")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => onNavigate("more_more_about_settings"),
          child: const Text("More More About Settings"),
        ),
      ),
    );
  }
}
