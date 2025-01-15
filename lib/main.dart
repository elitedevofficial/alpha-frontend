import 'package:flutter/material.dart';
import 'package:myapp/providers/gradient_provider.dart';
import 'package:myapp/providers/language_provider.dart';
import 'package:myapp/providers/textcolor_provider.dart';
import 'package:myapp/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GradientProvider()),
        ChangeNotifierProvider(create: (_) => ColorProvider()..loadColors()),
        ChangeNotifierProvider(create: (_) => LanguageProvider())
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Theme App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'LexendDeca',
      ),
      home: SplashScreen(),
    );
  }
}

