import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zini_pay_demo/core/colors.dart';

class AppTypography {
  static TextStyle get acmeH1 => GoogleFonts.acme(
        fontSize: 36,
        fontWeight: FontWeight.normal,
        color: AppColors.black,
      );

  static TextStyle get h1 => GoogleFonts.montserrat(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.textColor,
      );

  static TextStyle get medium => GoogleFonts.montserrat(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: AppColors.textColor,
      );
}
