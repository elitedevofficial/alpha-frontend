import 'package:flutter/material.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: getAppGradient(context),
            ),
          ),
        ],
      ),
    ));
  }
}
