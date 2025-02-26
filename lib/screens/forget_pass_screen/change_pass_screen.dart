import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/providers/textcolor_provider.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';
import 'package:myapp/widgets/commonwidget/gradientBorder.dart';
import 'package:provider/provider.dart';

class ForgotChangePass extends StatefulWidget {
  const ForgotChangePass({super.key});

  @override
  State<ForgotChangePass> createState() => _ForgotChangePassState();
}

class _ForgotChangePassState extends State<ForgotChangePass> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    bool _obscureText = true;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(gradient: getAppGradient(context)),
          ),
          Padding(
            padding: const EdgeInsets.all(13),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: Column(
                        children: [
                          Text(
                            "New Password",
                            style: TextStyle(
                              fontSize: 30,
                              color: snowWhite,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'LexendDeca',
                            ),
                          ),
                          Text(
                            "Enter your new password",
                            style: TextStyle(
                              fontSize: 15,
                              color: snowWhite,
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
                              hintText: 'Enter Password',
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.8),
                                fontSize: 16,
                                fontFamily: 'LexendDeca',
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              suffixIcon: Icon(
                                Broken.lock,
                                key: ValueKey<bool>(_obscureText),
                                color: Colors.white,
                              ),
                            ),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
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
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              suffixIcon: Icon(
                                Broken.lock,
                                key: ValueKey<bool>(_obscureText),
                                color: Colors.white,
                              ),
                            ),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Text(
                        'Show Password',
                        style: TextStyle(
                          fontSize: 15,
                          color: context.watch<ColorProvider>().subHeadingColor,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'LexendDeca',
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: screenWidth * 9,
                      height: 44,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: buttonGardient),
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
                                  "Confirm",
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
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
