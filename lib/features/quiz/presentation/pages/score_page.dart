import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';
import 'package:path_earn_app/core/constants/app_text_style.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  /// TEST HARDCODE
  /// Disesuaikan dengan backend
  static const String userName = 'Alya';
  static const String scoreLabel = 'Sempurna';
  static const String sectionTitle = 'Quiz - Section 1';
  static const int score = 95;
  static const int correctCount = 19;
  static const int wrongCount = 1;
  static const int emptyCount = 0;
  static const int totalQuestion = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: 90,
            // right: 0,
            child: Opacity(
              opacity: 0.95,
              child: SvgPicture.asset(
                'assets/images/score_bg.svg',
                height: 430,
                width: 200,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Column(
            children: [
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAppBar(context),
                    const SizedBox(height: 240),
                    _buildHeadingText(context),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF8F0FA),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(24, 28, 24, 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildScoreCard(context),
                        SizedBox(height: 20),
                        _buildStatCards(context),
                        SizedBox(height: 24),
                        _buildLihatPembahasan(context),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.chevron_left,
              size: 28,
              color: AppColors.whiteColor,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Skor Kamu',
                style: AppTextStyle.tsBodyLargeBold(
                  context,
                  AppColors.whiteColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 28),
        ],
      ),
    );
  }

  Widget _buildHeadingText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hebat $userName! $scoreLabel',
            style: AppTextStyle.tsHeadingSmallBold(
              context,
              AppColors.whiteColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            sectionTitle,
            style: AppTextStyle.tsBodyMediumRegular(
              context,
              AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCard(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -55),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: BoxDecoration(
          color: const Color(0xFF5A9352),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Skor Quiz Kamu:',
              style: AppTextStyle.tsBodyMediumSemibold(
                context,
                AppColors.whiteColor,
              ),
            ),
            Text(
              '$score',
              style: AppTextStyle.tsBodyLargeBold(
                context,
                AppColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCards(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -55),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              context,
              icon: Icons.check,
              iconColor: const Color(0xFF5A9352),
              count: correctCount,
              total: totalQuestion,
              countColor: const Color(0xFF5A9352),
              label: 'Benar',
              labelBg: const Color(0xFF5A9352),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatItem(
              context,
              icon: Icons.close,
              iconColor: const Color(0xFFBE5656),
              count: wrongCount,
              total: totalQuestion,
              countColor: const Color(0xFFBE5656),
              label: 'Salah',
              labelBg: const Color(0xFFBE5656),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildStatItem(
              context,
              icon: Icons.remove,
              iconColor: AppColors.blackColor,
              count: emptyCount,
              total: totalQuestion,
              countColor: AppColors.blackColor,
              label: 'Kosong',
              labelBg: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required int count,
    required int total,
    required Color countColor,
    required String label,
    required Color labelBg,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -5,
            right: 15,
            child: Icon(icon, color: iconColor, size: 24),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon(icon, color: iconColor, size: 24),
                const SizedBox(height: 32),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '$count',
                        style: AppTextStyle.tsTitleMediumBold(
                          context,
                          countColor,
                        ),
                      ),
                      TextSpan(
                        text: '/$total',
                        style: AppTextStyle.tsBodySmallRegular(
                          context,
                          AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: labelBg,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Text(
                    label,
                    style: AppTextStyle.tsBodySmallSemibold(
                      context,
                      AppColors.whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLihatPembahasan(BuildContext context) {
    return Transform.translate(
      offset: Offset(0, -55),
      child: GestureDetector(
        onTap: () {
          // TODO: navigasi ke halaman pembahasan
        },
        child: Row(
          children: [
            const Icon(
              Icons.chevron_left,
              size: 20,
              color: AppColors.blackColor,
            ),
            const SizedBox(width: 4),
            Text(
              'Lihat Pembahasan',
              style: AppTextStyle.tsBodyMediumRegular(
                context,
                AppColors.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // TODO: navigasi ke halaman pembelajaran
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFBCAD3E),
            foregroundColor: AppColors.whiteColor,
            padding: const EdgeInsets.symmetric(vertical: 18),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 32),
              Text(
                'Lanjutkan Pembelajaran',
                style: AppTextStyle.tsBodyLargeBold(
                  context,
                  AppColors.whiteColor,
                ),
              ),
              const SizedBox(width: 64),
              const Icon(Icons.chevron_right, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
