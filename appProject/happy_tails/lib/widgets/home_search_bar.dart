
import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/constants/text_styles.dart';

class HomeSearchBar extends StatelessWidget {
  final TextEditingController controller;
  const HomeSearchBar({super.key, required this.controller});

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