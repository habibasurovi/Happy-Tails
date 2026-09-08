import 'dart:async';
import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/screens/login_screen.dart';
import 'package:happy_tails/screens/profile_screen.dart';
import 'package:happy_tails/widgets/logo_section.dart';

void main() {
  runApp(const HappyTails());
}

class HappyTails extends StatelessWidget {
  const HappyTails({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Happy Tails',
      home: const SplashScreen(),
      routes: {
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: const Center(
        child: LogoSection(),
      ),
    );
  }
}