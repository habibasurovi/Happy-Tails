class CartItem {
  final String name;
  final String price;
  final String imagePath;
  int quantity;

  CartItem({
    required this.name,
    required this.price,
    required this.imagePath,
    required this.quantity,
  });
}

List<CartItem> cartItems = [];