
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
            Text('Happy Tails',
                style: TextStyles.heading.copyWith(fontSize: 22)),
          ],
        ),
      ],
    );
  }
}