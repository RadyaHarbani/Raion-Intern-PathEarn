import 'package:get/get.dart';
import 'package:path_earn_app/features/lms/presentation/controllers/material_controller.dart';

class MaterialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MaterialController>(
      () => MaterialController(),
    );
  }
}
