import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/providers/gradient_provider.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';
import 'package:myapp/widgets/commonwidget/gradientBorder.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatelessWidget {
  final Function(String) onScreenSelected;
  final AdvancedDrawerController advanceddrawerController;
  const DrawerMenu({
    super.key,
    required this.onScreenSelected,
    required this.advanceddrawerController,
  });
 
  @override
  Widget build(BuildContext context) {
    final gradientProvider = Provider.of<GradientProvider>(context);
    const double twoBoxWidth = 88;
    const double twoBoxHeight = 39;
    const double iconSize = 22;
    const double blankHeight = 10;
    return Scaffold(
      backgroundColor: gradientProvider.secondaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: snowWhite,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 5, right: 5, top: 6, bottom: 6),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: Image.network(
                                'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Developer',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'LexendDeca',
                            ),
                          ),
                        ]),
                  ),
                ),
                const SizedBox(
                  height: blankHeight,
                ),
                Container(
                  height: 1,
                  decoration: BoxDecoration(
                    color: snowWhite,
                  ),
                ),
                const SizedBox(
                  height: blankHeight,
                ),
                DrawerCardWidget(
                    sideButtonTap: () {
                      advanceddrawerController.hideDrawer();
                    },
                    sideTitle: "Listening History",
                    sideIcon: Broken.timer),
                const SizedBox(
                  height: blankHeight,
                ),
                DrawerCardWidget(
                    sideButtonTap: () {
                      advanceddrawerController.hideDrawer();
                    },
                    sideTitle: "What's New",
                    sideIcon: Broken.notification_1)
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 120,
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 44,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: containerGardient),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: GradientBoxBorder(
                      gradient: containerBorderGardient,
                      width: 1.5,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(
                          Broken.timer_1,
                          size: 22,
                          color: snowWhite,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Sleep Timer',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'LexendDeca',
                            color: snowWhite,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: twoBoxHeight,
                      width: twoBoxWidth,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: containerGardient),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: GradientBoxBorder(
                            gradient: containerBorderGardient,
                            width: 1.5,
                          ),
                        ),
                        child: Icon(
                          Broken.edit,
                          size: iconSize,
                          color: snowWhite,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      advanceddrawerController.hideDrawer();
                      onScreenSelected("settings");
                    },
                    child: Container(
                      height: twoBoxHeight,
                      width: twoBoxWidth,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: containerGardient),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: GradientBoxBorder(
                            gradient: containerBorderGardient,
                            width: 1.5,
                          ),
                        ),
                        child: Icon(
                          Broken.setting,
                          size: iconSize,
                          color: snowWhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerCardWidget extends StatelessWidget {
  final VoidCallback sideButtonTap;
  final String sideTitle;
  final IconData sideIcon;
  const DrawerCardWidget({
    super.key,
    required this.sideButtonTap,
    required this.sideTitle,
    required this.sideIcon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: sideButtonTap,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: containerGardient),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: GradientBoxBorder(
              gradient: containerBorderGardient,
              width: 1.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(
                  sideIcon,
                  size: 22,
                  color: snowWhite,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  sideTitle,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'LexendDeca',
                    color: snowWhite,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
