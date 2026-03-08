import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';
import '../controllers/lms_controller.dart';

class LmsPage extends GetView<LmsController> {
  const LmsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0F6),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 180.h,
              floating: false,
              pinned: true,
              backgroundColor: const Color(0xFF4A2558),
              elevation: 0,
              leading: GestureDetector(
                onTap: () => Get.back(),
                child: Row(
                  children: [
                    SizedBox(width: 8.w),
                    Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 16.sp,
                    ),
                    Text(
                      "Kembali",
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
              leadingWidth: 100.w,

              bottom: PreferredSize(
                preferredSize: Size.fromHeight(120.h),
                child: Container(
                  width: double.infinity,
                  color: AppColors.primaryColor,
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        color: const Color(0xFF4A2558),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.0.w,
                            vertical: 16.h,
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Stage 1",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "Sedang Berjalan",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),

                              /// PROGRESS BAR
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    LinearProgressIndicator(
                                      value: 0.7,
                                      minHeight: 12.h,
                                      backgroundColor: Colors.white.withOpacity(
                                        0.2,
                                      ),
                                      valueColor: AlwaysStoppedAnimation(
                                        AppColors.secondaryColor,
                                      ),
                                    ),
                                    Text(
                                      "70%",
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        "STAGE 1 - Study Path",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15.h),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(
                sectionTitle: "Section 1",
                modules: [
                  _buildModuleItem(
                    number: "01",
                    title: "Modul 1: Dasar Problem Solving di Dunia Kerja",
                    duration: "45:00 Mins",
                    isCompleted: false,
                    isLast: false,
                  ),
                  _buildModuleItem(
                    number: "02",
                    title: "Video 1: Dasar Problem Solving di Dunia Kerja",
                    duration: "30:00 Mins",
                    isCompleted: false,
                    isLast: false,
                  ),
                  _buildModuleItem(
                    number: "03",
                    title: "Kuis 1: Dasar Problem Solving di Dunia Kerja",
                    duration: "15:00 Mins",
                    isCompleted: false,
                    isLast: true,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              _buildDivider(),
              SizedBox(height: 20.h),
              _buildSection(
                sectionTitle: "Section 2",
                modules: [
                  _buildModuleItem(
                    number: "01",
                    title: "Modul 1: Dasar Problem Solving di Dunia Kerja",
                    duration: "45:00 Mins",
                    isCompleted: false,
                    isLast: false,
                  ),
                  _buildModuleItem(
                    number: "02",
                    title: "Video 1: Dasar Problem Solving di Dunia Kerja",
                    duration: "30:00 Mins",
                    isCompleted: false,
                    isLast: false,
                  ),
                  _buildModuleItem(
                    number: "03",
                    title: "Kuis 1: Dasar Problem Solving di Dunia Kerja",
                    duration: "15:00 Mins",
                    isCompleted: false,
                    isLast: true,
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              _buildDivider(),
              SizedBox(height: 20.h),
              _buildSection(
                sectionTitle: "Section 3",
                modules: [
                  _buildModuleItem(
                    number: "01",
                    title: "Modul 1: Dasar Problem Solving di Dunia Kerja",
                    duration: "45:00 Mins",
                    isCompleted: false,
                    isLast: false,
                  ),
                  _buildModuleItem(
                    number: "02",
                    title: "Video 1: Dasar Problem Solving di Dunia Kerja",
                    duration: "30:00 Mins",
                    isCompleted: false,
                    isLast: false,
                  ),
                  _buildModuleItem(
                    number: "03",
                    title: "Kuis 1: Dasar Problem Solving di Dunia Kerja",
                    duration: "15:00 Mins",
                    isCompleted: false,
                    isLast: true,
                  ),
                ],
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection({
    required String sectionTitle,
    required List<Widget> modules,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(height: 16.h),
        ...modules,
      ],
    );
  }

  Widget _buildModuleItem({
    required String number,
    required String title,
    required String duration,
    required bool isCompleted,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                width: 30.w,
                height: 30.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted ? Colors.green : Colors.grey[300],
                ),
                child: Icon(Icons.check, color: Colors.white, size: 18.sp),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 2.w, color: Colors.grey[300]),
                ),
            ],
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: isLast ? 0 : 24.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Text(
                    number,
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          duration,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.primaryColor.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 6.h,
      decoration: BoxDecoration(
        color: const Color(0xFFE0D0E3),
        borderRadius: BorderRadius.circular(3.r),
      ),
    );
  }
}
