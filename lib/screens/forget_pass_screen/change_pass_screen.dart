import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/providers/textcolor_provider.dart';
import 'package:myapp/screens/forget_pass_screen/email_verify.dart';
import 'package:myapp/screens/main_screen.dart';
import 'package:myapp/screens/sign_screens/signin_screen.dart';
import 'package:myapp/screens/sign_screens/signup_screen.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';
import 'package:provider/provider.dart';
import '../../widgets/commonwidget/gradientBorder.dart';

class ChangePassScreen extends StatelessWidget {
  const ChangePassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(gradient: getAppGradient(context)),
          ),
          Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Change Password",
                        style: TextStyle(
                          fontSize: 30,
                          color: context.watch<ColorProvider>().headingColor,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'LexendDeca',
                        ),
                      ),
                      Text(
                        "Stronger Password, Stronger You. Let's Make It Happen!",
                        style: TextStyle(
                          fontSize: 15,
                          color: context.watch<ColorProvider>().subHeadingColor,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'LexendDeca',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                const AuthForm(),
                Center(
                  child: AuthButton(screenWidth: screenWidth),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              context
                                  .watch<ColorProvider>()
                                  .headingColor
                                  .withOpacity(0.8), // Middle
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// <==================== AUTH FORM ===============================>

class AuthForm extends StatefulWidget {
  const AuthForm({
    super.key,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: containerGardient,
            border: GradientBoxBorder(
              gradient: containerBorderGardient,
              width: 1.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: TextFormField(
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: 'New Password',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                    fontFamily: 'LexendDeca',
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  suffixIcon: IconButton(
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      child: Icon(
                        _obscureText ? Broken.eye_slash : Broken.eye,
                        key: ValueKey<bool>(_obscureText),
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
        // ==================== PASSWORD FIELD ===============================

        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: containerGardient,
            border: GradientBoxBorder(
              gradient: containerBorderGardient,
              width: 1.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: TextFormField(
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                    fontFamily: 'LexendDeca',
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  suffixIcon: IconButton(
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      },
                      child: Icon(
                        _obscureText ? Broken.eye_slash : Broken.eye,
                        key: ValueKey<bool>(_obscureText),
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// <==================== AUTH BUTTON ===============================>

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 9,
      height: 44,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), gradient: buttonGardient),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: buttonBorderGardient,
          ),
          child: TextButton(
            onPressed: () {
              // onPressed functionality here
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SigninScreen()),
              );
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Change Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
