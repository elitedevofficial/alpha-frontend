import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/providers/textcolor_provider.dart';
import 'package:myapp/widgets/commonwidget/acount_creation_button.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';
import 'package:myapp/widgets/commonwidget/custom_snakbar.dart';
import 'package:myapp/widgets/commonwidget/gradientBorder.dart';
import 'package:provider/provider.dart';
 
class GenderSelectorScreen extends StatefulWidget {
  final VoidCallback onContinue;

  const GenderSelectorScreen({required this.onContinue, super.key});

  @override
  State<GenderSelectorScreen> createState() => _GenderSelectorScreenState();
}

class _GenderSelectorScreenState extends State<GenderSelectorScreen> {
  String? selectedGender;

  final LinearGradient activeGradient = activeContainerGardient;

  final LinearGradient inactiveGradient = containerGardient;

  Widget genderButton(String label, String value) {
    bool isSelected = selectedGender == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            gradient: isSelected ? activeGradient : inactiveGradient,
            borderRadius: BorderRadius.circular(6),
            border: GradientBoxBorder(
              gradient: activeContainerBorderGardient,
              width: 1,
            )),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void handleContinue() {
    if (selectedGender == null) {
      _showSnackbar(
        context: context,
        message: "Please select your gender.",
        isSuccess: false,
      );
    } else {
      print("Selected Gender: $selectedGender");
      widget.onContinue();
    }
  }

  // Your custom snackbar method
  void _showSnackbar({
    required BuildContext context,
    required String message,
    required bool isSuccess,
  }) {
    SlidingSnackbar(
      context: context,
      message: message,
      isSuccess: isSuccess,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What's your gender?",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: context.watch<ColorProvider>().headingColor,
          ),
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                genderButton("Male", "male"),
                const SizedBox(width: 10),
                genderButton("Female", "female"),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                genderButton("Other", "other"),
                const SizedBox(width: 10),
                genderButton("Prefer not to say", "prefer_not_to_say"),
              ],
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: AccountCreationButton(
            text: "Continue",
            onPressed: handleContinue,
            buttonGradient: buttonGardient,
            borderGradient: buttonBorderGardient,
            icon: Broken.arrow_right_2,
          ),
        ),
      ],
    );
  }
}
