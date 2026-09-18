import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
// আপনার লগ-ইন স্ক্রিনের ফাইলটি এখানে ইমপোর্ট করতে হবে
// import 'package:happy_tails/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // ৩ সেকেন্ড পর অটোমেটিক লগ-ইন স্ক্রিনে নিয়ে যাওয়ার লজিক
    Future.delayed(const Duration(seconds: 3), () {
      /*
      // যখন আপনার LoginScreen তৈরি হয়ে যাবে, তখন নিচের কমেন্টগুলো তুলে দিবেন
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
      */
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        // লোগোটিতে সুন্দর একটি অ্যানিমেশন দেওয়ার জন্য TweenAnimationBuilder ব্যবহার করা হয়েছে
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0.2, end: 1.0),
          duration: const Duration(milliseconds: 1200),
          curve: Curves.elasticOut, // এটি লোগোটিতে একটি সুন্দর বাউন্সিং ইফেক্ট দিবে
          builder: (context, double scale, child) {
            return Transform.scale(
              scale: scale,
              child: Opacity(
                opacity: scale.clamp(0.0, 1.0),
                child: child,
              ),
            );
          },
          // এখানে আপনার লোগোর ছবি দিন
          child: Image.asset(
            'assets/images/logo.png', // আপনার লোগোর সঠিক পাথটি এখানে বসিয়ে দিন
            width: 250,
          ),
        ),
      ),
    );
  }
}