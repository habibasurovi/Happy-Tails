import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/constants/text_styles.dart';
import 'package:happy_tails/data/cart_data.dart';
import 'package:happy_tails/screens/checkout_screen.dart';

class CartScreen extends StatefulWidget {
  final VoidCallback? onBackToWishlist;

  const CartScreen({super.key, this.onBackToWishlist});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void increaseQuantity(int index) {
    setState(() {
      AppData.cartItems[index].quantity++;
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (AppData.cartItems[index].quantity > 1) {
        AppData.cartItems[index].quantity--;
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      AppData.cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final myCartItems = AppData.cartItems;

    int cartTotal = 0;
    for (var item in myCartItems) {
      cartTotal += (item.product.price * item.quantity);
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: widget.onBackToWishlist != null
            ? IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: widget.onBackToWishlist,
        )
            : null,
        title: Text(
          "My Cart",
          style: TextStyles.appTitle.copyWith(fontSize: 22, color: const Color(0xFFC8553D)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: myCartItems.isEmpty
          ? const Center(child: Text("Your cart is empty!"))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: myCartItems.length,
              itemBuilder: (context, index) {
                final item = myCartItems[index];
                int totalPrice = item.product.price * item.quantity;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: ColoredBox(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: Image.asset(
                              item.product.imagePath,
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
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "৳$totalPrice",
                                  style: const TextStyle(
                                    color: Color(0xFFC8553D),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline, color: Colors.grey),
                                onPressed: () => decreaseQuantity(index),
                              ),
                              Text(
                                '${item.quantity}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline, color: Color(0xFFC8553D)),
                                onPressed: () => increaseQuantity(index),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.red),
                            onPressed: () => removeItem(index),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          ColoredBox(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Total:", style: TextStyle(fontSize: 16, color: Colors.grey)),
                        Text("৳$cartTotal", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFC8553D))),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFC8553D),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckoutScreen(subtotal: cartTotal),
                        ),
                      );
                    },
                    child: const Text("Checkout", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}