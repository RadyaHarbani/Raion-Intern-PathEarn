import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';
import 'package:path_earn_app/core/constants/app_text_style.dart';
import 'package:path_earn_app/features/personal-data/presentation/controllers/personal_data_controller.dart';

class PersonalDataPage extends GetView<PersonalDataController> {
  const PersonalDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),

                /// Back Button
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Row(
                    children: [
                      Icon(
                        Icons.arrow_back_ios_new_outlined,
                        size: 18.sp,
                        color: AppColors.whiteColor,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'Kembali',
                        style: AppTextStyle.tsBodySmallSemibold(
                          context,
                          AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                /// Title
                Text(
                  'Isi Data Dirimu Yuk!',
                  style: AppTextStyle.tsHeadingMediumBold(
                    context,
                    AppColors.whiteColor,
                  ),
                ),

                SizedBox(height: 28.h),

                /// Riwayat Pendidikan
                _SectionCard(
                  title: 'Riwayat Pendidikan',
                  children: [
                    _InputField(
                      label: 'Tahun Lulus',
                      hint: '2025',
                      controller: controller.yearController,
                    ),
                    SizedBox(height: 16.h),
                    _InputField(
                      label: 'Pendidikan Terakhir',
                      hint: 'S1 / Sarjana',
                      controller: controller.educationController,
                    ),
                    SizedBox(height: 16.h),
                    _InputField(
                      label: 'Jurusan',
                      hint: 'Manajemen',
                      controller: controller.majorController,
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                /// Pemberkasan
                _SectionCard(
                  title: 'Pemberkasan',
                  children: [
                    _UploadField(
                      label: 'Soft Copy Ijazah',
                      onTap: controller.pickCertificationFile,
                    ),
                    SizedBox(height: 16.h),
                    _UploadField(
                      label: 'Curriculum Vitae(CV)',
                      onTap: controller.pickCvFile,
                    ),
                  ],
                ),

                SizedBox(height: 40.h),

                /// Button Lanjut
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {},
                    child: Text(
                      'Lanjut',
                      style: AppTextStyle.tsBodyMediumSemibold(
                        context,
                        AppColors.primaryColor,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                /// Disclaimer
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: 'Dengan melanjutkan, kamu menyetujui ',
                      style: AppTextStyle.tsLabelLargeMedium(
                        context,
                        AppColors.whiteColor.withOpacity(0.8),
                      ),
                      children: [
                        TextSpan(
                          text: 'Syarat dan Ketentuan ini',
                          style: AppTextStyle.tsLabelLargeMedium(
                            context,
                            AppColors.whiteColor,
                          ),
                        ),
                        const TextSpan(
                          text: ' dan kamu sudah diberitahu tentang ',
                        ),
                        TextSpan(
                          text: 'Pemberitahuan Privasi kami.',
                          style: AppTextStyle.tsLabelLargeMedium(
                            context,
                            AppColors.whiteColor,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE9E4EA),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.tsBodyLargeSemibold(
              context,
              AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 20.h),
          ...children,
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const _InputField({
    required this.label,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.tsBodyMediumRegular(context, Colors.black),
        ),
        SizedBox(height: 8.h),
        TextField(
          // TODO Controller
          controller: controller,
          decoration: InputDecoration(
            hintText: '$hint',
            hintStyle: TextStyle(color: AppColors.greyColor, fontSize: 14.sp),
            prefixIcon: Icon(Icons.mail_outline, color: AppColors.greyColor),
            filled: true,
            fillColor: Colors.grey[200],
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _UploadField extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _UploadField({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.tsBodyMediumRegular(context, Colors.black),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade500,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.cloud_upload_outlined,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Unggah Media',
                    style: AppTextStyle.tsBodySmallSemibold(
                      context,
                      Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
