import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/text_styles.dart';

class LogoSection extends StatelessWidget {
  const LogoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.surface,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            /**Text("Happy Tails", style: TextStyles.appTitle),

            const SizedBox(height: 4),
            Text(
              "🐾 MAKING EVERY TAIL WAG 🐾 ",
              style: TextStyles.small.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                letterSpacing: 1.2,
              ),
            ),**/
            Image.asset(
              'assets/images/title.png',
              width: 300,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 0,
              color: AppColors.white.withValues(alpha: 0.6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(
                  'Woof! Ready to shop, friend? 🐾',
                  style: TextStyles.secondary.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            Image.asset(
              'assets/images/logo.png',
              height: 250,
              //width: 200,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
