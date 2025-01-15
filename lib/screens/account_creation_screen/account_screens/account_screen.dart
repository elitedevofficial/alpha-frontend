import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/providers/textcolor_provider.dart';
import 'package:myapp/widgets/commonwidget/acount_creation_button.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';
import 'package:myapp/widgets/commonwidget/custom_snakbar.dart';
import 'package:myapp/widgets/commonwidget/gradientBorder.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  final VoidCallback onContinue;
  const AccountScreen({required this.onContinue, super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final TextEditingController _usernameController =
      TextEditingController(text: "UserName");
  bool _isTermsAccepted = false;
  bool _isPrivacyAccepted = false;

  final BoxDecoration customBoxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(5),
    gradient: containerGardient,
    border: GradientBoxBorder(
      gradient: containerBorderGardient,
      width: 1.5,
    ),
  );

  void handleAccountContinue() {
    if (!_isTermsAccepted || !_isPrivacyAccepted) {
      _showSnackbar(
        context: context,
        message: "Please agree to the terms and privacy policy.",
        isSuccess: false,
      );
      return;
    }
    print("Username: ${_usernameController.text}");
    print("Terms Accepted: $_isTermsAccepted");
    print("Privacy Accepted: $_isPrivacyAccepted");
    widget.onContinue();
  }

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
        UsernameWidget(usernameController: _usernameController),
        const SizedBox(
          height: 20,
        ),
       const ConditionWidget(),
        const SizedBox(
          height: 15,
        ),
        // ================ TERM AND CONDITION ==================
        Row(
          children: [
            Text(
              "Agree to terms and conditions",
              style: TextStyle(
                color: context
                    .watch<ColorProvider>()
                    .headingColor
                    .withOpacity(0.8),
                fontSize: 16,
                fontFamily: 'LexendDeca',
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isTermsAccepted = !_isTermsAccepted;
                });
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: customBoxDecoration,
                child: _isTermsAccepted
                    ? const Center(
                        child: Icon(
                          Broken.tick_circle,
                          color: Colors.white,
                          size: 18,
                        ),
                      )
                    : const SizedBox(),
              ),
            ),
          ],
        ),

        const SizedBox(
          height: 15,
        ),
        // ================ PRIVACY POLICY ==================
        Row(
          children: [
            Text(
              "Agree to privacy policy",
              style: TextStyle(
                color: context
                    .watch<ColorProvider>()
                    .headingColor
                    .withOpacity(0.8),
                fontSize: 16,
                fontFamily: 'LexendDeca',
                fontWeight: FontWeight.w400,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isPrivacyAccepted = !_isPrivacyAccepted;
                });
              },
              child: Container(
                width: 24,
                height: 24,
                decoration: customBoxDecoration,
                child: _isPrivacyAccepted
                    ? const Center(
                        child: Icon(
                          Broken.tick_circle,
                          color: Colors.white,
                          size: 18,
                        ),
                      )
                    : const SizedBox(),
              ),
            ),
          ],
        ),
       const Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: AccountCreationButton(
            text: "Continue",
            onPressed: handleAccountContinue,
            buttonGradient: buttonGardient,
            borderGradient: buttonBorderGardient,
            icon: Broken.arrow_right_2,
          ),
        ),
      ],
    );
  }
}

class UsernameWidget extends StatelessWidget {
  const UsernameWidget({
    super.key,
    required TextEditingController usernameController,
  }) : _usernameController = usernameController;

  final TextEditingController _usernameController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What is your name?",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: context.watch<ColorProvider>().headingColor,
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
                controller: _usernameController,
                decoration: InputDecoration(
                  hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16,
                    fontFamily: 'LexendDeca',
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  suffixIcon: const Icon(
                    Broken.message_edit,
                    color: Colors.white,
                  ),
                ),
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          '* This appears on your profile',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: context.watch<ColorProvider>().subHeadingColor,
            letterSpacing: .5,
          ),
        )
      ],
    );
  }
}

class ConditionWidget extends StatelessWidget {
  const ConditionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Agree the condition",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: context.watch<ColorProvider>().headingColor,
          ),
        ),
      ],
    );
  }
}
