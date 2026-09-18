import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import '../data/cart_data.dart';

class ConfirmOrderScreen extends StatefulWidget {
  const ConfirmOrderScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  final TextEditingController couponController = TextEditingController();
  double discount = 0.0;
  String couponMessage = '';

  // সাবটোটাল বা মোট দাম হিসাব করা
  double calculateSubtotal() {
    double total = 0;
    for (var item in cartItems) {
      // প্রাইস স্ট্রিং থেকে '৳' বা অন্য ক্যারেক্টার রিমুভ করে ডাবল এ কনভার্ট করা
      String cleanPrice = item.price.replaceAll('৳', '').replaceAll(',', '').trim();
      double price = double.tryParse(cleanPrice) ?? 0.0;
      total += price * item.quantity;
    }
    return total;
  }

  @override
  void dispose() {
    couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double subtotal = calculateSubtotal();
    double deliveryFee = subtotal > 0 ? 60.0 : 0.0; // ডেলিভারি চার্জ ৬০ টাকা
    double totalPayable = (subtotal + deliveryFee) - discount;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirm Order'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ১. অর্ডার সামারি কার্ড
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Subtotal', style: TextStyle(fontSize: 15)),
                      Text('৳${subtotal.toStringAsFixed(0)}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Delivery Fee', style: TextStyle(fontSize: 15)),
                      Text('৳${deliveryFee.toStringAsFixed(0)}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  if (discount > 0) ...[
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Discount', style: TextStyle(fontSize: 15, color: Colors.green)),
                        Text('- ৳${discount.toStringAsFixed(0)}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.green)),
                      ],
                    ),
                  ],
                  const Divider(height: 24, thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Amount to Pay', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(
                        '৳${totalPayable > 0 ? totalPayable.toStringAsFixed(0) : "0"}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ২. কুপন কোড সেকশন
            const Text(
              'Apply Voucher / Coupon',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: couponController,
                    decoration: InputDecoration(
                      hintText: 'Enter Coupon Code (e.g., HAPPY100)',
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: AppColors.border),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      if (couponController.text.trim().toUpperCase() == 'HAPPY100') {
                        discount = 100.0; // ১০০ টাকা ডিসকাউন্ট
                        couponMessage = 'Coupon applied successfully! You got ৳100 off.';
                      } else if (couponController.text.trim().isEmpty) {
                        couponMessage = 'Please enter a coupon code.';
                      } else {
                        discount = 0.0;
                        couponMessage = 'Invalid coupon code!';
                      }
                    });
                  },
                  child: const Text('Apply', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            if (couponMessage.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                couponMessage,
                style: TextStyle(
                  color: discount > 0 ? Colors.green : Colors.red,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
            const SizedBox(height: 40),

            // ৩. অর্ডার কনফার্ম করার ফাইনাল বাটন
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // অর্ডার সফলভাবে কনফার্ম হওয়ার ডায়ালগ
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Order Confirmed! 🎉'),
                      content: const Text('Your order has been placed successfully. Thank you for shopping with HappyTails!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              cartItems.clear(); // কার্ট খালি করে দেওয়া
                            });
                            Navigator.pop(context); // ডায়ালগ বন্ধ হবে
                            Navigator.pop(context); // কার্ট বা আগের পেজে ফিরে যাবে
                            Navigator.pop(context); // হোমে নিয়ে যাবে
                          },
                          child: const Text('Back to Home'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  'Confirm Order',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}