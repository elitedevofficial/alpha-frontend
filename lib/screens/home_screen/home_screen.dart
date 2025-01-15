import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showAboutContent = false; // Tracks whether to show the "About" content

  @override
  Widget build(BuildContext context) {
    return _showAboutContent
        ? AboutContent(
            onBack: () {
              setState(() {
                _showAboutContent = false; // Go back to Home content
              });
            },
          )
        : Center(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _showAboutContent = true; // Show the "About" content
                });
              },
              child: Text('Go to About Content'),
            ),
          );
  }
}

// =========== TEMP ============

class AboutContent extends StatelessWidget {
  final VoidCallback onBack;

  AboutContent({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'About Content',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: onBack, // Go back to Home content
          child: Text('Back to Home'),
        ),
      ],
    );
  }
}
