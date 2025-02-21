import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/providers/textcolor_provider.dart';
import 'package:myapp/providers/userdata_provider.dart';
import 'package:myapp/screens/forget_pass_screen/change_pass_screen.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';
import 'package:myapp/widgets/commonwidget/gradientBorder.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ForgetOtpScreen extends StatefulWidget {
  final VoidCallback onContinue;

  const ForgetOtpScreen({required this.onContinue, super.key});

  @override
  State<ForgetOtpScreen> createState() => _ForgetOtpScreenState();
}

class _ForgetOtpScreenState extends State<ForgetOtpScreen> {
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(4, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Function to handle OTP verification and API call
  Future<void> handleOnContinue() async {
    // Retrieve OTP from controllers
    String otp = _controllers.map((controller) => controller.text).join();

    final userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);

    // Validate OTP length
    if (otp.length == 4) {
      try {
        final userData = userDataProvider.getUserData();

        // Extract fields from userData
        final username = userData['username'];
        final password = userData['password'];
        final email = userData['email'];
        final dob = userData['dob']; // Can remain null
        final profileImage = userData['profile_image']; // Can remain null
        final favLang = userData['selectedLanguages']; // Can remain null
        final ipAddress = userData['ipAddress']; // Can remain null

        // Prepare the request body
        final requestBody = {
          'username': username,
          'password': password,
          'email': email,
          'dob': dob, // Can remain null
          'profile_image': profileImage, // Can remain null
          'fav_lang': favLang, // Can remain null
          'fav_artists': userDataProvider.selectedArtists,
          'ipAddress': ipAddress, // Can remain null
          'otp': otp, // Include OTP here
        };

        final response = await http.post(
          Uri.parse('http://172.232.124.96:5056/api/auth/signup'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 201) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Email Verify Success")),
          );

          // Navigate or call the onContinue callback
          widget.onContinue();
        } else {
          // Show error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to Verify Email")),
          );
        }
      } catch (error) {
        // Handle any error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An error occurred: $error")),
        );
      }
    } else {
      // Show validation message if OTP is not valid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid 4-digit OTP')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Enter Your OTP",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: context.watch<ColorProvider>().headingColor,
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: Column(
            children: [
              Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.3,
                decoration: BoxDecoration(
                  gradient: containerGardient,
                  border: GradientBoxBorder(
                    gradient: containerBorderGardient,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        return SizedBox(
                          width: screenWidth * 0.15,
                          child: TextFormField(
                            focusNode: focusNodes[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 1,
                            controller: _controllers[index],
                            decoration: InputDecoration(
                              counterText: "",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  color: Color(0xFF2737CF),
                                  width: 2,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < 3) {
                                FocusScope.of(context)
                                    .requestFocus(focusNodes[index + 1]);
                              } else if (value.isEmpty && index > 0) {
                                FocusScope.of(context)
                                    .requestFocus(focusNodes[index - 1]);
                              }
                            },
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Container(
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChangePassScreen()),
                                );
                              }, // Use the handleOnContinue function
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Verify OTP",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(
                                    Broken.arrow_right_2,
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
