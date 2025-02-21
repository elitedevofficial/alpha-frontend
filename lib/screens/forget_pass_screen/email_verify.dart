import 'package:flutter/material.dart';
import 'package:myapp/widgets/commonwidget/common_colors.dart';


class EmailVerify extends StatelessWidget {
  const EmailVerify({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(gradient: getAppGradient(context)),
          ),
          
        ],
      ),
    );
  }
}

