import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';
import 'package:path_earn_app/core/constants/app_text_style.dart';
import 'package:path_earn_app/features/auth/presentation/controllers/onboard_controller.dart';

class OnboardPage extends GetView<OnboardController> {
  const OnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_OnboardData> pages = [
      _OnboardData(
        imagePath: 'assets/images/onboard1.png',
        title: 'Selamat Datang',
        description: 'Mulai perjalanan karirmu \nbersama PathEarn hari ini.',
        buttonLabel: 'Lanjut',
      ),
      _OnboardData(
        imagePath: 'assets/images/onboard2.png',
        title: 'Kuasai Skill Bisnis',
        description:
            'Tingkatkan problem-solving &\nkesiapan kerja tanpa biaya mahal.',
        buttonLabel: 'Lanjut',
      ),
      _OnboardData(
        imagePath: 'assets/images/onboard3.png',
        title: 'Mulai Langkahmu!',
        description:
            'Ikuti path, kuasai skill, raih\nsertifikat & peluang karir terbaik.',
        buttonLabel: 'Mulai',
        isLast: true,
      ),
    ];
    return Scaffold(
      backgroundColor: const Color(0xFFF4EEF4),
      body: SafeArea(
        child: Obx(() {
          final page = controller.currentPage.value;
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (page > 0)
                      GestureDetector(
                        onTap: controller.previousPage,
                        child: Row(
                          children: [
                            Icon(
                              Icons.chevron_left,
                              color: AppColors.primaryColor,
                              size: 20.sp,
                            ),
                            Text(
                              'Kembali',
                              style: AppTextStyle.tsBodyMediumMedium(
                                context,
                                AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                    if (page < 2)
                      GestureDetector(
                        onTap: controller.skipToLogin,
                        child: Row(
                          children: [
                            Text(
                              'Skip',
                              style: AppTextStyle.tsBodyMediumMedium(
                                context,
                                AppColors.primaryColor,
                              ),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: AppColors.primaryColor,
                              size: 20.sp,
                            ),
                          ],
                        ),
                      )
                    else
                      const SizedBox.shrink(),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    final data = pages[index];
                    return _OnboardContent(data: data);
                  },
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: List.generate(pages.length, (index) {
              //     return AnimatedContainer(
              //       duration: const Duration(milliseconds: 300),
              //       margin: EdgeInsets.symmetric(horizontal: 4.w),
              //       width: page == index ? 16.w : 8.w,
              //       height: 8.h,
              //       decoration: BoxDecoration(
              //         color: page == index
              //             ? AppColors.primaryColor
              //             : AppColors.primaryColor.withOpacity(0.3),
              //         borderRadius: BorderRadius.circular(4.r),
              //       ),
              //     );
              //   }),
              // ),
              // SizedBox(height: 32.h),
              // Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: page == pages.length - 1
                        ? controller.finishOnboard
                        : controller.nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(12.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          pages[page].buttonLabel,
                          style: AppTextStyle.tsBodyLargeBold(
                            context,
                            AppColors.whiteColor,
                          ),
                        ),
                        if (page == pages.length - 1) ...[
                          SizedBox(width: 6.w),
                          Icon(
                            Icons.chevron_right,
                            color: AppColors.whiteColor,
                            size: 20.sp,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 48.h),
            ],
          );
        }),
      ),
    );
  }
}

class _OnboardContent extends StatelessWidget {
  final _OnboardData data;
  const _OnboardContent({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          SizedBox(height: 48.h),
          SizedBox(
            height: 280.h,
            child: Image.asset(data.imagePath, fit: BoxFit.contain),
          ),
          SizedBox(height: 100.h),
          // Dots
          Obx(() {
            final c = Get.find<OnboardController>();
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  width: c.currentPage.value == index ? 16.w : 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: c.currentPage.value == index
                        ? AppColors.primaryColor
                        : AppColors.primaryColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                );
              }),
            );
          }),
          SizedBox(height: 16.h),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: AppTextStyle.figmaFontsize(context, 30),
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: AppTextStyle.figmaFontsize(context, 16),
              fontWeight: FontWeight.w400,
              color: AppColors.blackColor,
            ),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

class _OnboardData {
  final String imagePath;
  final String title;
  final String description;
  final String buttonLabel;
  final bool isLast;

  _OnboardData({
    required this.imagePath,
    required this.title,
    required this.description,
    required this.buttonLabel,
    this.isLast = false,
  });
}
