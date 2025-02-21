import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/providers/gradient_provider.dart';
import 'package:myapp/providers/multi_language_provider.dart';
import 'package:myapp/providers/slide_gesture_provider.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';
import 'package:myapp/widgets/commonwidget/gradientBorder.dart';
import 'package:myapp/widgets/settings_common_widget/settings_normal_tile.dart';
import 'package:myapp/widgets/settings_common_widget/settings_switch_tile.dart';
import 'package:myapp/widgets/settings_common_widget/translations.dart';
import 'package:provider/provider.dart';

class CustomizationScreen extends StatefulWidget {
  const CustomizationScreen({super.key});

  @override
  State<CustomizationScreen> createState() => _CustomizationScreenState();
}

class _CustomizationScreenState extends State<CustomizationScreen> {
// ------------------------------BACKGROUND GRADIENT START-----------------------------------------

  List<List<Color>> predefinedGradients = [
    [
      const Color(0xFF50D1BA),
      const Color(0xFF036D59),
      const Color(0xFF001A14),
    ],
    [
      const Color(0xFFEF5368),
      const Color(0xFF800214),
      const Color(0xFF320108),
    ],
    [
      const Color(0xFFEBC201),
      const Color(0xFF443900),
      const Color(0xFF191300),
    ],
    [
      const Color(0xFFD8448C),
      const Color(0xFF7C0A41),
      const Color(0xFF2D0218),
    ],
    [
      const Color(0xFFBA4008),
      const Color(0xFF371303),
      const Color(0xFF230C01),
    ],
  ];

  List<Color> selectedColors = [];

  @override
  void initState() {
    super.initState();
    final gradientProvider =
        Provider.of<GradientProvider>(context, listen: false);
    selectedColors = List.from(gradientProvider.colors); // Load saved colors
  }

  void pickGradient() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.maxFinite,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: containerGardient,
              ),
              child: Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: GradientBoxBorder(
                    gradient: containerBorderGardient,
                    width: 1.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: predefinedGradients.map((gradient) {
                          bool isSelected = selectedColors.isNotEmpty &&
                              selectedColors.length == gradient.length &&
                              selectedColors
                                  .every((color) => gradient.contains(color));

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedColors = List.from(gradient);
                              });
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: gradient,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                border: isSelected
                                    ? Border.all(color: snowWhite, width: 3)
                                    : Border.all(color: Colors.black, width: 1),
                                boxShadow: isSelected
                                    ? [
                                        BoxShadow(
                                          color: snowWhite.withOpacity(0.5),
                                          blurRadius: 5,
                                          spreadRadius: 2,
                                        ),
                                      ]
                                    : [],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: saveColors,
                        child: Container(
                          width: double.maxFinite,
                          height: 50,
                          decoration: BoxDecoration(
                              color: snowWhite,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Broken.colors_square,
                                color: tharBlack,
                                size: 28,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Apply',
                                style: TextStyle(
                                    color: tharBlack,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'LexendDeca'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: resetToDefaultColors,
                        child: Container(
                          width: double.maxFinite,
                          height: 50,
                          decoration: BoxDecoration(
                              color: dangerRed,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Broken.repeat_circle,
                                color: tharBlack,
                                size: 28,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Reset',
                                style: TextStyle(
                                    color: tharBlack,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'LexendDeca'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const SizedBox(
                          width: double.maxFinite,
                          height: 30,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Broken.arrow_left_2,
                                color: snowWhite,
                                size: 28,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Cancel',
                                style: TextStyle(
                                    color: snowWhite,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'LexendDeca'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void saveColors() {
    final gradientProvider =
        Provider.of<GradientProvider>(context, listen: false);
    gradientProvider.updateColors(selectedColors);
    Navigator.pop(context);
  }

  void resetToDefaultColors() {
    final gradientProvider =
        Provider.of<GradientProvider>(context, listen: false);
    gradientProvider.resetColors();
    setState(() {
      selectedColors = List.from(gradientProvider.colors);
    });
    Navigator.pop(context);
  }

// ----------------------BACKGROUND GRADIENT END---------------------------
 

  void showLanguageSelector(BuildContext context) {
    final multiLanguageProvider =
        Provider.of<MultiLanguageProvider>(context, listen: false);
    String currentLang = multiLanguageProvider.locale.languageCode;
    String selectedLang = currentLang; // Temp variable to store selection

    final Map<String, String> languageNames = {
      'dt': 'Dutch',
      'en': 'English',
      'es': 'Spanish',
      'fr': 'French',
      'de': 'German',
      'hi': 'hindi',
      'it': 'Italian',
    };

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Container(
                      height: MediaQuery.of(context).size.height * 0.65,
                      width: double.maxFinite,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: containerGardient,
                      ),
                      child: Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: GradientBoxBorder(
                            gradient: containerBorderGardient,
                            width: 1.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom:
                                      BorderSide(color: snowWhite, width: 0.5),
                                ),
                              ),
                              child: Text(
                                Translations.texts[multiLanguageProvider
                                        .locale.languageCode]?['slanguage'] ??
                                    'Language',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: snowWhite,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'LexendDeca'),
                              ),
                            ),

                            Expanded(
                              child: ListView(
                                physics: BouncingScrollPhysics(),
                                children: languageNames.entries.map((entry) {
                                  String langCode = entry.key;
                                  String langName = entry.value;
                                  return ListTile(
                                    leading: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: snowWhite,
                                            width: 1.5), // White border
                                      ),
                                      child: CircleAvatar(
                                        backgroundColor:
                                            Colors.transparent,
                                        child: Text(
                                          langName[0],
                                          style: const TextStyle(
                                            color: snowWhite,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'LexendDeca',
                                          ),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      langName,
                                      style: const TextStyle(
                                          color: snowWhite,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'LexendDeca'),
                                    ),
                                    trailing: selectedLang == langCode
                                        ? const Icon(Icons.check,
                                            color: snowWhite)
                                        : null,
                                    onTap: () =>
                                        setState(() => selectedLang = langCode),
                                  );
                                }).toList(),
                              ),
                            ),

                            // Fixed Buttons at Bottom
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () async {
                                    await multiLanguageProvider
                                        .setLanguage(selectedLang);
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    Translations.texts[multiLanguageProvider
                                            .locale.languageCode]?['confirm'] ??
                                        'Confirm',
                                    style: const TextStyle(color: snowWhite),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    Translations.texts[multiLanguageProvider
                                            .locale.languageCode]?['cancel'] ??
                                        'Cancel',
                                    style: const TextStyle(color: snowWhite),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await multiLanguageProvider
                                        .resetToDefault();
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    Translations.texts[multiLanguageProvider
                                            .locale.languageCode]?['reset'] ??
                                        'Reset',
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ));
                },
              ),
            );
          },
        );
      },
    );
  }

// ----------------------LANGUAGE SELECTOR END---------------------------

  @override
  Widget build(BuildContext context) {
    final gradientProvider = Provider.of<GradientProvider>(context);
    final slideGestureProvider = Provider.of<SlideGestureProvider>(context);

    List<Color> appliedColors = gradientProvider.colors;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: getAppGradient(context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: pickGradient,
                      child: BackgroundGetter(appliedColors: appliedColors),
                    ),
                    const SizedBox(height: 18),
                    SettingsSwitchTileWidget(
                      settingsTitle: 'Drawer Slide',
                      settingsSubtitle:
                          'Enable or disable swipe gesture for drawer opening.',
                      settingsIcon: Broken.slider,
                      value: slideGestureProvider.isSlideEnabled,
                      onSwitchChanged: (bool value) {
                        slideGestureProvider.toggleSlideGesture(value);
                      },
                    ),
                    const SizedBox(height: 18),
                    SettingsNormalTileWidget(
                      settingsNormalTitle: 'Language',
                      settingsNormalIcon: Broken.language_square,
                      settingsNormalTap: () => showLanguageSelector(context),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BackgroundGetter extends StatelessWidget {
  const BackgroundGetter({
    super.key,
    required this.appliedColors,
  });

  final List<Color> appliedColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, bottom: 5),
        child: Row(
          children: [
            const Icon(
              Broken.brush_2,
              color: snowWhite,
              size: 28,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Translations.texts[Provider.of<MultiLanguageProvider>(context)
                          .locale
                          .languageCode]?['confirm'] ??
                      'Confirm',
                  style: TextStyle(
                      color: snowWhite,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'LexendDeca'),
                ),
              ],
            ),
            const Spacer(),
            Container(
              width: 29,
              height: 29,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: appliedColors.isNotEmpty
                    ? LinearGradient(
                        colors: appliedColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : const RadialGradient(
                        center: Alignment(0, -0.6),
                        radius: 1.2,
                        colors: [
                            Color(0xFF25263A),
                            Color.fromARGB(255, 26, 30, 61),
                            Color(0xFF101118)
                          ],
                        stops: [
                            0.1,
                            0.4,
                            1
                          ]),
                color: appliedColors.isEmpty ? Colors.grey : null,
                border: Border.all(color: snowWhite, width: 2), // White border
              ),
            ),
          ],
        ),
      ),
    );
  }
}
