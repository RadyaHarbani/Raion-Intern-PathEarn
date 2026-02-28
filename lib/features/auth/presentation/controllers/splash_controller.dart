import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_earn_app/routes/app_routes.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> logoOpacity;
  late Animation<double> textOpacity;

  @override
  void onInit() {
    super.onInit();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    logoOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    textOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    controller.forward().whenComplete(() {
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.offAllNamed(Routes.ONBOARD);
      });
    });
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
