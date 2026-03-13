import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';
import 'package:path_earn_app/features/lms/data/models/lms_models.dart';
import 'package:path_earn_app/routes/app_routes.dart';
import '../controllers/stage_controller.dart';

class StagePage extends GetView<StageController> {
  const StagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0F6),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: AppColors.primaryColor,
              size: 45.sp,
            ),
          );
        }

        final stage = controller.stage.value;
        if (stage == null) {
          return const Center(child: Text('Data tidak ditemukan'));
        }

        return NestedScrollView(
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
                                      stage.title,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      stage.progress == 1.0
                                          ? 'Selesai'
                                          : stage.progress == 0.0
                                          ? 'Belum Dimulai'
                                          : 'Sedang Berjalan',
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
                                        value: stage.progress,
                                        minHeight: 12.h,
                                        backgroundColor: Colors.white
                                            .withOpacity(0.2),
                                        valueColor: AlwaysStoppedAnimation(
                                          AppColors.secondaryColor,
                                        ),
                                      ),
                                      Text(
                                        "${(stage.progress * 100).toInt()}%",
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
                          stage.subtitle ?? stage.title,
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
                ...stage.sections.asMap().entries.expand((entry) {
                  final idx = entry.key;
                  final section = entry.value;
                  return [
                    if (idx > 0) ...[
                      SizedBox(height: 20.h),
                      _buildDivider(),
                      SizedBox(height: 20.h),
                    ],
                    _buildSection(
                      section: section,
                      sectionTitle: section.title,
                      modules: section.items.map((item) {
                        final isLocked = controller.isItemLocked(section, item);
                        final isLast = item.orderNum == section.items.length;
                        return _buildModuleItem(
                          number: item.orderNum.toString().padLeft(2, '0'),
                          title: item.title,
                          duration: item.duration ?? '',
                          isCompleted: item.isCompleted,
                          isLast: isLast,
                          isLocked: isLocked,
                          onTap: isLocked ? null : () => _navigateToItem(item),
                        );
                      }).toList(),
                    ),
                  ];
                }),
                SizedBox(height: 40.h),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _navigateToItem(LmsItem item) {
    switch (item.itemType) {
      case 'material':
        Get.toNamed(
          Routes.MATERIAL,
          arguments: {
            'item_id': item.id,
            'title': item.title,
            'pdf_url': item.pdfUrl,
          },
        );
        break;
      case 'video':
        Get.toNamed(
          Routes.MATERIAL,
          arguments: {
            'item_id': item.id,
            'title': item.title,
            'video_url': item.videoUrl,
          },
        );
        break;
      case 'quiz':
        Get.toNamed(
          Routes.QUIZ,
          arguments: {'item_id': item.id, 'title': item.title},
        );
        break;
    }
  }

  Widget _buildSection({
    required LmsSection section,
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
    bool isLocked = false,
    VoidCallback? onTap,
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
                  color: isCompleted
                      ? Colors.green
                      : isLocked
                      ? Colors.grey[400]
                      : Colors.grey[300],
                ),
                child: Icon(
                  isLocked ? Icons.lock_outline : Icons.check,
                  color: Colors.white,
                  size: 18.sp,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(width: 2.w, color: Colors.grey[300]),
                ),
            ],
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                margin: EdgeInsets.only(bottom: isLast ? 0 : 24.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: isLocked ? Colors.grey[100] : Colors.grey[200],
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
                        color: isLocked ? Colors.grey : AppColors.primaryColor,
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
                              color: isLocked
                                  ? Colors.grey
                                  : AppColors.primaryColor,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            duration,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: isLocked
                                  ? Colors.grey[400]
                                  : AppColors.primaryColor.withOpacity(0.6),
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
