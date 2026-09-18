import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/screens/home_screen.dart';
import 'package:happy_tails/screens/shop_screen.dart';
import 'package:happy_tails/screens/wishlist_screen.dart'; // উইশলিস্ট স্ক্রিন ইম্পোর্ট করা হলো
import 'package:happy_tails/screens/cart_screen.dart';     // কার্ট স্ক্রিন ইম্পোর্ট করা হলো

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  String _selectedShopCategory = 'Dogs';

  // ৫টি ট্যাবের জন্য সঠিক স্ক্রিনগুলোর লিস্ট (ইনডেক্স অনুযায়ী সাজানো)
  late final List<Widget> _screens = [
    const HomeScreen(),                              // Index 0: Home
    ShopScreen(initialCategory: _selectedShopCategory), // Index 1: Shop
    const WishlistScreen(),                          // Index 2: Wishlist
    const CartScreen(),                              // Index 3: Cart
    const Center(child: Text('Profile Screen')),     // Index 4: Profile
  ];

  void _navigateToShopWithCategory(String category) {
    setState(() {
      _selectedShopCategory = category;
      _currentIndex = 1; // Switch to Shop tab
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.secondaryText,
        backgroundColor: AppColors.white,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.storefront), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Wishlist'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}