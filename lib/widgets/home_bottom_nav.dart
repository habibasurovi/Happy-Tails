// lib/widgets/home_bottom_nav.dart
import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 0,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.secondaryText,
      backgroundColor: AppColors.white,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.storefront), label: 'Shop'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Wishlist'),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
      ],
    );
  }
}