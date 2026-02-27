import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';

class AppTextStyle {
  AppTextStyle._();

  /// RESPONSIVE SIZE
  static double figmaFontsize(BuildContext context, double fontSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    const figmaWidth = 375.0;

    double scale = screenWidth / figmaWidth;
    scale = scale.clamp(0.9, 1.2);

    return fontSize * scale;
  }

  static double responsiveSize(BuildContext context, double size) {
    final screenWidth = MediaQuery.of(context).size.width;
    const figmaWidth = 375.0;
    return size * (screenWidth / figmaWidth);
  }

  /// BOX SHADOW
  static BoxShadow shadowBlackBlur15Color5(BuildContext context) => BoxShadow(
    color: AppColors.greyColor.withValues(alpha: 0.5),
    blurRadius: responsiveSize(context, 15),
    offset: const Offset(0, 0),
  );

  static BoxShadow shadowBlackBlur10Color5(BuildContext context) => BoxShadow(
    color: AppColors.greyColor.withValues(alpha: 0.5),
    blurRadius: responsiveSize(context, 10),
    offset: const Offset(0, 0),
  );

  /// BORDER RADIUS
  static BorderRadius defaultBorderRadius(BuildContext context) =>
      BorderRadius.circular(responsiveSize(context, 15));

  /// TEXT STYLES
  // HEADING LARGE (28)
  static TextStyle tsHeadingLargeBold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 28),
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle tsHeadingLargeSemibold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 28),
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle tsHeadingLargeMedium(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 28),
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle tsHeadingLargeRegular(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 28),
        fontWeight: FontWeight.w400,
        color: color,
      );

  // HEADING MEDIUM (26)
  static TextStyle tsHeadingMediumBold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 26),
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle tsHeadingMediumSemibold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 26),
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle tsHeadingMediumMedium(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 26),
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle tsHeadingMediumRegular(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 26),
        fontWeight: FontWeight.w400,
        color: color,
      );

  // HEADING SMALL (24)
  static TextStyle tsHeadingSmallBold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 24),
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle tsHeadingSmallSemibold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 24),
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle tsHeadingSmallMedium(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 24),
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle tsHeadingSmallRegular(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 24),
        fontWeight: FontWeight.w400,
        color: color,
      );

  // TITLE (22, 20, 18)
  static TextStyle tsTitleLargeBold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 22),
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle tsTitleLargeSemibold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 22),
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle tsTitleLargeMedium(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 22),
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle tsTitleLargeRegular(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 22),
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle tsTitleMediumBold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 20),
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle tsTitleMediumSemibold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 20),
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle tsTitleMediumMedium(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 20),
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle tsTitleMediumRegular(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 20),
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle tsTitleSmallBold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 18),
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle tsTitleSmallSemibold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 18),
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle tsTitleSmallMedium(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 18),
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle tsTitleSmallRegular(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 18),
        fontWeight: FontWeight.w400,
        color: color,
      );

  // BODY (16, 14, 12)
  static TextStyle tsBodyLargeBold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 16),
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle tsBodyLargeSemibold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 16),
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle tsBodyLargeMedium(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 16),
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle tsBodyLargeRegular(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 16),
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle tsBodyMediumBold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 14),
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle tsBodyMediumSemibold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 14),
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle tsBodyMediumMedium(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 14),
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle tsBodyMediumRegular(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 14),
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle tsBodySmallBold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 12),
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle tsBodySmallSemibold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 12),
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle tsBodySmallMedium(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 12),
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle tsBodySmallRegular(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 12),
        fontWeight: FontWeight.w400,
        color: color,
      );

  // LABEL (10, 8)
  static TextStyle tsLabelLargeBold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 10),
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle tsLabelLargeSemibold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 10),
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle tsLabelLargeMedium(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 10),
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle tsLabelLargeRegular(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 10),
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle tsLabelMediumBold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 8),
        fontWeight: FontWeight.w700,
        color: color,
      );

  static TextStyle tsLabelMediumSemibold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 8),
        fontWeight: FontWeight.w600,
        color: color,
      );

  static TextStyle tsLabelMediumMedium(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 8),
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle tsLabelMediumRegular(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 8),
        fontWeight: FontWeight.w400,
        color: color,
      );
}
