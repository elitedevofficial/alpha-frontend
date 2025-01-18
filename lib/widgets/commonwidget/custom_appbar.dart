import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showBackButton;
  final VoidCallback? onBack;
  final VoidCallback? onSettings;

  const CustomAppBar({super.key, 
    this.title,
    this.showBackButton = false,
    this.onBack,
    this.onSettings,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: showBackButton
      //     ? IconButton(
      //         icon: Icon(Icons.arrow_back),
      //         onPressed: onBack,
      //       )
      //     : null,
      
      title: title != null ? Text(title!) : null, // Hide the title if null
      actions: [
        if (!showBackButton && onSettings != null)
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: onSettings,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
