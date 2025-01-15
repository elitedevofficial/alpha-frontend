import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/providers/gradient_provider.dart';
import 'package:myapp/providers/textcolor_provider.dart';
import 'package:myapp/screens/account_creation_screen/account_screens/account_screen.dart';
import 'package:myapp/screens/account_creation_screen/account_screens/age_screen.dart';
import 'package:myapp/screens/account_creation_screen/account_screens/artist_screen.dart';
import 'package:myapp/screens/account_creation_screen/account_screens/gender_screen.dart';
import 'package:myapp/screens/account_creation_screen/account_screens/language_screen.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';
import 'package:myapp/widgets/commonwidget/gradientBorder.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AccountCreationScreen extends StatefulWidget {
  const AccountCreationScreen({super.key});

  @override
  _AccountCreationScreenState createState() => _AccountCreationScreenState();
}

class _AccountCreationScreenState extends State<AccountCreationScreen> {
  final PageController _pageController = PageController();
  int _currentStep = 1;

  final List<String> _screenNames = [
    "Age",
    "Gender",
    "Name",
    "Language",
    "Artist"
  ];

  void _goToNextPage() {
    if (_currentStep < _screenNames.length) {
      setState(() {
        _currentStep++;
      });
      _pageController.animateToPage(
        _currentStep - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _goToPreviousPage() {
    if (_currentStep > 1) {
      setState(() {
        _currentStep--;
      });
      _pageController.animateToPage(
        _currentStep - 1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = Provider.of<GradientProvider>(context).colors;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: const [0.0, 0.44, 1.0],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _currentStep > 1
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: GestureDetector(
                                onTap: _goToPreviousPage,
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    gradient: containerGardient,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: GradientBoxBorder(
                                      gradient: containerBorderGardient,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: const Icon(Broken.arrow_left_2,
                                      color: Colors.white, size: 20),
                                ),
                              ))
                          : const SizedBox(
                              height: 35,
                            ),
                      const Spacer(),
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: _screenNames.length,
                        effect: ExpandingDotsEffect(
                          activeDotColor: context.watch<ColorProvider>().headingColor,
                          dotColor: Colors.grey.withOpacity(0.5),
                          dotHeight: 8.0,
                          dotWidth: 8.0,
                          spacing: 4.0,
                          expansionFactor: 4,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: PageView(
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        AgeSelectorScreen(onContinue: _goToNextPage),
                        GenderSelectorScreen(onContinue: _goToNextPage),
                        AccountScreen(onContinue: _goToNextPage),
                        LanguageScreen(onContinue: _goToNextPage),
                        ArtistScreen(onContinue: _goToNextPage),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
