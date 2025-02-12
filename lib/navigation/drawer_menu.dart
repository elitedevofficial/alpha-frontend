import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';

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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 26, 30, 61),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
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
                          SizedBox(
                            width: 10,
                          ),
                          Text('UXERNAME'),
                        ]),
                  ),
                ),
                DrawerCardWidget(
                  sideButtonTap: () {
                    advanceddrawerController.hideDrawer();
                    onScreenSelected("settings");
                  },
                  sideTitle: "Settings",
                  // sideIcon: sideIcon)
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.green,
        height: 120,
        child: Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.red, borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(Broken.timer_1),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Sleep Timer',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'LexendDeca',
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 53,
                    width: 88,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(Broken.edit),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 53,
                    width: 88,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(Broken.setting),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    // return Drawer(
    //   child: ListView(
    //     children: [
    //       const DrawerHeader(child: Text("Menu", style: TextStyle(fontSize: 22))),
    //       ListTile(
    //         title: const Text("Settings"),
    //         onTap: () => onScreenSelected("settings"),
    //       ),
    //       ListTile(
    //         title: const Text("Listening History"),
    //         onTap: () => onScreenSelected("listening_history"),
    //       ),
    //       ListTile(
    //         title: const Text("What's New"),
    //         onTap: () => onScreenSelected("whats_new"),
    //       ),
    //       ListTile(
    //         title: const Text("Sound Capsule"),
    //         onTap: () => onScreenSelected("sound_capsule"),
    //       ),
    //     ],
    //   ),
    // );
  }
}

class DrawerCardWidget extends StatelessWidget {
  final VoidCallback sideButtonTap;
  final String sideTitle;
  // final IconData sideIcon;
  const DrawerCardWidget({
    super.key,
    required this.sideButtonTap,
    required this.sideTitle,
    // required this.sideIcon,
  });

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: GestureDetector(
        onTap: sideButtonTap,
        child: Container(
          width: 210,
          height: 50,
          decoration: BoxDecoration(
            // color: colorScheme.surface,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon(
                //   sideIcon,
                //   size: 25,
                //   // color: Theme.of(context).primaryColor,
                // ),
                // alphawidth10,
                Text(
                  sideTitle,
                  style: TextStyle(
                      // color: Theme.of(context).primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'LexendDeca'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
