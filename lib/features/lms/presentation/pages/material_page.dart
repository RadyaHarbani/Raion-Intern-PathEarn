import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';
import 'package:path_earn_app/core/constants/app_text_style.dart';
import 'package:path_earn_app/features/lms/presentation/controllers/material_controller.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class MaterialPage extends GetView<MaterialController> {
  const MaterialPage({super.key});

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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Modul 1: Dasar Problem Solving di Dunia Kerja',
                style: AppTextStyle.tsTitleLargeBold(
                  context,
                  AppColors.whiteColor,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              height: 700.h,
              child: SfPdfViewer.asset('assets/bahasaIndonesia.pdf'),
            ),
          ],
        ),
      ),
    );
  }
}
