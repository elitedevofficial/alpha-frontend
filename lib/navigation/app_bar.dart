import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int currentIndex;
  final VoidCallback onProfileTap;
  final List<Widget> actions;
  final Function drawerControl;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.currentIndex,
    required this.onProfileTap,
    this.actions = const [],
    required this.drawerControl,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Color.fromARGB(255, 26, 30, 61),
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              onPressed: () => drawerControl(),
              child: Icon(
                Broken.menu,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                // color: Theme.of(context).primaryColor,
              ),
            ),
            Spacer(),
            ...actions,
            if (currentIndex != 4)
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    // color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
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
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
// title: Text(title),
      // actions: [
      //   IconButton(
      //     icon: Icon(Icons.menu),
      //     onPressed: () => drawerControl(),  // Call the drawer control callback here
      //   ),
      // if (currentIndex != 4) // Hide profile icon on Profile screen
      //   IconButton(
      //     icon: const Icon(Icons.person),
      //     onPressed: onProfileTap,
      //   ),
      //   ...actions, // Add additional icons based on the screen
      // ],