import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/providers/multi_language_provider.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';
import 'package:myapp/widgets/settings_common_widget/translations.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  final Function(String) onNavigateToSubScreen;

  const SettingsScreen({super.key, required this.onNavigateToSubScreen});

  @override
  Widget build(BuildContext context) {
    final multiLanguageProvider =
        Provider.of<MultiLanguageProvider>(context, listen: false);
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SettingsTileWidget(
                    settingsTap: () =>
                        onNavigateToSubScreen("settings_customization"),
                   /* settingsTitle:  Translations.texts[multiLanguageProvider
                                            .locale.languageCode]?['confirm'] ??
                                        'Confirm',*/
                   settingsTitle: 'Customization',
                    settingsSubtitle: 'Customize your app, theme, and more',
                    settingsIcon: Broken.edit,
                  ),
                  const SizedBox(height: 18),
                  SettingsTileWidget(
                    settingsTap: () =>
                        onNavigateToSubScreen("settings_advanced"),
                    settingsTitle: 'Advanced',
                    settingsSubtitle: 'Advanced Settings',
                    settingsIcon: Broken.edit,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SettingsTileWidget extends StatelessWidget {
  final VoidCallback settingsTap;
  final String settingsTitle;
  final String settingsSubtitle;
  final IconData settingsIcon;
  const SettingsTileWidget({
    super.key,
    required this.settingsTap,
    required this.settingsTitle,
    required this.settingsSubtitle,
    required this.settingsIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: settingsTap,
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Icon(
              settingsIcon,
              color: snowWhite,
              size: 28,
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    settingsTitle,
                    style: const TextStyle(
                        color: snowWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'LexendDeca'),
                  ),
                  Text(
                    settingsSubtitle,
                    style: const TextStyle(
                        color: snowWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'LexendDeca'),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Icon(
              Broken.arrow_right_3,
              color: snowWhite,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
