import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path_earn_app/features/lms/data/models/lms_models.dart';
import 'package:path_earn_app/features/lms/data/services/lms_service.dart';

class StageController extends GetxController {
  final LmsService _lmsService = LmsService();

  // State
  final isLoading = true.obs;
  final stage = Rxn<LmsStage>();

  // stageId dikirim dari home page via Get.arguments
  late final String stageId;

  @override
  void onInit() {
    super.onInit();
    stageId = Get.arguments?['stage_id'] as String? ?? '';
    if (stageId.isNotEmpty) _loadStage();
  }

  Future<void> _loadStage() async {
    isLoading.value = true;
    try {
      final userId = Supabase.instance.client.auth.currentUser?.id ?? '';
      final result = await _lmsService.getStageWithProgress(
        stageId: stageId,
        userId: userId,
      );
      stage.value = result;
    } catch (e) {
      // Handle error jika perlu (snackbar dll.)
    } finally {
      isLoading.value = false;
    }
  }

  /// Cek apakah item ini terkunci.
  /// Item pertama di section pertama selalu terbuka.
  /// Item N terkunci jika item N-1 belum selesai.
  /// Section N terkunci jika semua item di section N-1 belum selesai.
  bool isItemLocked(LmsSection section, LmsItem item) {
    final sections = stage.value?.sections ?? [];

    // Cek apakah section sebelumnya sudah selesai
    final sectionIdx = sections.indexWhere((s) => s.id == section.id);
    if (sectionIdx > 0) {
      final prevSection = sections[sectionIdx - 1];
      if (!prevSection.isCompleted) return true;
    }

    // Dalam section: item N terkunci jika item N-1 belum selesai
    final itemIdx = section.items.indexWhere((i) => i.id == item.id);
    if (itemIdx == 0)
      return false; // item pertama selalu terbuka (dalam section)
    return !section.items[itemIdx - 1].isCompleted;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
