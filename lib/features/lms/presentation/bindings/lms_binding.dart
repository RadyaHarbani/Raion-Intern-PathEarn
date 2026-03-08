import 'package:get/get.dart';
import '../controllers/lms_controller.dart';

class LmsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LmsController>(
      () => LmsController(),
    );
  }
}
