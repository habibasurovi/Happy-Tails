import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/constants/text_styles.dart';


class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.pets, color: AppColors.primary, size: 26),
            const SizedBox(width: 6),
            Text('Happy Tails', style: TextStyles.heading.copyWith(fontSize: 22)),
          ],
        ),
        Row(
          children: [
            _iconWithBadge(Icons.notifications_none, 3),
            const SizedBox(width: 14),
            _iconWithBadge(Icons.shopping_cart_outlined, 3),
          ],
        ),
      ],
    );
  }

  Widget _iconWithBadge(IconData icon, int count) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(icon, color: AppColors.primaryText, size: 24),
        if (count > 0)
          Positioned(
            right: -4,
            top: -4,
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$count',
                style: TextStyles.small.copyWith(
                  color: AppColors.white,
                  fontSize: 9,
                ),
              ),
            ),
          ),
      ],
    );
  }
}