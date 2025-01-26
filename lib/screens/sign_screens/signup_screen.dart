import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/providers/gradient_provider.dart';
import 'package:myapp/providers/textcolor_provider.dart';
import 'package:myapp/providers/userdata_provider.dart';
import 'package:myapp/screens/account_creation_screen/account_creation.dart';
import 'package:myapp/screens/sign_screens/signin_screen.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';
import 'package:myapp/widgets/commonwidget/gradientBorder.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gradientColors = Provider.of<GradientProvider>(context).colors;
    double screenWidth = MediaQuery.of(context).size.width;

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
                        "SIGN UP",
                        style: TextStyle(
                          fontSize: 30,
                          color: context.watch<ColorProvider>().headingColor,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'LexendDeca',
                        ),
                      ),
                      Text(
                        "Ready To Start Your Journey? Let's Create Something Amazing Together",
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
                AuthForm(
                  emailController: emailController,
                  passwordController: passwordController,
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: AuthButton(
                    screenWidth: screenWidth,
                    emailController: emailController,
                    passwordController: passwordController,
                  ),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "OR",
                        style: TextStyle(
                          color: context.watch<ColorProvider>().headingColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              context
                                  .watch<ColorProvider>()
                                  .headingColor
                                  .withOpacity(0.8),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: GoogleButton(screenWidth: screenWidth),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SigninScreen()),
                      );
                    },
                    child: Text(
                      'Have an account? Login',
                      style: TextStyle(
                        fontSize: 15,
                        color: context.watch<ColorProvider>().subHeadingColor,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'LexendDeca',
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// <==================== AUTH FORM ===============================>

class AuthForm extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const AuthForm({
    super.key,
    required this.emailController,
    required this.passwordController,
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
        // Email Field
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
                controller: widget.emailController, // Use the email controller
                decoration: InputDecoration(
                  hintText: 'Enter Email',
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                    fontFamily: 'LexendDeca',
                  ),
                  border: InputBorder.none,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  suffixIcon: const Icon(
                    Broken.message_2,
                    color: Colors.white,
                  ),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),

        // Password Field
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
                controller:
                    widget.passwordController, // Use the password controller
                obscureText: _obscureText,
                decoration: InputDecoration(
                  hintText: 'Enter Password',
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

class AuthButton extends StatelessWidget {
  final double screenWidth;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const AuthButton({
    super.key,
    required this.screenWidth,
    required this.emailController,
    required this.passwordController,
  });

  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

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
              String email = emailController.text.trim();
              String password = passwordController.text.trim();

              if (email.isEmpty || !_validateEmail(email)) {
                ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(
                    content: const Text("Please enter a valid email address."),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              if (password.isEmpty || password.length < 6) {
                ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(
                    content: const Text(
                        "Password must be at least 6 characters long."),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }

              var userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
              userDataProvider.setEmail(email);
              userDataProvider.setPassword(password);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountCreationScreen(),
                ),
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
                  "Continue",
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


// <==================== GOOGLE BUTTON ===============================>

class GoogleButton extends StatelessWidget {
  const GoogleButton({
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
        borderRadius: BorderRadius.circular(10),
        gradient: containerGardient,
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: GradientBoxBorder(
              gradient: containerBorderGardient,
              width: 1.5,
            ),
          ),
          child: TextButton(
            onPressed: () {
              // onPressed functionality here
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
                  "Continue With Google",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
