import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';
import 'package:path_earn_app/routes/app_routes.dart';
import 'package:path_earn_app/core/widgets/app_drawer.dart';
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
                    width: 220.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 4.w,
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
                        Icon(
                          Icons.bolt,
                          color: AppColors.secondaryColor,
                          size: 24.sp,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi",
                        style: TextStyle(
                          fontSize: 28.sp,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Obx(
                        () => Text(
                          "${controller.userName.value}!",
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Badge Placeholder
                  Container(
                    width: 70.w,
                    height: 70.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300], // Placeholder
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.verified,
                      color: AppColors.greyColor,
                      size: 36.sp,
                    ),
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
                ),
              ),
              SizedBox(height: 16.h),
              Obx(
                () => _buildStageCard(
                  title: "Training\nPath",
                  stage: controller.trainingStage.value,
                  status: controller.trainingStatus.value,
                  progress: controller.trainingProgress.value,
                  backgroundColor: AppColors.greyColor,
                  textColor: Colors.white,
                  progressColor: Colors.grey[300]!,
                  isLocked: controller.trainingLocked.value,
                ),
              ),
              SizedBox(height: 16.h),
              Obx(
                () => _buildStageCard(
                  title: "Contribute\nPath",
                  stage: controller.contributeStage.value,
                  status: controller.contributeStatus.value,
                  progress: controller.contributeProgress.value,
                  backgroundColor: const Color(0xFF555555), // Darker grey
                  textColor: Colors.white,
                  progressColor: Colors.grey[400]!,
                  isLocked: controller.contributeLocked.value,
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
  }) {
    return Container(
      width: double.infinity,
      height: 180.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Stack(
        children: [
          // Content
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    height: 1.1,
                  ),
                ),
                const Spacer(),
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
                  height: 16.h,
                  decoration: BoxDecoration(
                    color: Colors.black12,
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
                            fontSize: 10.sp,
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
          // Illustration Placeholder (Right side)
          Positioned(
            right: 20.w,
            top: 20.h,
            child: Container(
              width: 80.w,
              height: 80.w,
              // color: Colors.white24, // Placeholder
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
    );
  }
}
