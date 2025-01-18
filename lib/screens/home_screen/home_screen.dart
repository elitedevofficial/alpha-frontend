import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
              child: const Text('Go to About Content'),
            ),
          );
  }
}

// =========== TEMP ============

class AboutContent extends StatelessWidget {
  final VoidCallback onBack;

  const AboutContent({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'About Content',
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onBack, // Go back to Home content
          child: const Text('Back to Home'),
        ),
      ],
    );
  }
}
