import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';
import 'package:path_earn_app/core/constants/app_text_style.dart';
import 'package:path_earn_app/core/widgets/app_drawer.dart';
import 'package:path_earn_app/routes/app_routes.dart';
import '../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0F6), // Light purple/grey background
      drawer: const AppDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Top Section: Profile & Battery
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Profile/Drawer Icon
                  Builder(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        child: Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300], // Placeholder
                          ),
                        ),
                      );
                    },
                  ),
                  // Battery Slider
                  Container(
                    width: 265.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Container(
                                  height: 15.h,
                                  width: constraints.maxWidth * 1.0, // 5/5
                                  decoration: BoxDecoration(
                                    color: AppColors.secondaryColor,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "5/5",
                                      style: AppTextStyle.tsBodySmallSemibold(
                                        context,
                                        AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Transform.rotate(
                          angle: 90 * math.pi / 180,
                          child: Icon(
                            Icons.battery_full_rounded,

                            color: AppColors.secondaryColor,
                            size: 30.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),

              // 2. Greeting Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi",
                        style: AppTextStyle.tsHeadingMediumRegular(
                          context,
                          AppColors.primaryColor,
                        ),
                      ),
                      Text(
                        "Alya Putri!",
                        style: AppTextStyle.tsHeadingLargeBold(
                          context,
                          AppColors.primaryColor,
                        ).copyWith(height: 0.8),
                      ),
                    ],
                  ),
                  // Badge Placeholder
                  SvgPicture.asset(
                    "assets/images/premiumBadge.svg",
                    height: 80.h,
                  ),
                ],
              ),
              SizedBox(height: 32.h),

              // 3. Carousel Section
              Container(
                width: double.infinity,
                height: 200.h,
                decoration: BoxDecoration(
                  color: Colors.grey[400], // Placeholder
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              SizedBox(height: 12.h),
              // Dots Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.w),
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == 0
                          ? AppColors.primaryColor
                          : Colors.grey[300],
                    ),
                  );
                }),
              ),
              SizedBox(height: 32.h),

              // 4. Stages Section
              _buildStageCard(
                title: "Study\nPath",
                stage: "Stage 1",
                status: "Sedang Berjalan",
                progress: 0.7,
                backgroundColor: AppColors.primaryColor,
                textColor: Colors.white,
                progressColor: AppColors.secondaryColor,
                isLocked: false,
              ),
              SizedBox(height: 16.h),
              _buildStageCard(
                title: "Training\nPath",
                stage: "Stage 2",
                status: "Belum Dimulai",
                progress: 0.0,
                backgroundColor: AppColors.greyColor,
                textColor: Colors.white,
                progressColor: Colors.grey[300]!,
                isLocked: true,
              ),
              SizedBox(height: 16.h),
              _buildStageCard(
                title: "Contribute\nPath",
                stage: "Stage 1",
                status: "Belum Dimulai",
                progress: 0.0,
                backgroundColor: const Color(0xFF555555), // Darker grey
                textColor: Colors.white,
                progressColor: Colors.grey[400]!,
                isLocked: true,
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStageCard({
    required String title,
    required String stage,
    required String status,
    required double progress,
    required Color backgroundColor,
    required Color textColor,
    required Color progressColor,
    required bool isLocked,
  }) {
    return GestureDetector(
      onTap: () {
        if (!isLocked) {
          Get.toNamed(Routes.LMS);
        }
      },
      child: Container(
        width: double.infinity,
        height: 190.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Stack(
          children: [
            // Illustration Placeholder (Right side)
            Positioned(
              right: 0,
              top: 0,
              child: SvgPicture.asset("assets/images/studyPath.svg"),
            ),

            // Content
            Positioned(
              bottom: 0,
              child: Container(
                width: 340.w,

                decoration: BoxDecoration(
                  color: Color.alphaBlend(
                    Colors.black.withOpacity(0.3),
                    AppColors.primaryColor,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.r),
                    bottomRight: Radius.circular(16.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            stage,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          Text(
                            status,
                            style: TextStyle(fontSize: 12.sp, color: textColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      // Progress Bar
                      Container(
                        height: 18.h,
                        decoration: BoxDecoration(
                          color: Color.alphaBlend(
                            AppColors.primaryColor.withOpacity(0.3),
                            AppColors.whiteColor,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Stack(
                          children: [
                            if (progress > 0)
                              FractionallySizedBox(
                                widthFactor: progress,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: progressColor,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                              ),
                            Center(
                              child: Text(
                                "${(progress * 100).toInt()}%",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: progress > 0
                                      ? AppColors.primaryColor
                                      : textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                  height: 1.1,
                ),
              ),
            ),

            // Lock Overlay
            if (isLocked)
              Center(
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.lock_outline,
                    color: Colors.black87,
                    size: 32.sp,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
