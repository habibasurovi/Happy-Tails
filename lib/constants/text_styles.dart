import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:happy_tails/constants/app_colors.dart';

class TextStyles{
  //happy tails
  static final appTitle = GoogleFonts.baloo2(
    fontSize: 34,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  static final heading = GoogleFonts.patrickHand(
    fontSize: 30,
    color: AppColors.primaryText,
  );

  static final subHeading = GoogleFonts.nunito(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.primaryText,
  );

  static final body = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.primaryText,
  );

  static final secondary = GoogleFonts.nunito(
    fontSize: 14,
    color: AppColors.secondaryText,
  );

  static final button = GoogleFonts.poppins(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static final small = GoogleFonts.nunito(
    fontSize: 12,
    color: AppColors.secondaryText,
  );
}
