import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/providers/gradient_provider.dart';
import 'package:myapp/providers/textcolor_provider.dart';
import 'package:myapp/screens/settings_screens/text_etting.dart';
import 'package:myapp/screens/settings_screens/theme_settings_screen.dart';
import 'package:provider/provider.dart';

class SettingsScreentwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gradientColors = Provider.of<GradientProvider>(context).colors;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Settings Screen'),
      // ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.bottomLeft, // Custom alignment for SettingsScreentwo
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          children: [
            IconButton(
              icon: Icon(Broken.arrow_left_2,color: Colors.green,),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => ThemeSettingsScreentwo()
                //       ),
                // );
              },
            ),
            IconButton(
              icon: Icon(Broken.setting_2,color: Colors.green,),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TextEtting()),
                );
              },
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    'Settings Screen',
                    style: TextStyle(color: context.watch<ColorProvider>().headingColor, fontSize: 24),
                  ),
                  Text(
                    'Settings ubScreen',
                    style: TextStyle(color: context.watch<ColorProvider>().subHeadingColor, fontSize: 24),
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
