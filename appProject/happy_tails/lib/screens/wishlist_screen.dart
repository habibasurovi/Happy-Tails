import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import '../data/wishlist_data.dart';
import '../data/cart_data.dart';
import 'cart_screen.dart'; // কার্ট স্ক্রিন ইম্পোর্ট করা হলো

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: wishListItems.isEmpty
          ? const Center(
        child: Text(
          'Your wishlist is empty!',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: wishListItems.length,
        itemBuilder: (context, index) {
          final wishItem = wishListItems[index];

          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      wishItem.imagePath,
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
                          wishItem.name,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          wishItem.price,
                          style: const TextStyle(
                              color: AppColors.primary, fontWeight: FontWeight.w600, fontSize: 13),
                        ),
                        const SizedBox(height: 6),

                        // Add to Cart বাটন
                        Row(
                          children: [
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                minimumSize: const Size(0, 30),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  var existingCartItem = cartItems.firstWhere(
                                        (item) => item.name == wishItem.name,
                                    orElse: () => CartItem(name: '', price: '', imagePath: '', quantity: 0),
                                  );

                                  if (existingCartItem.name.isNotEmpty) {
                                    existingCartItem.quantity++;
                                  } else {
                                    cartItems.add(
                                      CartItem(
                                        name: wishItem.name,
                                        price: wishItem.price,
                                        imagePath: wishItem.imagePath,
                                        quantity: 1,
                                      ),
                                    );
                                  }
                                });

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Added from Wishlist to Cart!'),
                                    duration: Duration(milliseconds: 700),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.shopping_cart_outlined, size: 14),
                              label: const Text('Add to Cart', style: TextStyle(fontSize: 11)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // উইশলিস্ট থেকে ডিলিট করার বাটন
                  IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red, size: 24),
                    onPressed: () {
                      setState(() {
                        wishListItems.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),

      // এখানে নিচের নেভিগেশন বারটি যুক্ত করে দেওয়া হলো
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // যেহেতু এটি Wishlist ট্যাব
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.secondaryText,
        backgroundColor: AppColors.white,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context); // হোমে ফিরে যাবে
          } else if (index == 3) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const CartScreen()),
            );
          }
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