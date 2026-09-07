import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/constants/text_styles.dart';

class ShopByPet extends StatelessWidget {
  const ShopByPet({super.key});

  final List<Map<String, dynamic>> categories = const [
    {'label': 'Dogs', 'icon': Icons.pets},
    {'label': 'Cats', 'icon': Icons.pets},
    {'label': 'Birds', 'icon': Icons.flutter_dash},
    {'label': 'Bunnies', 'icon': Icons.cruelty_free},
    {'label': 'Fish', 'icon': Icons.set_meal},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Shop by Pet', style: TextStyles.subHeading),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: categories.map((cat) {
            return Column(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(cat['icon'], color: AppColors.primary),
                ),
                const SizedBox(height: 6),
                Text(cat['label'], style: TextStyles.small),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}