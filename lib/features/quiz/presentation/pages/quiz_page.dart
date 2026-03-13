import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';
import 'package:path_earn_app/core/constants/app_text_style.dart';
import 'package:path_earn_app/features/quiz/presentation/controllers/quiz_controller.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuizController());

    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF4EEF4),
        body: Obx(
          () => controller.isLoading.value
              ? Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: AppColors.primaryColor,
                    size: 50,
                  ),
                )
              : Stack(
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
                          _buildAppBar(context, controller),
                          _buildProgressBar(controller),
                          Expanded(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),
                                  _buildQuestionCounter(context, controller),
                                  const SizedBox(height: 16),
                                  _buildQuestion(context, controller),
                                  const SizedBox(height: 16),
                                  _buildPointsBadge(context, controller),
                                  const SizedBox(height: 24),
                                  _buildOptions(context, controller),
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
                      child: _buildBottomBar(context, controller),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, QuizController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: const Icon(
              Icons.chevron_left,
              size: 28,
              color: AppColors.blackColor,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Quiz - Stage ${controller.stage.value} Section ${controller.section.value}',
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

  Widget _buildProgressBar(QuizController controller) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: LinearProgressIndicator(
            value: controller.progressPercentage,
            minHeight: 8,
            backgroundColor: const Color(0xFFE0E0E0),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFBCAD3E)),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestionCounter(
    BuildContext context,
    QuizController controller,
  ) {
    return Obx(
      () => RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '${controller.currentQuestionIndex.value + 1}',
              style: AppTextStyle.tsBodyMediumBold(
                context,
                const Color(0xFFBCAD3E),
              ),
            ),
            TextSpan(
              text: '/${controller.questions.length}',
              style: AppTextStyle.tsBodyMediumRegular(
                context,
                AppColors.greyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestion(BuildContext context, QuizController controller) {
    return Obx(
      () => controller.currentQuestion != null
          ? Text(
              controller.currentQuestion!.questionText,
              style: AppTextStyle.tsHeadingSmallMedium(
                context,
                AppColors.primaryColor,
              ),
            )
          : const SizedBox(),
    );
  }

  Widget _buildPointsBadge(BuildContext context, QuizController controller) {
    return Align(
      alignment: Alignment.centerRight,
      child: Obx(
        () => Container(
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
                decoration: const BoxDecoration(
                  color: Color(0xFFBCAD3E),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '${controller.currentQuestion?.points ?? 0} Points',
                style: AppTextStyle.tsBodySmallSemibold(
                  context,
                  const Color(0xFFBCAD3E),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptions(BuildContext context, QuizController controller) {
    return Obx(
      () => controller.currentQuestion != null
          ? Column(
              children: List.generate(
                controller.currentQuestion!.options.length,
                (index) {
                  final isSelected = controller.currentSelectedAnswer == index;
                  final isAnswerConfirmed =
                      controller.confirmCount[controller
                          .currentQuestionIndex
                          .value] >
                      0;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: GestureDetector(
                      onTap: !isAnswerConfirmed
                          ? () => controller.selectAnswer(index)
                          : null,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: double.infinity,
                        constraints: const BoxConstraints(minHeight: 68),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryColor
                              : const Color(0xFF8D5293).withValues(alpha: 0.04),
                          borderRadius: BorderRadius.circular(15),
                          border: isAnswerConfirmed && isSelected
                              ? Border.all(
                                  color: AppColors.primaryColor,
                                  width: 2,
                                )
                              : null,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                controller.currentQuestion!.options[index],
                                maxLines: null,
                                style: AppTextStyle.tsBodyMediumSemibold(
                                  context,
                                  isSelected
                                      ? AppColors.whiteColor
                                      : AppColors.blackColor,
                                ),
                              ),
                            ),
                            if (isSelected)
                              Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: const Icon(
                                  Icons.check,
                                  color: AppColors.whiteColor,
                                  size: 20,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          : const SizedBox(),
    );
  }

  Widget _buildBottomBar(BuildContext context, QuizController controller) {
    return Obx(() {
      final isAnswerSelected = controller.currentSelectedAnswer != null;
      final isAnswerConfirmed =
          controller.confirmCount[controller.currentQuestionIndex.value] > 0;

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.blackColor.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Previous button
            if (controller.currentQuestionIndex.value > 0)
              GestureDetector(
                onTap: () => controller.previousQuestion(),
                child: Row(
                  children: [
                    const Icon(
                      Icons.chevron_left,
                      color: AppColors.blackColor,
                      size: 24,
                    ),
                    Text(
                      'Sebelumnya',
                      style: AppTextStyle.tsBodyLargeBold(
                        context,
                        AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              )
            else
              const SizedBox(width: 80),
            // Confirm/Next button
            if (!isAnswerConfirmed)
              ElevatedButton(
                onPressed: isAnswerSelected
                    ? () => controller.confirmAnswer()
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isAnswerSelected
                      ? AppColors.primaryColor
                      : AppColors.greyColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Konfirmasi',
                  style: AppTextStyle.tsBodyLargeBold(
                    context,
                    AppColors.whiteColor,
                  ),
                ),
              )
            else
              GestureDetector(
                onTap: () {
                  if (controller.currentQuestionIndex.value ==
                      controller.questions.length - 1) {
                    controller.submitQuiz();
                  } else {
                    controller.nextQuestion();
                  }
                },
                child: Row(
                  children: [
                    Text(
                      controller.currentQuestionIndex.value ==
                              controller.questions.length - 1
                          ? 'Selesai'
                          : 'Lanjut',
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
    });
  }
}
