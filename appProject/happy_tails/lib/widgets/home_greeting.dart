import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/constants/text_styles.dart';


class HomeGreeting extends StatelessWidget {
  final String userName;
  const HomeGreeting({super.key, this.userName = "Bella's hooman"});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyles.subHeading,
            children: [
              const TextSpan(text: 'Hey there! '),
              TextSpan(
                text: '$userName ',
                style: TextStyles.subHeading.copyWith(color: AppColors.primary),
              ),
              const TextSpan(text: '🐾'),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Ready for today's tail-wagging deals?",
          style: TextStyles.secondary,
        ),
      ],
    );
  }
}
