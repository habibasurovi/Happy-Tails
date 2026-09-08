import 'package:flutter/material.dart';
import 'package:happy_tails/constants/app_colors.dart';
import 'package:happy_tails/constants/text_styles.dart';

class CustomTextField extends StatelessWidget {

  final TextEditingController controller;
  final String hintText;
  final String label;
  final IconData prefixIcon;
  final bool obscureText; //for password only
  final Widget? suffixIcon;
  final String? errorText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.label,
    required this.prefixIcon,
    this.obscureText = false,
    this.suffixIcon,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorText != null && errorText!.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyles.body),
        const SizedBox(height:6),

        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
              color: hasError
                  ? Colors.red.withValues(alpha: 0.15)
                  : AppColors.primary.withValues(alpha: 0.15),
              blurRadius: 6,
              offset: const Offset(0,3),
              )
            ]
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            style: TextStyles.body,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyles.secondary,
              prefixIcon: Icon(
                prefixIcon,
                color: hasError ? Colors.red : AppColors.primary,
                size: 20,
              ),
              suffixIcon: hasError
              ? const Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
              )
              : suffixIcon,

              filled: true,
              fillColor: AppColors.textField,

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    color: hasError ? Colors.red : AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                    color: hasError ? Colors.red : AppColors.primary, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 12,
              ),
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              errorText!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ]

    );
  }
}