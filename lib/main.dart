
import 'package:flutter/material.dart';
import 'package:myapp/providers/homecatagory_provider.dart';
import 'package:myapp/providers/slide_gesture_provider.dart';
import 'package:myapp/providers/userdata_provider.dart';
import 'package:myapp/providers/gradient_provider.dart';
import 'package:myapp/providers/language_provider.dart';
import 'package:myapp/providers/textcolor_provider.dart';
import 'package:myapp/providers/multi_language_provider.dart'; // Import MultiLanguageProvider
import 'package:myapp/screens/splash_screen/splash_screen.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure bindings are initialized

  final multiLanguageProvider = MultiLanguageProvider();
  await multiLanguageProvider.loadLanguage(); // Load saved language

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => UserDataProvider()), // Added UserDataProvider here
        ChangeNotifierProvider(create: (_) => GradientProvider()),
        ChangeNotifierProvider(create: (_) => ColorProvider()..loadColors()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => SlideGestureProvider()),
         ChangeNotifierProvider(
      create: (context) => CategoryProvider(),),
        ChangeNotifierProvider(
            create: (_) => multiLanguageProvider), // Add MultiLanguageProvider
      ],
      child: const MyApp(),
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
      theme: ThemeData(fontFamily: 'LexendDeca'),
      locale: Provider.of<MultiLanguageProvider>(context)
          .locale, // Set locale dynamically
      home: const SplashScreen(),
    );
  }
}
