import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'login_screen.dart'; // তোমার প্রজেক্ট অনুযায়ী লগইন স্ক্রিনের পাথ ঠিক করে নিও

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // অ্যানিমেশন কন্ট্রোলার (সময়কাল ১.৫ সেকেন্ড)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    // লোগোটি অনেক ছোট থেকে শুরু হয়ে বেশ বড় (2.5 গুণ) জুম হবে
    _scaleAnimation = Tween<double>(begin: 0.2, end: 2.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    // অ্যানিমেশন শুরু করা
    _controller.forward();

    // ৩ সেকেন্ড পর লগইন স্ক্রিনে যাওয়া
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Image.asset(
            'assets/images/logo.png', // তোমার লোগোর পাথ
            width: 100, // বেস সাইজ ছোট রাখা হয়েছে যাতে জুম হয়ে বড় হতে পারে
            height: 100,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.pets,
                size: 80,
                color: Colors.white,
              );
            },
          ),
        ),
      ),
    );
  }
}