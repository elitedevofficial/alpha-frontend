import 'package:flutter/material.dart';

class MoreMoreAboutSettingsScreen extends StatelessWidget {
  const MoreMoreAboutSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "More More About Settings",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text("This is the deepest sub-screen."),
          ],
        ),
      ),
    );
  }
}
