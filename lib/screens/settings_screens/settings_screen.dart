import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final Function(String) onUpdateAppBar;

  const SettingsScreen({super.key, required this.onUpdateAppBar});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    // Update the AppBar title after the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onUpdateAppBar('Settings');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Settings Screen'));
  }
}
