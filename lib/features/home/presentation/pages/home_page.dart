import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
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
                          // Get.toNamed(Routes.PROFILE);
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
                          child: Stack(
                            children: [
                              // Progress Bar Background
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                              ),
                              // Progress Bar Fill
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  return Obx(
                                    () => Container(
                                      width:
                                          constraints.maxWidth *
                                          (controller.energy.value /
                                              controller.maxEnergy),
                                      decoration: BoxDecoration(
                                        color: AppColors.secondaryColor,
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                      ),
                                      child: Center(
                                        child: Obx(
                                          () => Text(
                                            "${controller.energy.value}/${controller.maxEnergy}",
                                            style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
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
                      Obx(
                        () => Text(
                          "${controller.userName.value}!",
                          style: AppTextStyle.tsHeadingLargeBold(
                            context,
                            AppColors.primaryColor,
                          ).copyWith(height: 0.8),
                        ),
                      ),
                    ],
                  ),
                  // Badge Placeholder
                  Obx(
                    () => controller.isPremium.value
                        ? SvgPicture.asset(
                            "assets/images/premiumBadge.svg",
                            height: 80.h,
                            width: 80.w,
                          )
                        : SvgPicture.asset(
                            "assets/images/unpremiumBadge.svg",
                            height: 80.h,
                            width: 80.w,
                          ), // Empty placeholder for alignment
                  ),
                ],
              ),
              SizedBox(height: 32.h),

              // 3. Carousel Section
              CarouselSlider(
                options: CarouselOptions(
                  height: 200.h,
                  viewportFraction: 1,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 4),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  enlargeCenterPage: false,
                  onPageChanged: (index, reason) {
                    controller.currentBanner.value = index;
                  },
                ),
                items: controller.banners.map((imagePath) {
                  return Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      image: DecorationImage(
                        image: AssetImage(imagePath),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }).toList(),
              ),

              SizedBox(height: 12.h),
              // Dots Indicator
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(controller.banners.length, (index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      width: controller.currentBanner.value == index
                          ? 20.w
                          : 8.w,
                      height: 8.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: controller.currentBanner.value == index
                            ? AppColors.primaryColor
                            : Colors.grey[300],
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 32.h),

              // 4. Stages Section
              Obx(
                () => _buildStageCard(
                  title: "Study\nPath",
                  stage: controller.studyStage.value,
                  status: controller.studyStatus.value,
                  progress: controller.studyProgress.value,
                  backgroundColor: AppColors.primaryColor,
                  textColor: Colors.white,
                  progressColor: AppColors.secondaryColor,
                  isLocked: controller.studyLocked.value,
                  stageId: controller.studyStageId.value,
                ),
              ),
              SizedBox(height: 16.h),
              Obx(
                () => _buildStageCard(
                  title: "Training\nPath",
                  stage: controller.trainingStage.value,
                  status: controller.trainingStatus.value,
                  progress: controller.trainingProgress.value,
                  backgroundColor: AppColors.primaryColor,
                  textColor: Colors.white,
                  progressColor: AppColors.secondaryColor,
                  isLocked: controller.trainingLocked.value,
                  stageId: controller.trainingStageId.value,
                ),
              ),
              SizedBox(height: 16.h),
              Obx(
                () => _buildStageCard(
                  title: "Contribute\nPath",
                  stage: controller.contributeStage.value,
                  status: controller.contributeStatus.value,
                  progress: controller.contributeProgress.value,
                  backgroundColor: AppColors.primaryColor,
                  textColor: Colors.white,
                  progressColor: AppColors.secondaryColor,
                  isLocked: controller.contributeLocked.value,
                  stageId: controller.contributeStageId.value,
                ),
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
    required String stageId,
  }) {
    return GestureDetector(
      onTap: () {
        print('🏠 Stage card tapped: $title');
        print('🏠 stageId value: $stageId');
        print('🏠 isLocked: $isLocked');
        if (!isLocked) {
          print('🏠 Navigating to stage with stageId: $stageId');
          Get.toNamed(Routes.STAGE, arguments: {'stage_id': stageId});
        } else {
          print('🏠 Stage is locked, cannot navigate');
        }
      },
      child: Container(
        width: double.infinity,
        height: 190.h,
        decoration: BoxDecoration(
          color: isLocked ? AppColors.greyColor : backgroundColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Stack(
          children: [
            // Illustration Placeholder (Right side)
            Positioned(
              right: 0,
              top: 0,
              child: isLocked
                  ? SizedBox.shrink()
                  : title == "Study\nPath"
                  ? SvgPicture.asset("assets/images/studyPath.svg")
                  : title == "Training\nPath"
                  ? SvgPicture.asset("assets/images/trainingPath.svg")
                  : SvgPicture.asset("assets/images/contributePath.svg"),
            ),

            // Content
            Positioned(
              bottom: 0,
              child: Container(
                width: 340.w,

                decoration: BoxDecoration(
                  color: isLocked
                      ? AppColors.greyColor.withOpacity(0.8)
                      : Color.alphaBlend(
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
                          color: isLocked
                              ? AppColors.whiteColor.withOpacity(0.3)
                              : Color.alphaBlend(
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
