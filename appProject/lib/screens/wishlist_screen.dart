import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import '../data/wishlist_data.dart';
import '../data/cart_data.dart';

class WishlistScreen extends StatefulWidget {
  final VoidCallback? onBackToHome; // হোমে যাওয়ার জন্য কলব্যাক
  const WishlistScreen({super.key, this.onBackToHome});

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {}); // পেজে আসার সাথে সাথে লিস্ট রিফ্রেশ হবে
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        // ১০০% কার্যক্ষম ব্যাক বাটন লজিক
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (widget.onBackToHome != null) {
              widget.onBackToHome!(); // সরাসরি হোমে নিয়ে যাবে
            } else if (Navigator.canPop(context)) {
              Navigator.pop(context); // পুশ হয়ে এলে আগের পেজে যাবে
            }
          },
        ),
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
                  ),
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
    );
  }
}