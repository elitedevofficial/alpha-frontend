import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:myapp/providers/textcolor_provider.dart';
import 'package:provider/provider.dart';

class TextEtting extends StatefulWidget {
  const TextEtting({super.key});

  @override
  _TextEttingState createState() => _TextEttingState();
}

class _TextEttingState extends State<TextEtting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Column(
        children: [
          ListTile(
            title: const Text("Heading Color"),
            trailing: CircleAvatar(backgroundColor: context.watch<ColorProvider>().headingColor),
            onTap: () async {
              Color pickedColor = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ColorPickerDialog(initialColor: context.read<ColorProvider>().headingColor);
                },
              );
              context.read<ColorProvider>().setHeadingColor(pickedColor);
                        },
          ),
          ListTile(
            title: const Text("Sub Heading Color"),
            trailing: CircleAvatar(backgroundColor: context.watch<ColorProvider>().subHeadingColor),
            onTap: () async {
              Color pickedColor = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ColorPickerDialog(initialColor: context.read<ColorProvider>().subHeadingColor);
                },
              );
              context.read<ColorProvider>().setSubHeadingColor(pickedColor);
                        },
          ),
          ElevatedButton(
            onPressed: () {
              context.read<ColorProvider>().resetToDefault();
            },
            child: const Text("Reset to Default"),
          ),
        ],
      ),
    );
  }
}

class ColorPickerDialog extends StatelessWidget {
  final Color initialColor;

  const ColorPickerDialog({super.key, required this.initialColor});

  @override
  Widget build(BuildContext context) {
    Color selectedColor = initialColor;

    return AlertDialog(
      title: const Text("Pick a Color"),
      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: selectedColor,
          onColorChanged: (Color color) {
            selectedColor = color;
          },
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text("Select"),
          onPressed: () {
            Navigator.of(context).pop(selectedColor);
          },
        ),
      ],
    );
  }
}
