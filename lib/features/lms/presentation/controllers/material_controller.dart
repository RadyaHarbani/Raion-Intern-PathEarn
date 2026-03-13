import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path_earn_app/routes/app_routes.dart';

class MaterialController extends GetxController {
  late final String itemId;
  late final String title;
  late final String? pdfUrl;
  late final String? videoUrl;
  late final String sectionId;
  late final int orderNum;

  final RxString signedPdfUrl = ''.obs;
  final RxBool isLoadingPdf = false.obs;
  final RxBool isSearchingNextVideo = false.obs;

  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  void onInit() {
    super.onInit();
    itemId = Get.arguments?['item_id'] as String? ?? '';
    title = Get.arguments?['title'] as String? ?? 'Material';
    pdfUrl = Get.arguments?['pdf_url'] as String?;
    videoUrl = Get.arguments?['video_url'] as String?;
    sectionId = Get.arguments?['section_id'] as String? ?? '';
    orderNum = Get.arguments?['order_num'] as int? ?? 0;

    print('📄 MaterialController initialized');
    print('📄 itemId: $itemId');
    print('📄 title: $title');
    print('📄 pdfUrl: $pdfUrl');
    print('📄 videoUrl: $videoUrl');
    print('📄 sectionId: $sectionId');
    print('📄 orderNum: $orderNum');

    // Generate signed URL jika pdfUrl ada
    if (pdfUrl != null && pdfUrl!.isNotEmpty) {
      generateSignedUrl();
    }
  }

  Future<void> generateSignedUrl() async {
    isLoadingPdf.value = true;
    try {
      if (pdfUrl != null && pdfUrl!.isNotEmpty) {
        print('📄 Using PDF URL from Supabase: $pdfUrl');
        signedPdfUrl.value = pdfUrl!;
        print('✓ PDF URL ready: ${signedPdfUrl.value}');
      }
    } catch (e) {
      print('❌ Error: $e');
    } finally {
      isLoadingPdf.value = false;
    }
  }

  /// Cari item video BERIKUTNYA di section yang sama
  Future<void> navigateToNextVideo() async {
    print('📄 🎥 Searching for next video item...');
    isSearchingNextVideo.value = true;

    try {
      // Fetch item SETELAH current item (order_num lebih besar) yang item_type = video
      final result = await _supabase
          .from('lms_items')
          .select('id, title, video_url, order_num, section_id')
          .eq('section_id', sectionId)
          .eq('item_type', 'video')
          .gt('order_num', orderNum)
          .order('order_num')
          .limit(1);

      print('📄 🎥 Query result: $result');

      if (result.isNotEmpty) {
        final videoData = result.first;
        final nextVideoId = videoData['id'] as String;
        final nextVideoTitle = videoData['title'] as String;
        final nextVideoUrl = videoData['video_url'] as String?;

        print('📄 🎥 Found next video: $nextVideoTitle');
        print('📄 🎥 Video URL: $nextVideoUrl');

        // Navigate ke VIDEO page
        Get.toNamed(
          Routes.VIDEO,
          arguments: {
            'item_id': nextVideoId,
            'title': nextVideoTitle,
            'video_url': nextVideoUrl,
          },
        );
      } else {
        print('⚠️ Tidak ada video berikutnya di section ini');
        Get.snackbar('Info', 'Tidak ada video berikutnya');
      }
    } catch (e) {
      print('❌ Error searching video: $e');
      Get.snackbar('Error', 'Gagal mencari video: $e');
    } finally {
      isSearchingNextVideo.value = false;
    }
  }
}
