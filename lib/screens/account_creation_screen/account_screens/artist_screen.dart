import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/providers/textcolor_provider.dart';
import 'package:myapp/providers/userdata_provider.dart';
import 'package:myapp/screens/account_creation_screen/account_screens/artists_data.dart';
import 'package:myapp/widgets/commonwidget/acount_creation_button.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';
import 'package:myapp/widgets/commonwidget/custom_snakbar.dart';
import 'package:myapp/widgets/commonwidget/gradientBorder.dart';
import 'package:provider/provider.dart';

class ArtistScreen extends StatefulWidget {
  final VoidCallback onContinue;

  const ArtistScreen({required this.onContinue, super.key});

  @override
  State<ArtistScreen> createState() => _ArtistScreenState();
}

class _ArtistScreenState extends State<ArtistScreen> {
  late String selectedLanguage;

  @override
  void initState() {
    super.initState();
    final languages = context.read<UserDataProvider>().selectedLanguages;
    selectedLanguage = languages.isNotEmpty ? languages[0] : "Language";
  }

  void selectLanguage(String language) {
    setState(() {
      selectedLanguage = language;
    });
    Navigator.pop(context);
  }

  void showLanguagePopup() {
    final selectedLanguages = context.read<UserDataProvider>().selectedLanguages;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              gradient: containerGardient,
              borderRadius: BorderRadius.circular(10),
              border: GradientBoxBorder(
                gradient: containerBorderGardient,
                width: 1,
              ),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              itemCount: selectedLanguages.length,
              itemBuilder: (context, index) {
                final lang = selectedLanguages[index];
                return GestureDetector(
                  onTap: () => selectLanguage(lang),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        lang,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void handleContinue() {
    final selectedArtists = context.read<UserDataProvider>().selectedArtists;

    if (selectedArtists.length < 3) {
      SlidingSnackbar(
        context: context,
        message: "Please select at least 3 artists.",
        isSuccess: false,
      ).show();
    } else {
      final userDataProvider = Provider.of<UserDataProvider>(context, listen: false);
      userDataProvider.printUserData();
      SlidingSnackbar(
        context: context,
        message: "Account Created Successfully",
        isSuccess: true,
      ).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    final artists = artistData[selectedLanguage] ?? [];
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Select your artist",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: context.watch<ColorProvider>().headingColor,
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: showLanguagePopup,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  gradient: containerGardient,
                  borderRadius: BorderRadius.circular(10),
                  border: GradientBoxBorder(
                    gradient: containerBorderGardient,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(
                    child: Text(
                      selectedLanguage,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Center(
          child: Container(
            width: screenWidth * .95,
            height: screenHeight * 0.65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: artists.isNotEmpty
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: artists.length,
                    itemBuilder: (context, index) {
                      final artist = artists[index];
                      final artistName = artist["name"]!;
                      final isSelected = context
                          .watch<UserDataProvider>()
                          .selectedArtists
                          .contains(artistName);
                      return GestureDetector(
                        onTap: () => context
                            .read<UserDataProvider>()
                            .toggleArtistSelection(artistName),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? activeContainerGardient
                                : containerGardient,
                            borderRadius: BorderRadius.circular(10),
                            border: GradientBoxBorder(
                              gradient: activeContainerBorderGardient,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(artist["image"]!),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Center(
                                child: Text(
                                  artistName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text(
                      "No artists found for $selectedLanguage",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: AccountCreationButton(
            text: "Continue",
            onPressed: handleContinue,
            buttonGradient: buttonGardient,
            borderGradient: buttonBorderGardient,
            icon: Broken.arrow_right_2,
          ),
        ),
      ],
    );
  }
}

