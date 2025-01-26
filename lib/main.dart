import 'package:flutter/material.dart';
import 'package:myapp/providers/userdata_provider.dart'; // Import the provider
import 'package:myapp/providers/gradient_provider.dart';
import 'package:myapp/providers/language_provider.dart';
import 'package:myapp/providers/textcolor_provider.dart';
import 'package:myapp/screens/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // Register UserDataProvider along with other providers
        ChangeNotifierProvider(create: (_) => UserDataProvider()), // Added UserDataProvider here
        ChangeNotifierProvider(create: (_) => GradientProvider()),
        ChangeNotifierProvider(create: (_) => ColorProvider()..loadColors()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALPhA MUSIX APP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'LexendDeca',
      ),
      home: const SplashScreen(),
    );
  }
}
