import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import '../screens/wishlist_screen.dart';
import '../screens/cart_screen.dart';

class HomeBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const HomeBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.secondaryText,
      backgroundColor: AppColors.white,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index == 2) {
          // Wishlist-এ গেলে বটম বার সহ দেখানোর জন্য Push
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WishlistScreen()),
          );
        } else if (index == 3) {
          // Cart স্ক্রিন (এখানে তুমি চাইলে বটম বার রাখতেও পারো বা নাও পারো)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartScreen()),
          );
        } else {
          onTap(index);
        }
      },
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