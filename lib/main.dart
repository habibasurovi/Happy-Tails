import 'dart:async';
import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/screens/main_screen.dart';

void main() {
  runApp(const HappyTails());
}

class HappyTails extends StatelessWidget {
  const HappyTails({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
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
    // ৩ সেকেন্ড পর MainScreen-এ নিয়ে যাবে
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // এখান থেকে const সরিয়ে দেওয়া হয়েছে কারণ অ্যানিমেশন ডাইনামিক
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        // আগের LogoSection() সরিয়ে আমাদের নতুন অ্যানিমেশন বসানো হলো
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.2, end: 1.0),
          duration: const Duration(milliseconds: 1200),
          curve: Curves.elasticOut, // বাউন্সিং ইফেক্ট
          builder: (context, double scale, child) {
            return Transform.scale(
              scale: scale,
              child: Opacity(
                opacity: scale.clamp(0.0, 1.0),
                child: child,
              ),
            );
          },
          // আপনার স্ক্রিনশট নেওয়া ছবিটির নাম এখানে দেওয়া হলো
          child: Image.asset(
            'assets/images/logo.png',
            width: 250,
          ),
        ),
      ),
    );
  }
}