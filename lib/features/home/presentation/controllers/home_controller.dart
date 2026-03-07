import 'package:get/get.dart';
import 'package:path_earn_app/features/auth/data/services/auth_service.dart';
import 'package:path_earn_app/routes/app_routes.dart';

class HomeController extends GetxController {
  // Add any necessary state variables here

  @override
  void onInit() {
    super.onInit();
  }

  void logout() async {
    await AuthService().signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
