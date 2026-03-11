import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_earn_app/features/personal-data/data/services/personal_data_service.dart';
import 'package:path_earn_app/routes/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation<double> logoOpacity;
  late Animation<double> textOpacity;
  final PersonalDataService _personalDataService = PersonalDataService();

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
      Future.delayed(const Duration(milliseconds: 500), () async {
        await _checkAuthAndNavigate();
      });
    });
  }

  Future<void> _checkAuthAndNavigate() async {
    final session = Supabase.instance.client.auth.currentSession;
    if (session != null) {
      final userId = session.user.id;
      final hasData = await _personalDataService.hasPersonalData(userId);

      if (hasData) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.offAllNamed(Routes.PERSONALDATA);
      }
    } else {
      Get.offAllNamed(Routes.ONBOARD);
    }
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
