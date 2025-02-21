import 'package:flutter/material.dart';
import 'package:myapp/providers/slide_gesture_provider.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';
import 'package:provider/provider.dart';

class SettingsSwitchTileWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onSwitchChanged;
  final String settingsTitle;
  final String settingsSubtitle;
  final IconData settingsIcon;
  const SettingsSwitchTileWidget({
    super.key,
    required this.value,
    required this.onSwitchChanged,
    required this.settingsTitle,
    required this.settingsSubtitle,
    required this.settingsIcon,
  });

  @override
  Widget build(BuildContext context) {
    final slideGestureProvider = Provider.of<SlideGestureProvider>(context);

    return Container(
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
            width: MediaQuery.of(context).size.width * 0.65,
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
                      fontWeight: FontWeight.w500,
                      fontFamily: 'LexendDeca'),
                  softWrap: true,
                
                ),
              ],
            ),
          ),
          const Spacer(),
          Transform.scale(
            scale: slideGestureProvider.isSlideEnabled ? 0.9 : 1.0,
            child: Switch(
              value: value,
              onChanged: onSwitchChanged,
             
              activeColor: snowWhite,
              inactiveThumbColor: snowWhite,
              inactiveTrackColor: switchColorDisabled,
              activeTrackColor: switchColorEnabled,

              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          )
        ],
      ),
    );
  }
}
