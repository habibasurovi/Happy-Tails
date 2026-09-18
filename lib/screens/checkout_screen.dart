import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/constants/text_styles.dart';
import 'package:happy_tails/data/cart_data.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _couponController = TextEditingController();

  // ডিসকাউন্টের হিসাব রাখার জন্য ভ্যারিয়েবল
  double discount = 0.0;
  bool isCouponApplied = false;

  // কুপন চেক করার ফাংশন
  void _applyCoupon() {
    // ইউজার ছোট বা বড় হাতের অক্ষরে লিখলেও যেন কাজ করে তাই toUpperCase() দেওয়া হয়েছে
    if (_couponController.text.trim().toUpperCase() == 'HAPPY100') {
      setState(() {
        discount = 100.0;
        isCouponApplied = true;
      });
      // কুপন কাজ করলে সবুজ রঙের সাকসেস মেসেজ দেখাবে
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Coupon Applied! You got ৳100 discount.'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      setState(() {
        discount = 0.0;
        isCouponApplied = false;
      });
      // কুপন ভুল হলে লাল রঙের মেসেজ দেখাবে
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid Coupon Code!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = AppData.cartItems;
    final subtotal = AppData.subtotal;
    // সাবটোটাল থেকে ডিসকাউন্ট বাদ দিয়ে ফাইনাল টোটাল বের করা হচ্ছে
    // যদি সাবটোটাল ১০০ টাকার কম হয়, তাহলে টোটাল যেন মাইনাস না হয়ে 0 হয় সেটার লজিক
    final finalTotal = (subtotal - discount) > 0 ? (subtotal - discount) : 0;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Checkout', style: TextStyles.appTitle.copyWith(fontSize: 22)),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      // SingleChildScrollView দেওয়া হয়েছে যাতে আইটেম বেশি হলে স্ক্রল করা যায়
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ১. Order Summary বা প্রোডাক্ট লিস্ট
            Text('Order Summary', style: TextStyles.appTitle.copyWith(fontSize: 18)),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          item.product.imagePath,
                          width: 50,
                          height: 50,
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
                            // এখানে কালার বা অন্যান্য ডিটেইলস দেখাতে পারেন
                            Text(
                              'Qty: ${item.quantity}',
                              style: TextStyles.body.copyWith(color: AppColors.secondaryText, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '৳${item.product.price * item.quantity}',
                        style: TextStyles.body.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 24),

            // ২. Coupon Code সেকশন
            Text('Have a coupon?', style: TextStyles.appTitle.copyWith(fontSize: 18)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _couponController,
                    decoration: InputDecoration(
                      hintText: 'Enter "HAPPY100"',
                      filled: true,
                      fillColor: AppColors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isCouponApplied ? Colors.grey : AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: isCouponApplied ? null : _applyCoupon,
                  child: Text(
                    isCouponApplied ? 'Applied' : 'Apply',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // ৩. Payment Details বা অর্ডারের হিসাব
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subtotal', style: TextStyles.body.copyWith(color: Colors.grey.shade700)),
                      Text('৳$subtotal', style: TextStyles.body),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Discount', style: TextStyles.body.copyWith(color: Colors.grey.shade700)),
                      Text(
                        '- ৳$discount',
                        style: TextStyles.body.copyWith(color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total to Pay', style: TextStyles.body.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(
                        '৳$finalTotal',
                        style: TextStyles.appTitle.copyWith(color: AppColors.primary, fontSize: 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),

      // একদম নিচে Confirm Order বাটন
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Order Confirmed! 🎉')),
              );
            },
            child: const Text(
              'Confirm Order',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}