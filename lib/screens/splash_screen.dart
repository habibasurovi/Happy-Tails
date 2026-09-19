import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
// apnar log-in screen er file ti ekhane import korte hobe
import 'package:happy_tails/screens/login_screen.dart';
import 'package:happy_tails/screens/main_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Note theke: StatefulWidget[cite: 1]
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Note theke: Timer function - 3 second pore login page e nibe jabe[cite: 1]
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        // Advance animation baad diye ekdom simple Image.asset rakha hoyeche[cite: 1]
        child: Image.asset(
          'assets/images/logo.png', // apnar logor sothik path ti ekhane bosiye din
          width: 250,
        ),
      ),
    );
  }
}