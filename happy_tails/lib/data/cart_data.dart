class CartItem {
  final String name;
  final String price;
  final String imagePath;
  int quantity; // প্রোডাক্টের পরিমাণ বা কোয়ান্টিটি বাড়ানোর জন্য

  CartItem({
    required this.name,
    required this.price,
    required this.imagePath,
    this.quantity = 1,
  });
}

// কার্টের প্রোডাক্টগুলো সেভ করে রাখার গ্লোবাল লিস্ট
List<CartItem> cartItems = [];