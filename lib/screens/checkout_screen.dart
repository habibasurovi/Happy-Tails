import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/constants/text_styles.dart';

class CheckoutScreen extends StatefulWidget {
  final int subtotal;

  const CheckoutScreen({super.key, required this.subtotal});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController couponController = TextEditingController();

  double discount = 0.0;
  String couponMessage = "";

  void applyCoupon() {
    setState(() {
      if (couponController.text.trim().toUpperCase() == "HAPPY10") {
        discount = widget.subtotal * 0.10;
        couponMessage = "10% Discount Applied!";
      } else if (couponController.text.trim().toUpperCase() == "PET50") {
        discount = 50.0;
        couponMessage = "৳50 Flat Discount Applied!";
      } else {
        discount = 0.0;
        couponMessage = "Invalid Coupon Code";
      }
    });
  }

  @override
  void dispose() {
    couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double totalToPay = widget.subtotal - discount;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          "Checkout",
          style: TextStyles.appTitle.copyWith(fontSize: 22, color: const Color(0xFFC8553D)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Have a coupon code?", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: couponController,
                    decoration: const InputDecoration(
                      hintText: "Enter Code (e.g., HAPPY10)",
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  ),
                  onPressed: applyCoupon,
                  child: const Text("Apply", style: TextStyle(color: Colors.white)),
                )
              ],
            ),
            if (couponMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  couponMessage,
                  style: TextStyle(
                    color: discount > 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            const SizedBox(height: 32),
            const ColoredBox(color: Colors.grey, child: SizedBox(height: 1, width: double.infinity)),
            const SizedBox(height: 16),

            const Text("Order Summary", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Subtotal:", style: TextStyle(fontSize: 16)),
                Text("৳${widget.subtotal}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Discount:", style: TextStyle(fontSize: 16, color: Colors.green)),
                Text("-৳${discount.toStringAsFixed(0)}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
            const SizedBox(height: 16),
            const ColoredBox(color: Colors.grey, child: SizedBox(height: 1, width: double.infinity)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total to Pay:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(
                  "৳${totalToPay.toStringAsFixed(0)}",
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFC8553D)),
                ),
              ],
            ),

            const Expanded(child: SizedBox()), 

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC8553D),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Order Confirmed Successfully!"),
                      backgroundColor: AppColors.primary,
                    ),
                  );
                  print("Order Confirmed!");
                },
                child: const Text("Confirm Order", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}