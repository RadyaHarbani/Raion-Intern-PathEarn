import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';
import 'package:path_earn_app/core/constants/app_text_style.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  // hardcode testing
  // nanti harusnya dari backend
  final int currentQuestion = 1;
  final int totalQuestion = 20;
  final String sectionTitle = 'Quiz - Section 1';
  final String questionText =
      'Siapa yang menciptakan dan memperkenalkan sound horreg di Malang, Jawa Timur?';
  final int points = 5;
  final List<String> options = [
    'Thomas alfa Edi Sound',
    'Raion Community',
    'BCC',
    'Thomas Alfa Edison',
    'Udin Sound Horeg',
  ];
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4EEF4),
      body: Stack(
        children: [
          Positioned(
            bottom: 10,
            right: -20,
            child: Opacity(
              opacity: 1.0,
              child: SvgPicture.asset(
                'assets/images/quiz_back.svg',
                width: 350,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(context),
                _buildProgressBar(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        _buildQuestionCounter(context),
                        const SizedBox(height: 16),
                        _buildQuestion(context),
                        const SizedBox(height: 16),
                        _buildPointsBadge(context),
                        const SizedBox(height: 24),
                        _buildOptions(context),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildNextButton(context),
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
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                sectionTitle,
                style: AppTextStyle.tsBodyLargeBold(
                  context,
                  AppColors.primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 28),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    final progress = currentQuestion / totalQuestion;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: LinearProgressIndicator(
          value: progress,
          minHeight: 8,
          backgroundColor: const Color(0xFFE0E0E0),
          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFBCAD3E)),
        ),
      ),
    );
  }

  Widget _buildQuestionCounter(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$currentQuestion',
            style: AppTextStyle.tsBodyMediumBold(context, Color(0xFFBCAD3E)),
          ),
          TextSpan(
            text: '/$totalQuestion',
            style: AppTextStyle.tsBodyMediumRegular(
              context,
              AppColors.greyColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestion(BuildContext context) {
    return Text(
      questionText,
      style: AppTextStyle.tsHeadingSmallMedium(context, AppColors.primaryColor),
    );
  }

  Widget _buildPointsBadge(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: const Color.fromARGB(118, 250, 230, 83),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Color(0xFFBCAD3E),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              '$points Points',
              style: AppTextStyle.tsBodySmallSemibold(
                context,
                Color(0xFFBCAD3E),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptions(BuildContext context) {
    return Column(
      children: List.generate(options.length, (index) {
        final isSelected = selectedIndex == index;
        return Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: double.infinity,
              height: 68,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primaryColor
                    : Color(0xFF8D5293).withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      options[index],
                      style: AppTextStyle.tsBodyMediumSemibold(
                        context,
                        isSelected
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                      ),
                    ),
                  ),
                  if (isSelected)
                    const Icon(
                      Icons.check,
                      color: AppColors.whiteColor,
                      size: 20,
                    ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              // TODO: navigasi ke soal berikutnya atau halaman hasil
            },
            child: Row(
              children: [
                Text(
                  'Lanjut',
                  style: AppTextStyle.tsBodyLargeBold(
                    context,
                    AppColors.blackColor,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.chevron_right,
                  color: AppColors.blackColor,
                  size: 24,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
