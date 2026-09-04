// lib/widgets/happy_picks.dart
import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/constants/text_styles.dart';
import 'product_card.dart';

class HappyPicks extends StatelessWidget {
  const HappyPicks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Happy Picks ', style: TextStyles.subHeading),
            Text('See all →', style: TextStyles.small.copyWith(color: AppColors.primary)),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 165,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              ProductCard(
                name: 'Nutripaws Adult Chicken & Rice',
                price: '৳850',
                rating: '4.8 (230)',
                imagePath: 'assets/images/products/dog_food.jpg',
                badge: 'Best Seller',
              ),
              ProductCard(
                name: 'Squeaky Toy Set',
                price: '৳320',
                rating: '4.6 (98)',
                imagePath: 'assets/images/products/squeaky_toys.jpg',
              ),
              ProductCard(
                name: 'Cozy Pet Bed',
                price: '৳1450',
                rating: '4.9 (410)',
                imagePath: 'assets/images/products/cozy_bed.jpg',
              ),
            ],
          ),
        ),
      ],
    );
  }
}