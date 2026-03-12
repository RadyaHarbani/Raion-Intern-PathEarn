import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MaterialController extends GetxController {
  late final String itemId;
  late final String title;
  late final String? pdfUrl;
  late final String? videoUrl;
  final RxString signedPdfUrl = ''.obs;
  final RxBool isLoadingPdf = false.obs;

  @override
  void onInit() {
    super.onInit();
    itemId = Get.arguments?['item_id'] as String? ?? '';
    title = Get.arguments?['title'] as String? ?? 'Material';
    pdfUrl = Get.arguments?['pdf_url'] as String?;
    videoUrl = Get.arguments?['video_url'] as String?;

    print('📄 MaterialController initialized');
    print('📄 itemId: $itemId');
    print('📄 title: $title');
    print('📄 pdfUrl: $pdfUrl');
    print('📄 videoUrl: $videoUrl');

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
        // Langsung gunakan URL Supabase public (sudah dalam format yang benar)
        signedPdfUrl.value = pdfUrl!;
        print('✓ PDF URL ready: ${signedPdfUrl.value}');
      }
    } catch (e) {
      print('❌ Error: $e');
    } finally {
      isLoadingPdf.value = false;
    }
  }
}
