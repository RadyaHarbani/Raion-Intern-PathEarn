import 'package:get/get.dart';
import 'package:path_earn_app/routes/app_routes.dart';

class VideoController extends GetxController {
  late final String itemId;
  late final String title;
  late final String? videoUrl;
  final RxString signedVideoUrl = ''.obs;
  final RxBool isLoadingVideo = false.obs;

  @override
  void onInit() {
    super.onInit();
    try {
      itemId = Get.arguments?['item_id'] as String? ?? '';
      title = Get.arguments?['title'] as String? ?? 'Video';
      videoUrl = Get.arguments?['video_url'] as String?;

      print('🎥 VideoController initialized');
      print('🎥 itemId: $itemId');
      print('🎥 title: $title');
      print('🎥 videoUrl: $videoUrl');
      print('🎥 Get.arguments: ${Get.arguments}');

      if (videoUrl != null && videoUrl!.isNotEmpty) {
        generateSignedUrl();
      }
    } catch (e) {
      print('❌ VideoController Error: $e');
      itemId = '';
      title = 'Video';
      videoUrl = null;
    }
  }

  Future<void> generateSignedUrl() async {
    isLoadingVideo.value = true;
    try {
      if (videoUrl != null && videoUrl!.isNotEmpty) {
        print('🎥 Using video URL: $videoUrl');
        signedVideoUrl.value = videoUrl!;
        print('✓ Video URL ready: ${signedVideoUrl.value}');
      }
    } catch (e) {
      print('❌ Error: $e');
    } finally {
      isLoadingVideo.value = false;
    }
  }

  void navigateToQuiz() {
    // Navigate ke quiz page dengan item ID yang sama
    // TODO: Update Routes.QUIZ jika perlu
    Get.toNamed(Routes.QUIZ, arguments: {'item_id': itemId, 'title': title});
  }
}
