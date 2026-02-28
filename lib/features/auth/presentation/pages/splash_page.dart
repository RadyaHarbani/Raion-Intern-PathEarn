import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';
import 'package:path_earn_app/core/constants/app_text_style.dart';
import 'package:path_earn_app/features/auth/presentation/controllers/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FadeTransition(
              opacity: controller.logoOpacity,
              child: Image.asset('assets/icons/icLogo.png'),
            ),
            const SizedBox(height: 20),
            FadeTransition(
              opacity: controller.textOpacity,
              child: Text(
                'PathEarn',
                style: AppTextStyle.tsHeadingLargeBold(
                  context,
                  AppColors.whiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
