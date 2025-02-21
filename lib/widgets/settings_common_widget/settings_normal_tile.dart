import 'package:flutter/material.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';

class SettingsNormalTileWidget extends StatelessWidget {
  final VoidCallback settingsNormalTap;
  final String settingsNormalTitle;
  final String? settingsNormalSubtitle;
  final IconData settingsNormalIcon;
  const SettingsNormalTileWidget({
    super.key,
    required this.settingsNormalTitle,
    this.settingsNormalSubtitle,
    required this.settingsNormalIcon,
    required this.settingsNormalTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: settingsNormalTap,
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
             Icon(
              settingsNormalIcon,
              color: snowWhite,
              size: 28,
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    settingsNormalTitle,
                    style: const TextStyle(
                        color: snowWhite,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'LexendDeca'),
                  ),
                  if (settingsNormalSubtitle != null)
                  Text(
                    settingsNormalSubtitle!,
                    style: const TextStyle(
                        color: snowWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'LexendDeca'),
                    softWrap: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
