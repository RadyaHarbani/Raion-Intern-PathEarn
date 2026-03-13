import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';
import 'package:path_earn_app/core/constants/app_text_style.dart';
import 'package:path_earn_app/features/lms/presentation/controllers/video_controller.dart';

class VideoPage extends GetView<VideoController> {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        leadingWidth: 100.w,
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: InkWell(
            onTap: () => Get.back(),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.whiteColor,
                  size: 14.sp,
                ),
                Text("Kembali", style: TextStyle(color: AppColors.whiteColor)),
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        // Still loading
        if (controller.isLoadingVideo.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: AppColors.whiteColor),
                SizedBox(height: 16.h),
                Text(
                  'Menyiapkan Video...',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          );
        }

        // Video loaded
        if (controller.signedVideoUrl.isNotEmpty) {
          print('🎥 Loading Video: ${controller.signedVideoUrl.value}');
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Text(
                  controller.title,
                  style: AppTextStyle.tsTitleLargeBold(
                    context,
                    AppColors.whiteColor,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.black,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_circle_fill,
                          size: 80.sp,
                          color: AppColors.primaryColor,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Video Player',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'URL: ${controller.signedVideoUrl.value}',
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        // No Video
        return Center(
          child: Text(
            'Tidak ada Video',
            style: TextStyle(color: AppColors.whiteColor, fontSize: 16.sp),
          ),
        );
      }),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            onPressed: () {
              controller.navigateToQuiz();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Lanjut ke Kuis',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.arrow_forward,
                  color: AppColors.whiteColor,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
