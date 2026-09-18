import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/constants/text_styles.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String rating;
  final String imagePath;
  final String? badge;

  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.rating,
    required this.imagePath,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  imagePath,
                  height: 80,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (badge != null)
                Positioned(
                  top: 6,
                  left: 6,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      badge!,
                      style: TextStyles.small.copyWith(color: AppColors.white, fontSize: 9),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyles.body.copyWith(fontSize: 13, fontWeight: FontWeight.w600),
                  maxLines: 1,
                ),
                const SizedBox(height: 4),
                Text(
                  price,
                  style: TextStyles.body.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.star, size: 12, color: AppColors.warning),
                    const SizedBox(width: 2),
                    Text(rating, style: TextStyles.small),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}