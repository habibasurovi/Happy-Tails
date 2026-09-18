import 'package:flutter/material.dart';
import 'package:happy_tails/screens/home_screen.dart';
import 'package:happy_tails/screens/shop_screen.dart';
import 'package:happy_tails/screens/wishlist_screen.dart';
import 'package:happy_tails/screens/cart_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    // স্ক্রিনের লিস্টটি build মেথডের ভেতরে নিয়ে আসা হয়েছে
    final List<Widget> screens = [
      const HomeScreen(),
      const ShopScreen(),
      WishlistScreen(
        // এই ফাংশনটি উইশলিস্টের ব্যাক বাটনে ক্লিক করলে কাজ করবে
        onBackToShop: () {
          setState(() {
            _currentIndex = 1; // ১ মানে Shop পেজ
          });
        },
      ),
      // আগের CartScreen() এর বদলে এইটুকু লিখুন
      CartScreen(
        onBackToWishlist: () {
          setState(() {
            _currentIndex = 2; // ২ মানে Wishlist পেজের ইনডেক্স
          });
        },
      ),
      const Center(child: Text('Profile Screen')),
    ];

    return Scaffold(
      // IndexedStack সরিয়ে সরাসরি screens পাস করা হলো
      body: screens[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.storefront_outlined), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Wishlist'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}