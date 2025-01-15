import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/providers/language_provider.dart';
import 'package:myapp/providers/textcolor_provider.dart';
import 'package:myapp/widgets/commonwidget/acount_creation_button.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';
import 'package:myapp/widgets/commonwidget/custom_snakbar.dart';
import 'package:myapp/widgets/commonwidget/gradientBorder.dart';
import 'package:provider/provider.dart';

class LanguageScreen extends StatelessWidget {
  final VoidCallback onContinue;

  const LanguageScreen({required this.onContinue, super.key});

  void handleContinue(BuildContext context) {
    final provider = context.read<LanguageProvider>();
    final selectedLanguages = provider.selectedLanguages;

    if (selectedLanguages.length < 3) {
      SlidingSnackbar(
        context: context,
        message: "Please select at least 3 languages.",
        isSuccess: false,
      ).show();
    } else if (selectedLanguages.length > 7) {
      SlidingSnackbar(
        context: context,
        message: "You can select a maximum of 7 languages.",
        isSuccess: false,
      ).show();
    } else {
      print("Selected Languages: ${selectedLanguages.join(', ')}");
      onContinue();
    }
  }

  Widget languageButton(BuildContext context, String label) {
    final provider = Provider.of<LanguageProvider>(context);
    bool isSelected = provider.selectedLanguages.contains(label);

    return GestureDetector(
      onTap: () => provider.selectLanguage(label),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          gradient: isSelected ? activeContainerGardient : containerGardient,
          borderRadius: BorderRadius.circular(10),
          border: GradientBoxBorder(
            gradient: activeContainerBorderGardient,
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonWidth = (screenWidth / 2) - 40;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select your language",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: context.watch<ColorProvider>().headingColor,
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              SizedBox(
                width: buttonWidth,
                child: languageButton(context, "Malayalam"),
              ),
              SizedBox(
                width: buttonWidth,
                child: languageButton(context, "Tamil"),
              ),
              SizedBox(
                width: buttonWidth,
                child: languageButton(context, "Hindi"),
              ),
              SizedBox(
                width: buttonWidth,
                child: languageButton(context, "Punjabi"),
              ),
              SizedBox(
                width: buttonWidth,
                child: languageButton(context, "Telugu"),
              ),
              SizedBox(
                width: buttonWidth,
                child: languageButton(context, "Marathi"),
              ),
              SizedBox(
                width: buttonWidth,
                child: languageButton(context, "Bengali"),
              ),
              SizedBox(
                width: buttonWidth,
                child: languageButton(context, "International"),
              ),
              SizedBox(
                width: buttonWidth,
                child: languageButton(context, "Gujarati"),
              ),
              SizedBox(
                width: buttonWidth,
                child: languageButton(context, "Kannada"),
              ),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: AccountCreationButton(
            text: "Continue",
            onPressed: () => handleContinue(context),
            buttonGradient: buttonGardient,
            borderGradient: buttonBorderGardient,
            icon: Broken.arrow_right_2,
          ),
        ),
      ],
    );
  }
}
