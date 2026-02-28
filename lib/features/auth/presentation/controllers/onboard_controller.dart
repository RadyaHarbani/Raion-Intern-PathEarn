import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_earn_app/routes/app_routes.dart';

class OnboardController extends GetxController {
  late PageController pageController;
  final RxInt currentPage = 0.obs;
  final int totalPages = 3;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void nextPage() {
    if (currentPage.value < totalPages - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (currentPage.value > 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void skipToLogin() {
    Get.offAllNamed(Routes.LOGIN);
  }

  void finishOnboard() {
    Get.offAllNamed(Routes.LOGIN);
  }
}
