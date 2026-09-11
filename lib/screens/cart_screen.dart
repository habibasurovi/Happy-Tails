import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/constants/text_styles.dart';
import 'package:happy_tails/data/cart_data.dart';
// CheckoutScreen-এর ইমপোর্ট ফাইলটি যুক্ত করা হলো
import 'package:happy_tails/screens/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  // Wishlist-এ ব্যাক করার জন্য ফাংশন
  final VoidCallback onBackToWishlist;

  const CartScreen({super.key, required this.onBackToWishlist});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    // AppData থেকে Cart এর আইটেম এবং মোট দাম নেওয়া হচ্ছে
    final cart = AppData.cartItems;
    final totalAmount = AppData.subtotal;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        // ব্যাক বাটন যা এখন উইশলিস্টে নিয়ে যাবে
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: widget.onBackToWishlist,
        ),
        title: Text('My Cart', style: TextStyles.appTitle.copyWith(fontSize: 22)),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: cart.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.shopping_cart_outlined, size: 64, color: AppColors.secondaryText),
            const SizedBox(height: 12),
            Text('Your cart is empty!', style: TextStyles.body.copyWith(color: AppColors.secondaryText)),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final item = cart[index];
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
                    item.product.imagePath,
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
                        item.product.name,
                        style: TextStyles.body.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '৳${item.product.price}',
                        style: TextStyles.body.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                // Quantity (+ / -) কন্ট্রোল করার অংশ
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          AppData.decrementQuantity(item);
                        });
                      },
                    ),
                    Text(
                      '${item.quantity}',
                      style: TextStyles.body.copyWith(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline, color: Colors.green),
                      onPressed: () {
                        setState(() {
                          AppData.incrementQuantity(item);
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),

      // একদম নিচে Buy Now এবং Total Price দেখানোর ডিজাইন
      bottomNavigationBar: cart.isEmpty
          ? null // কার্ট খালি থাকলে নিচে কিছু দেখাবে না
          : Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, -5), // শ্যাডো উপরের দিকে দেওয়ার জন্য
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min, // যতটুকু জায়গা দরকার ততটুকুই নিবে
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Total Price', style: TextStyles.body),
                Text(
                  '৳$totalAmount',
                  style: TextStyles.appTitle.copyWith(color: AppColors.primary, fontSize: 20),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // এখানে Checkout পেজে যাওয়ার ন্যাভিগেশন কোড যুক্ত করা হয়েছে
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CheckoutScreen(),
                  ),
                );
              },
              child: const Text('Buy Now', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}