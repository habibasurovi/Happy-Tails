import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'home_screen.dart'; // স্প্ল্যাশ শেষে যে পেজে যাবে (যেমন HomeScreen বা LoginScreen)
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // অ্যানিমেশন কন্ট্রোলার (২ সেকেন্ডের জন্য)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // স্কেল অ্যানিমেশন (জুম-ইন ইফেক্ট)
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();

    // ৩ সেকেন্ড পর পরবর্তী স্ক্রিনে চলে যাবে
    // ৩ সেকেন্ড পর LoginScreen এ চলে যাবে
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()), // এখানে HomeScreen এর বদলে LoginScreen দিয়ে দাও
      );
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
      backgroundColor: AppColors.background,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Image.asset(
            'assets/images/logo.png', // তোমার লোগো বা ছবির পাথ এখানে ঠিকমতো দিয়ে দিও
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}