'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import '../data/cart_data.dart';
import 'confirm_order_screen.dart'; // কনফার্ম অর্ডার স্ক্রিন ইম্পোর্ট করা হলো

class CartScreen extends StatefulWidget {
const CartScreen({Key? key}) : super(key: key);

@override
State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('My Shopping Cart'),
backgroundColor: AppColors.primary,
foregroundColor: Colors.white,
),
body: cartItems.isEmpty
? const Center(
child: Text(
'Your cart is empty!',
style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
),
)
    : Column(
children: [
Expanded(
child: ListView.builder(
padding: const EdgeInsets.all(12),
itemCount: cartItems.length,
itemBuilder: (context, index) {
final cartItem = cartItems[index];

return Card(
elevation: 3,
margin: const EdgeInsets.only(bottom: 12),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(15),
),
child: Padding(
padding: const EdgeInsets.all(10),
child: Row(
children: [
ClipRRect(
borderRadius: BorderRadius.circular(8),
child: Image.asset(
cartItem.imagePath,
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
cartItem.name,
style: const TextStyle(
fontWeight: FontWeight.bold, fontSize: 16),
),
const SizedBox(height: 4),
Text(
cartItem.price,
style: const TextStyle(
color: AppColors.primary,
fontWeight: FontWeight.w600),
),
],
),
),
// কোয়ান্টিটি বাড়ানোর বা কমানোর বাটন (Daraz Style)
Row(
children: [
IconButton(
icon: const Icon(Icons.remove_circle_outline),
onPressed: () {
setState(() {
if (cartItem.quantity > 1) {
cartItem.quantity--;
} else {
cartItems.removeAt(index);
}
});
},
),
Text(
'${cartItem.quantity}',
style: const TextStyle(
fontSize: 16, fontWeight: FontWeight.bold),
),
IconButton(
icon: const Icon(Icons.add_circle_outline),
onPressed: () {
setState(() {
cartItem.quantity++;
});
},
),
],
),
],
),
),
);
},
),
),

// নিচের চেকআউট সেকশন (Checkout Section)
Container(
padding: const EdgeInsets.all(16),
decoration: BoxDecoration(
color: Colors.white,
boxShadow: [
BoxShadow(
color: Colors.grey.withOpacity(0.3),
blurRadius: 10,
offset: const Offset(0, -5),
),
],
),
child: SafeArea(
child: SizedBox(
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
if (cartItems.isEmpty) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(content: Text('Your cart is empty!')),
);
return;
}

// সরাসরি ConfirmOrderScreen এ নিয়ে যাবে
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => const ConfirmOrderScreen(),
),
);
},
child: const Text(
'Proceed to Checkout',
style: TextStyle(
fontSize: 16,
fontWeight: FontWeight.bold,
color: Colors.white),
),
),
),
),
),
],
),
);
}
}