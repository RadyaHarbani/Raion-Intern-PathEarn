import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';
import 'package:path_earn_app/core/constants/app_text_style.dart';
import 'package:path_earn_app/features/lms/presentation/controllers/material_controller.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class MaterialPage extends StatefulWidget {
  const MaterialPage({super.key});

  @override
  State<MaterialPage> createState() => _MaterialPageState();
}

class _MaterialPageState extends State<MaterialPage> {
  late MaterialController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<MaterialController>();
  }

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
        if (controller.isLoadingPdf.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: AppColors.whiteColor),
                SizedBox(height: 16.h),
                Text(
                  'Menyiapkan PDF...',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          );
        }

        // PDF loaded
        if (controller.signedPdfUrl.isNotEmpty) {
          print('🔵 Loading PDF: ${controller.signedPdfUrl.value}');
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
                child: SfPdfViewer.network(
                  controller.signedPdfUrl.value,
                  onDocumentLoadFailed: (PdfDocumentLoadFailedDetails details) {
                    print('❌ PDF Load Failed: ${details.error}');
                  },
                ),
              ),
            ],
          );
        }

        // No PDF
        return Center(
          child: Text(
            'Tidak ada PDF',
            style: TextStyle(color: AppColors.whiteColor, fontSize: 16.sp),
          ),
        );
      }),
    );
  }
}
