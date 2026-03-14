import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';
import 'package:path_earn_app/core/constants/app_text_style.dart';
import 'package:path_earn_app/features/quiz/data/models/quiz_result_model.dart';
import 'package:path_earn_app/routes/app_routes.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get quiz result from arguments
    final quizResult = Get.arguments?['quizResult'] as QuizResult?;

    if (quizResult == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Data tidak ditemukan'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Get.back(),
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          Positioned(
            top: 100,
            left: 90,
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
                    _buildHeadingText(context, quizResult),
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
                    padding: const EdgeInsets.fromLTRB(24, 28, 24, 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 50),
                        _buildScoreCard(context, quizResult),
                        const SizedBox(height: 20),
                        _buildStatCards(context, quizResult),
                        const SizedBox(height: 24),
                        _buildAnswerSummary(context, quizResult),
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
            onTap: () => Get.back(),
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

  Widget _buildHeadingText(BuildContext context, QuizResult result) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hebat! ${result.scoreLabel}',
            style: AppTextStyle.tsHeadingSmallBold(
              context,
              AppColors.whiteColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Quiz - Stage ${result.stage} Section ${result.section}',
            style: AppTextStyle.tsBodyMediumRegular(
              context,
              AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCard(BuildContext context, QuizResult result) {
    return Transform.translate(
      offset: const Offset(0, -55),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${result.totalScore}/${result.totalQuestions * 5}',
                  style: AppTextStyle.tsBodyLargeBold(
                    context,
                    AppColors.whiteColor,
                  ),
                ),
                Text(
                  '${result.scorePercentage}%',
                  style: AppTextStyle.tsBodyMediumRegular(
                    context,
                    AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCards(BuildContext context, QuizResult result) {
    return Transform.translate(
      offset: const Offset(0, -55),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              context,
              icon: Icons.check,
              iconColor: const Color(0xFF5A9352),
              count: result.correctCount,
              total: result.totalQuestions,
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
              count: result.wrongCount,
              total: result.totalQuestions,
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
              count: result.emptyCount,
              total: result.totalQuestions,
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

  Widget _buildAnswerSummary(BuildContext context, QuizResult result) {
    return Transform.translate(
      offset: const Offset(0, -55),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ringkasan Jawaban',
            style: AppTextStyle.tsBodyLargeBold(context, AppColors.blackColor),
          ),
          const SizedBox(height: 12),
          ...List.generate(result.answers.length, (index) {
            final answer = result.answers[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: answer.isCorrect
                        ? const Color(0xFF5A9352)
                        : const Color(0xFFBE5656),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      answer.isCorrect ? Icons.check : Icons.close,
                      color: answer.isCorrect
                          ? const Color(0xFF5A9352)
                          : const Color(0xFFBE5656),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Soal ${index + 1}',
                            style: AppTextStyle.tsBodySmallBold(
                              context,
                              AppColors.blackColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            answer.isCorrect
                                ? 'Jawaban Benar'
                                : 'Jawaban Salah',
                            style: AppTextStyle.tsBodySmallRegular(
                              context,
                              answer.isCorrect
                                  ? const Color(0xFF5A9352)
                                  : const Color(0xFFBE5656),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (answer.isCorrect)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF5A9352),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '+${answer.earnedPoints}',
                          style: AppTextStyle.tsBodySmallBold(
                            context,
                            AppColors.whiteColor,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ],
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
            Get.toNamed(Routes.STAGE);
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ke Beranda',
                style: AppTextStyle.tsBodyLargeBold(
                  context,
                  AppColors.whiteColor,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.home, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
