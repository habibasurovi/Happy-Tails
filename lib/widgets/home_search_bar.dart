
import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/constants/text_styles.dart';
import 'package:happy_tails/models/product.dart';
import 'package:happy_tails/data/cat_products.dart';
import 'package:happy_tails/data/dog_products.dart';
import 'package:happy_tails/data/bird_products.dart';
import 'package:happy_tails/data/bunny_products.dart';
import 'package:happy_tails/data/fish_products.dart';

class HomeSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  const HomeSearchBar({super.key, required this.controller, this.onChanged});

  static List<Product> searchProducts(String query, {String? category}) {
    final List<Product> allProducts = [
      ...catProductsData,
      ...dogProductsData,
      ...birdProductsData,
      ...bunnyProductsData,
      ...fishProductsData,
    ];

    if (query.isEmpty) {
      if (category == null) return [];
      return allProducts.where((p) => p.mainCategory == category).toList();
    }

    return allProducts.where((p) {
      bool matchesCategory = category == null || p.mainCategory == category;
      bool matchesQuery = p.name.toLowerCase().contains(query.toLowerCase());
      return matchesCategory && matchesQuery;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyles.body,
        decoration: InputDecoration(
          hintText: 'Search for food, toys, treats...',
          hintStyle: TextStyles.secondary,
          prefixIcon: const Icon(Icons.search, color: AppColors.primary, size: 20),
          filled: true,
          fillColor: AppColors.textField,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}