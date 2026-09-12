import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/constants/text_styles.dart';


class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Happy Pets, Happy Hearts ',
            style: TextStyles.button.copyWith(fontSize: 18),
          ),
          const SizedBox(height: 6),
          Text(
            'Everything your pet needs, delivered with love.',
            style: TextStyles.small.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}