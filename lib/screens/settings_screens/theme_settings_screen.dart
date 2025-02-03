import 'package:flutter/material.dart';
import 'package:myapp/providers/gradient_provider.dart';
import 'package:provider/provider.dart';

class ThemeSettingsScreen extends StatefulWidget {
  const ThemeSettingsScreen({super.key});

  @override
  _ThemeSettingsScreenState createState() => _ThemeSettingsScreenState();
}

class _ThemeSettingsScreenState extends State<ThemeSettingsScreen> {
  List<List<Color>> predefinedGradients = [
    [Colors.blue, Colors.lightBlue, Colors.cyan],
    [Colors.red, Colors.orange, Colors.yellow],
    [Colors.green, Colors.teal, Colors.lightGreen],
    [Colors.purple, Colors.pink, Colors.deepPurple],
    [Colors.brown, Colors.grey, Colors.blueGrey],
  ];

  List<Color> selectedColors = [];

  @override
  void initState() {
    super.initState();
    final gradientProvider = Provider.of<GradientProvider>(context, listen: false);
    selectedColors = List.from(gradientProvider.colors);
  }

  // Open predefined gradient picker dialog
  void pickGradient() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pick Gradient'),
          content: Wrap(
            spacing: 10,
            children: predefinedGradients.map((gradient) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColors = List.from(gradient);
                  });
                  Navigator.of(context).pop();
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradient,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                ),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );
  }

  // Save colors to GradientProvider
  void saveColors() {
    final gradientProvider = Provider.of<GradientProvider>(context, listen: false);
    gradientProvider.updateColors(selectedColors);
    Navigator.pop(context);
  }

  // Reset to default colors
  void resetToDefaultColors() {
    final gradientProvider = Provider.of<GradientProvider>(context, listen: false);
    gradientProvider.resetColors();
    setState(() {
      selectedColors = List.from(gradientProvider.colors);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Gradient Colors')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Gradient selection button
            ElevatedButton(
              onPressed: pickGradient,
              child: const Text('Select Gradient'),
            ),
            const SizedBox(height: 20),
            // Save button
            ElevatedButton(
              onPressed: saveColors,
              child: const Text('Save Colors'),
            ),
            const SizedBox(height: 20),
            // Reset button
            ElevatedButton(
              onPressed: resetToDefaultColors,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Optional: Change the button color
              ),
              child: const Text('Reset to Default'),
            ),
          ],
        ),
      ),
    );
  }
}
