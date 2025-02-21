import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/providers/textcolor_provider.dart';
import 'package:myapp/providers/userdata_provider.dart';
import 'package:myapp/screens/account_creation_screen/account_creation.dart';
import 'package:myapp/screens/sign_screens/signin_screen.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';
import 'package:myapp/widgets/commonwidget/custom_snakbar.dart';
import 'package:myapp/widgets/commonwidget/gradientBorder.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';

class SignUpScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignUpScreen({super.key});

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
  Timer? _debounce;
  String? _emailError;

  // Function to check email availability
  Future<void> _checkEmailAvailability(String email) async {
    if (email.isEmpty) {
      setState(() {
        _emailError = null; // Reset error if field is empty
      });
      return;
    }

    final Uri apiUrl = Uri.parse(
        'http://172.232.124.96:5056/api/auth/email-availability'); // Replace with your API URL
    final response = await http.post(
      apiUrl,
      body: jsonEncode({'email': email}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      bool isAvailable = jsonDecode(response.body)['available'];
      setState(() {
        _emailError = isAvailable ? null : 'Email is already in use';
      });
    } else {
      setState(() {
        _emailError = 'Error checking email. Try again later.';
      });
    }
  }

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
                controller: widget.emailController,
                onChanged: (value) {
                  if (_debounce?.isActive ?? false) _debounce!.cancel();
                  _debounce = Timer(const Duration(milliseconds: 800), () {
                    _checkEmailAvailability(value);
                  });
                },
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
                  suffixIcon: _emailError == null
                      ? const Icon(Broken.message_2, color: Colors.white)
                      : const Icon(Icons.error, color: Colors.red),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
        if (_emailError != null)
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 10),
            child: Text(
              _emailError!,
              style: const TextStyle(color: Colors.red, fontSize: 14),
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
                controller: widget.passwordController,
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

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
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
            onPressed: () async {
              String email = emailController.text.trim();
              String password = passwordController.text.trim();

              // Validate email
              if (email.isEmpty || !_validateEmail(email)) {
                SlidingSnackbar(
                  context: context,
                  message: "Please enter a valid email address.",
                  isSuccess: false,
                ).show();
                return;
              }

              // Validate password
              if (password.isEmpty || password.length < 6) {
                SlidingSnackbar(
                  context: context,
                  message: "Password must be at least 6 characters long.",
                  isSuccess: false,
                ).show();
                return;
              }

              var userDataProvider =
                  Provider.of<UserDataProvider>(context, listen: false);
              userDataProvider.setEmail(email);
              userDataProvider.setPassword(password);

              final Uri apiUrl = Uri.parse(
                  'http://172.232.124.96:5056/api/auth/email-availability');
              final response = await http.post(
                apiUrl,
                body: jsonEncode({'email': email}),
                headers: {'Content-Type': 'application/json'},
              );

              if (response.statusCode == 200) {
                bool isAvailable = jsonDecode(response.body)['available'];
                if (isAvailable) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AccountCreationScreen(),
                    ),
                  );
                } else {
                  SlidingSnackbar(
                    context: context,
                    message: "Email is already in use.",
                    isSuccess: false,
                  ).show();
                }
              } else {
                SlidingSnackbar(
                  context: context,
                  message: "Error checking email. Try again later.",
                  isSuccess: false,
                ).show();
              }
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
  const GoogleButton({super.key, required this.screenWidth});

  final double screenWidth;

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );

      // Forces the user to select an account
      await googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        SlidingSnackbar(
          context: context,
          message: "Google Sign-In canceled.",
          isSuccess: false,
        ).show();
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final Uri apiUrl =
          Uri.parse('http://172.232.124.96:5056/api/auth/google-auth');

      final response = await http.post(
        apiUrl,
        body: jsonEncode({
          'email': googleUser.email,
          'name': googleUser.displayName,
          'photoUrl': googleUser.photoUrl,
          'idToken': googleAuth.idToken, // Send the ID token for verification
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        SlidingSnackbar(
          context: context,
          message: "Google Sign-In successful!",
          isSuccess: true,
        ).show();

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AccountCreationScreen()),
        );
      } else {
        SlidingSnackbar(
          context: context,
          message: "Google Sign-In failed. Try again.",
          isSuccess: false,
        ).show();
      }
    } catch (error) {
      SlidingSnackbar(
        context: context,
        message: "Error: $error",
        isSuccess: false,
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.9,
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
            onPressed: () => _handleGoogleSignIn(context),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.login, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  "Continue With Google",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
