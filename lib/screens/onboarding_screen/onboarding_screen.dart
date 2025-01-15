import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/providers/gradient_provider.dart';
import 'package:myapp/screens/onboarding_screen/onboarding_widget/onboarding_content.dart';
import 'package:myapp/screens/sign_screens/signin_screen.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onSkipPressed() {
    if (_currentPage < 2) {
      _pageController.jumpToPage(2);
    } else {
      _navigateToSignIn();
    }
  }

  void _onContinuePressed() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToSignIn();
    }
  }

  void _navigateToSignIn() {
    Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SigninScreen()));
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
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Container(
                    width: 100,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: buttonGardient,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: buttonBorderGardient,
                        ),
                        child: TextButton(
                          onPressed: _onSkipPressed,
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Skip',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Broken.arrow_right_3,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                 
                  Expanded(
                    flex: 8,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      physics: const NeverScrollableScrollPhysics(),
                      children: const [
                        OnboardingContent(
                          title: 'Endless Music, Tailored for You',
                          description:
                              'Explore a world of songs, albums, and playlists curated just for your vibe. Find your next favorite track in seconds.',
                          // imagePath: 'assets/images/onboarding1.png',
                        ),
                        OnboardingContent(
                          title: 'Music That Understands You',
                          description:
                              'Create your custom playlists, follow artists you love, and get recommendations that feel like they were made just for you.',
                          // imagePath: 'assets/images/onboarding2.png',
                        ),
                        OnboardingContent(
                          title: 'Play Anywhere, Anytime',
                          description:
                              'Enjoy your favorite tracks offline or online, with smooth transitions between devices for a non-stop music experience.',
                          // imagePath: 'assets/images/onboarding3.png',
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  // Continue button
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          gradient: buttonGardient,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              gradient: buttonBorderGardient,
                            ),
                            child: TextButton(
                              onPressed: _onContinuePressed,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Continue',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(
                                    Broken.arrow_right_3,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
