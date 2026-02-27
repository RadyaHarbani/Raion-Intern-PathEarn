import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';
import 'package:path_earn_app/routes/app_routes.dart';
import 'package:path_earn_app/features/auth/presentation/controllers/register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50.h),
                Image.asset(
                  'assets/icons/ic_Logo.png',
                  width: 80.sp,
                  height: 80.sp,
                ),
                SizedBox(height: 40.h),
              ],
            ),
            Container(
              child: Container(
                margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 5.h),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.r),
                    topRight: Radius.circular(10.r),
                    bottomLeft: Radius.circular(10.r),
                    bottomRight: Radius.circular(10.r),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 24.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Daftar',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ),
                    SizedBox(height: 50.h),
                    TextField(
                      // TODO Controller
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: AppColors.greyColor,
                          fontSize: 14.sp,
                        ),
                        prefixIcon: Icon(
                          Icons.mail_outline,
                          color: AppColors.greyColor,
                        ),
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
                    SizedBox(height: 25.h),
                    Obx(
                      () => TextField(
                        // TODO CONTROLLER
                        controller: controller.passwordController,
                        obscureText: !controller.isPasswordVisible.value,
                        decoration: InputDecoration(
                          hintText: 'Kata sandi',
                          hintStyle: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 14.sp,
                          ),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: AppColors.greyColor,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: controller.togglePasswordVisibility,
                            child: Icon(
                              controller.isPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.greyColor,
                            ),
                          ),
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
                    ),
                    SizedBox(height: 4.h),
                    Obx(
                      () => controller.passwordError.value.isNotEmpty
                          ? Padding(
                              padding: EdgeInsets.only(
                                top: 6.h,
                                left: 4.w,
                                bottom: 10.h,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 2.h),
                                    child: Icon(
                                      Icons.circle,
                                      size: 8.sp,
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(width: 6.w),
                                  Expanded(
                                    child: Text(
                                      controller.passwordError.value,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(height: 21.h),
                    ),
                    Obx(
                      () => TextField(
                        // TODO CONTROLLER
                        controller: controller.confirmPasswordController,
                        obscureText: !controller.isConfirmPasswordVisible.value,
                        decoration: InputDecoration(
                          hintText: 'Konfirmasi kata sandi',
                          hintStyle: TextStyle(
                            color: AppColors.greyColor,
                            fontSize: 14.sp,
                          ),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: AppColors.greyColor,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: controller.toggleConfirmPasswordVisibility,
                            child: Icon(
                              controller.isConfirmPasswordVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppColors.greyColor,
                            ),
                          ),
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
                    ),
                    Obx(
                      () => SizedBox(
                        height: 61.h,
                        child: controller.confirmPasswordError.value.isNotEmpty
                            ? Padding(
                                padding: EdgeInsets.only(top: 6.h, left: 4.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 2.h),
                                      child: Icon(
                                        Icons.circle,
                                        size: 8.sp,
                                        color: Colors.red,
                                      ),
                                    ),
                                    SizedBox(width: 6.w),
                                    Expanded(
                                      child: Text(
                                        controller.confirmPasswordError.value,
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : null,
                      ),
                    ),
                    GetBuilder<RegisterController>(
                      builder: (controller) => SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed:
                              (controller.emailController.text.isEmpty ||
                                  controller.passwordController.text.isEmpty ||
                                  controller
                                      .confirmPasswordController
                                      .text
                                      .isEmpty)
                              ? null
                              : () => controller.register(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            disabledBackgroundColor: AppColors.greyColor,
                          ),
                          child: controller.isLoading.value
                              ? SizedBox(
                                  height: 20.h,
                                  width: 20.h,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.greyColor,
                                    ),
                                  ),
                                )
                              : Text(
                                  'Daftar',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(height: 19.h),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: 'Sudah memiliki akun? ',
                          style: TextStyle(
                            color: AppColors.blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                          ),
                          children: [
                            TextSpan(
                              text: 'Sudah',
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Get.offNamed(Routes.LOGIN),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Dengan melanjutkan, kamu menyetujui ',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: AppColors.whiteColor,
                  ),
                  children: [
                    TextSpan(
                      text: 'Syarat dan Ketentuan',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                        color: AppColors.whiteColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {}, // TODO : buka syarat dan ketentuan
                    ),
                    TextSpan(
                      text: ' ini\ndan kamu sudah diberi tahu tentang ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 10.sp,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    TextSpan(
                      text: 'Kebijakan Privasi',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {}, // TODO : buka kebijakan privasi
                    ),
                    TextSpan(
                      text: ' kami.',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
