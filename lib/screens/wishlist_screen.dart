import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/constants/text_styles.dart';
import 'package:happy_tails/data/cart_data.dart';

class WishlistScreen extends StatefulWidget {
  // শপ পেজে ব্যাক করার জন্য একটি রিকোয়ার্ড ফাংশন
  final VoidCallback onBackToShop;

  const WishlistScreen({super.key, required this.onBackToShop});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    final wishlist = AppData.wishlistItems;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        // ব্যাক বাটন যা এখন শপ ট্যাবে নিয়ে যাবে
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: widget.onBackToShop,
        ),
        title: Text('My Wishlist', style: TextStyles.appTitle.copyWith(fontSize: 22)),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: wishlist.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.favorite_border, size: 64, color: AppColors.secondaryText),
            const SizedBox(height: 12),
            Text('Your wishlist is empty!', style: TextStyles.body.copyWith(color: AppColors.secondaryText)),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: wishlist.length,
        itemBuilder: (context, index) {
          final product = wishlist[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    product.imagePath,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: TextStyles.body.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '৳${product.price}',
                        style: TextStyles.body.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.shopping_cart_checkout, color: Colors.green),
                  onPressed: () {
                    AppData.addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${product.name} added to cart!'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      AppData.toggleWishlist(product);
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}