import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';

class AppTextStyle {
  AppTextStyle._();

  /// RESPONSIVE SIZE
  double figmaFontsize(BuildContext context, double fontSize) {
    final screenWidth = MediaQuery.of(context).size.width;
    const figmaWidth = 375.0;

    double scale = screenWidth / figmaWidth;
    scale = scale.clamp(0.9, 1.2);

    return fontSize * scale;
  }

  double responsiveSize(BuildContext context, double size) {
    final screenWidth = MediaQuery.of(context).size.width;
    const figmaWidth = 375.0;
    return size * (screenWidth / figmaWidth);
  }

  /// BOX SHADOW
  BoxShadow shadowBlackBlur15Color5(BuildContext context) => BoxShadow(
    color: AppColors.greyColor.withValues(alpha: 0.5),
    blurRadius: responsiveSize(context, 15),
    offset: const Offset(0, 0),
  );

  BoxShadow shadowBlackBlur10Color5(BuildContext context) => BoxShadow(
    color: AppColors.greyColor.withValues(alpha: 0.5),
    blurRadius: responsiveSize(context, 10),
    offset: const Offset(0, 0),
  );

  /// BORDER RADIUS
  BorderRadius defaultBorderRadius(BuildContext context) =>
      BorderRadius.circular(responsiveSize(context, 15));

  /// TEXT STYLES
  // HEADING LARGE (28)
  TextStyle tsHeadingLargeBold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 28),
        fontWeight: FontWeight.w700,
        color: color,
      );

  TextStyle tsHeadingLargeSemibold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 28),
        fontWeight: FontWeight.w600,
        color: color,
      );

  TextStyle tsHeadingLargeMedium(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 28),
        fontWeight: FontWeight.w500,
        color: color,
      );

  TextStyle tsHeadingLargeRegular(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 28),
        fontWeight: FontWeight.w400,
        color: color,
      );

  // HEADING MEDIUM (26)
  TextStyle tsHeadingMediumBold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 26),
        fontWeight: FontWeight.w700,
        color: color,
      );

  TextStyle tsHeadingMediumSemibold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 26),
        fontWeight: FontWeight.w600,
        color: color,
      );

  TextStyle tsHeadingMediumMedium(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 26),
        fontWeight: FontWeight.w500,
        color: color,
      );

  TextStyle tsHeadingMediumRegular(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 26),
        fontWeight: FontWeight.w400,
        color: color,
      );

  // HEADING SMALL (24)
  TextStyle tsHeadingSmallBold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 24),
        fontWeight: FontWeight.w700,
        color: color,
      );

  TextStyle tsHeadingSmallSemibold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 24),
        fontWeight: FontWeight.w600,
        color: color,
      );

  TextStyle tsHeadingSmallMedium(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 24),
        fontWeight: FontWeight.w500,
        color: color,
      );

  TextStyle tsHeadingSmallRegular(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 24),
        fontWeight: FontWeight.w400,
        color: color,
      );

  // TITLE (22, 20, 18)
  TextStyle tsTitleLargeBold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 22),
        fontWeight: FontWeight.w700,
        color: color,
      );

  TextStyle tsTitleLargeSemibold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 22),
        fontWeight: FontWeight.w600,
        color: color,
      );

  TextStyle tsTitleLargeMedium(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 22),
        fontWeight: FontWeight.w500,
        color: color,
      );

  TextStyle tsTitleLargeRegular(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 22),
        fontWeight: FontWeight.w400,
        color: color,
      );

  TextStyle tsTitleMediumBold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 20),
        fontWeight: FontWeight.w700,
        color: color,
      );

  TextStyle tsTitleMediumSemibold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 20),
        fontWeight: FontWeight.w600,
        color: color,
      );

  TextStyle tsTitleMediumMedium(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 20),
        fontWeight: FontWeight.w500,
        color: color,
      );

  TextStyle tsTitleMediumRegular(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 20),
        fontWeight: FontWeight.w400,
        color: color,
      );

  TextStyle tsTitleSmallBold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 18),
        fontWeight: FontWeight.w700,
        color: color,
      );

  TextStyle tsTitleSmallSemibold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 18),
        fontWeight: FontWeight.w600,
        color: color,
      );

  TextStyle tsTitleSmallMedium(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 18),
        fontWeight: FontWeight.w500,
        color: color,
      );

  TextStyle tsTitleSmallRegular(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 18),
        fontWeight: FontWeight.w400,
        color: color,
      );

  // BODY (16, 14, 12)
  TextStyle tsBodyLargeBold(BuildContext c, Color color) => GoogleFonts.poppins(
    fontSize: figmaFontsize(c, 16),
    fontWeight: FontWeight.w700,
    color: color,
  );

  TextStyle tsBodyLargeSemibold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 16),
        fontWeight: FontWeight.w600,
        color: color,
      );

  TextStyle tsBodyLargeMedium(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 16),
        fontWeight: FontWeight.w500,
        color: color,
      );

  TextStyle tsBodyLargeRegular(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 16),
        fontWeight: FontWeight.w400,
        color: color,
      );

  TextStyle tsBodyMediumBold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 14),
        fontWeight: FontWeight.w700,
        color: color,
      );

  TextStyle tsBodyMediumSemibold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 14),
        fontWeight: FontWeight.w600,
        color: color,
      );

  TextStyle tsBodyMediumMedium(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 14),
        fontWeight: FontWeight.w500,
        color: color,
      );

  TextStyle tsBodyMediumRegular(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 14),
        fontWeight: FontWeight.w400,
        color: color,
      );

  TextStyle tsBodySmallBold(BuildContext c, Color color) => GoogleFonts.poppins(
    fontSize: figmaFontsize(c, 12),
    fontWeight: FontWeight.w700,
    color: color,
  );

  TextStyle tsBodySmallSemibold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 12),
        fontWeight: FontWeight.w600,
        color: color,
      );

  TextStyle tsBodySmallMedium(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 12),
        fontWeight: FontWeight.w500,
        color: color,
      );

  TextStyle tsBodySmallRegular(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 12),
        fontWeight: FontWeight.w400,
        color: color,
      );

  // LABEL (10, 8)
  TextStyle tsLabelLargeBold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 10),
        fontWeight: FontWeight.w700,
        color: color,
      );

  TextStyle tsLabelLargeSemibold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 10),
        fontWeight: FontWeight.w600,
        color: color,
      );

  TextStyle tsLabelLargeMedium(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 10),
        fontWeight: FontWeight.w500,
        color: color,
      );

  TextStyle tsLabelLargeRegular(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 10),
        fontWeight: FontWeight.w400,
        color: color,
      );

  TextStyle tsLabelMediumBold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 8),
        fontWeight: FontWeight.w700,
        color: color,
      );

  TextStyle tsLabelMediumSemibold(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 8),
        fontWeight: FontWeight.w600,
        color: color,
      );

  TextStyle tsLabelMediumMedium(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 8),
        fontWeight: FontWeight.w500,
        color: color,
      );

  TextStyle tsLabelMediumRegular(BuildContext c, Color color) =>
      GoogleFonts.poppins(
        fontSize: figmaFontsize(c, 8),
        fontWeight: FontWeight.w400,
        color: color,
      );
}
