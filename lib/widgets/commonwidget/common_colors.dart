import 'package:flutter/material.dart';
import 'package:myapp/providers/gradient_provider.dart';
import 'package:provider/provider.dart';

RadialGradient getAppGradient(
  BuildContext context,
) {
  final gradientColors = Provider.of<GradientProvider>(context).colors;
  return RadialGradient(
      center: const Alignment(0, -0.6),
      radius: 1.2,
      colors: gradientColors,
      stops: const [0.1, 0.4, 1]);
}

// _________________CONTAINER GRADIENT_________________________

LinearGradient containerGardient = LinearGradient(
  colors: [
    const Color(0xFF101435).withOpacity(0.5),
    const Color(0xFF000000),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

LinearGradient containerBorderGardient = LinearGradient(
  colors: [
    Colors.white.withOpacity(0.8),
    Colors.transparent,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
LinearGradient containerBorderGardienttwo = LinearGradient(
  colors: [
    Colors.transparent,
    Colors.white.withOpacity(0.8),
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

// _________________BUTTON GRADIENT_________________________

LinearGradient buttonGardient = LinearGradient(
    colors: [
      const Color(0xFF6562FB).withOpacity(0.4),
      const Color(0xFF2737CF).withOpacity(0.77),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: const [0.17, 1.0]);

LinearGradient buttonBorderGardient = LinearGradient(
  colors: [
    const Color(0xFF000000).withOpacity(0.0),
    const Color(0xFF402788)
  ], // Gradient colors
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

// _________________ACTIVE CONTAINER GRADIENT_________________________

LinearGradient activeContainerGardient = LinearGradient(
  colors: [
    const Color(0xFF2737CF).withOpacity(0.4),
    const Color(0xFF6562FB).withOpacity(0.70)
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

LinearGradient activeContainerBorderGardient = LinearGradient(
  colors: [
    Colors.white.withOpacity(0.8),
    Colors.transparent,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

// SOLID COLORS
const snowWhite = Color(0xFFFFFAFA);
const tharBlack = Color.fromARGB(255, 24, 24, 24);
const dangerRed = Color(0xFFbb2124);
const switchColorDisabled = Color(0xFF101435);
const switchColorEnabled = Color.fromARGB(45, 98, 121, 251);
