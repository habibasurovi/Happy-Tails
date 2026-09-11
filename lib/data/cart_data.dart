import 'package:flutter/material.dart';
import 'package:happy_tails/models/product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class AppData {
  // Global Lists
  static final List<Product> wishlistItems = [];
  static final List<CartItem> cartItems = [];

  // Wishlist Methods
  static bool isWishlisted(Product product) {
    return wishlistItems.any((item) => item.id == product.id);
  }

  static void toggleWishlist(Product product) {
    if (isWishlisted(product)) {
      wishlistItems.removeWhere((item) => item.id == product.id);
    } else {
      wishlistItems.add(product);
    }
  }

  // Cart Methods
  static void addToCart(Product product) {
    final index = cartItems.indexWhere((item) => item.product.id == product.id);
    if (index >= 0) {
      cartItems[index].quantity++;
    } else {
      cartItems.add(CartItem(product: product));
    }
  }

  static void removeFromCart(Product product) {
    cartItems.removeWhere((item) => item.product.id == product.id);
  }

  static void incrementQuantity(CartItem item) {
    item.quantity++;
  }

  static void decrementQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      cartItems.remove(item);
    }
  }

  // Calculation Methods
  static double get subtotal {
    double total = 0;
    for (var item in cartItems) {
      total += item.product.price * item.quantity;
    }
    return total;
  }
}