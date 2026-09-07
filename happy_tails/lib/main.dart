import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // স্প্ল্যাশ স্ক্রিন ইম্পোর্ট করা হলো

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Happy Tails',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: const Color(0xFFFDF8F2), // অ্যাপের ব্যাকগ্রাউন্ড কালার
      ),
      home: const SplashScreen(), // অ্যাপ ওপেন হলেই প্রথমে স্প্ল্যাশ স্ক্রিন দেখাবে
    );
  }
}