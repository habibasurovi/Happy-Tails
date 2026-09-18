import 'package:flutter/material.dart';
import 'package:happy_tails/screens/splash_screen.dart';

void main() {
  runApp(const HappyTails());
}

class HappyTails extends StatelessWidget {
  const HappyTails({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
