import 'package:get/get.dart';
import '../controllers/stage_controller.dart';

class StageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StageController>(StageController());
  }
}
