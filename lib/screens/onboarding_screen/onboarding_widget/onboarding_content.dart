import 'package:flutter/material.dart';
import 'package:myapp/providers/textcolor_provider.dart';
import 'package:provider/provider.dart';

class OnboardingContent extends StatelessWidget {
  final String title;
  final String description;
  // final String imagePath;

  const OnboardingContent({
    super.key,
    required this.title,
    required this.description,
    // required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image.asset(
        //   imagePath,
        //   width: screenWidth * 0.8, // Adjust the size as needed
        //   height: screenHeight * 0.4,
        //   fit: BoxFit.contain,
        // ),
        // const SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w800,
            color: context.watch<ColorProvider>().headingColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        Text(
          description,
          style:  TextStyle(
            fontSize: 16,
            color: context.watch<ColorProvider>().subHeadingColor,
            fontWeight: FontWeight.w400
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
