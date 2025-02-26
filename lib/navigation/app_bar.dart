import 'package:flutter/material.dart';
import 'package:myapp/core/icon_fonts/broken_icons.dart';
import 'package:myapp/providers/gradient_provider.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';
import 'package:provider/provider.dart';

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
    final gradientProvider = Provider.of<GradientProvider>(context);
    return AppBar(
      
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      // backgroundColor: gradientProvider.secondaryColor,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
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
                size: 22,
                color: snowWhite,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: snowWhite
              ),
            ),
           const Spacer(),
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
  Size get preferredSize => const Size.fromHeight(40);
}
