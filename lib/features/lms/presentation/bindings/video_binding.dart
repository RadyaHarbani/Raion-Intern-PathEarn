import 'package:get/get.dart';
import 'package:path_earn_app/features/lms/presentation/controllers/video_controller.dart';

class VideoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VideoController());
  }
}
