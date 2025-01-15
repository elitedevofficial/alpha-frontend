import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:myapp/providers/gradient_provider.dart';
import 'package:provider/provider.dart';

class ThemeSettingsScreen extends StatefulWidget {
  @override
  _ThemeSettingsScreenState createState() => _ThemeSettingsScreenState();
}

class _ThemeSettingsScreenState extends State<ThemeSettingsScreen> {
  List<Color> selectedColors = [];

  @override
  void initState() {
    super.initState();
    final gradientProvider = Provider.of<GradientProvider>(context, listen: false);
    selectedColors = List.from(gradientProvider.colors);
  }

  // Open color picker dialog
  void pickColor(int index) {
    Color newColor = selectedColors[index];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Pick Color ${index + 1}'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: newColor,
              onColorChanged: (color) {
                setState(() {
                  selectedColors[index] = color;
                });
              },
            ),
          ),
          actions: [
            TextButton(
              child: Text('Done'),
              onPressed: () {
                Navigator.of(context).pop();
              },
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
      appBar: AppBar(title: Text('Change Gradient Colors')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Color selection tiles
            for (int i = 0; i < selectedColors.length; i++)
              ListTile(
                title: Text('Color ${i + 1}'),
                trailing: CircleAvatar(backgroundColor: selectedColors[i]),
                onTap: () => pickColor(i),
              ),
            SizedBox(height: 20),
            // Save button
            ElevatedButton(
              onPressed: saveColors,
              child: Text('Save Colors'),
            ),
            SizedBox(height: 20),
            // Reset button
            ElevatedButton(
              onPressed: resetToDefaultColors,
              child: Text('Reset to Default'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Optional: Change the button color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
