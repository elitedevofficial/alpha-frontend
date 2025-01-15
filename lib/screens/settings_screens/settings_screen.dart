import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final Function(String) onUpdateAppBar;

  SettingsScreen({required this.onUpdateAppBar});

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
    return Center(child: Text('Settings Screen'));
  }
}
