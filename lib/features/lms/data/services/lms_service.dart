import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/lms_models.dart';

class LmsService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Ambil seluruh sections + items dari satu stage,
  /// lalu merge dengan progress milik [userId].
  Future<LmsStage> getStageWithProgress({
    required String stageId,
    required String userId,
  }) async {
    // 1. Fetch stage
    final stageData = await _supabase
        .from('lms_stages')
        .select()
        .eq('id', stageId)
        .single();

    // 2. Fetch sections milik stage ini, urut by order_num
    final sectionsData = await _supabase
        .from('lms_sections')
        .select()
        .eq('stage_id', stageId)
        .order('order_num');

    // 3. Fetch semua items dari sections di atas
    final sectionIds = sectionsData.map((s) => s['id'] as String).toList();

    final itemsData = sectionIds.isEmpty
        ? []
        : await _supabase
              .from('lms_items')
              .select()
              .inFilter('section_id', sectionIds)
              .order('order_num');

    // 4. Fetch progress user untuk item-item tersebut
    final itemIds = itemsData.map((i) => i['id'] as String).toList();

    final progressData = itemIds.isEmpty
        ? []
        : await _supabase
              .from('user_item_progress')
              .select('item_id, is_completed')
              .eq('user_id', userId)
              .inFilter('item_id', itemIds);

    // Buat set item_id yang sudah completed
    final completedItemIds = {
      for (final p in progressData)
        if (p['is_completed'] == true) p['item_id'] as String,
    };

    // 5. Bangun struktur LmsSection -> LmsItem
    final sections = sectionsData.map((secData) {
      final sectionItems = itemsData
          .where((i) => i['section_id'] == secData['id'])
          .map((itemData) {
            final item = LmsItem.fromMap(Map<String, dynamic>.from(itemData));
            item.isCompleted = completedItemIds.contains(item.id);
            return item;
          })
          .toList();

      sectionItems.sort((a, b) => a.orderNum.compareTo(b.orderNum));
      return LmsSection.fromMap(
        Map<String, dynamic>.from(secData),
        sectionItems,
      );
    }).toList();

    sections.sort((a, b) => a.orderNum.compareTo(b.orderNum));
    return LmsStage.fromMap(Map<String, dynamic>.from(stageData), sections);
  }

  /// Tandai sebuah item sebagai selesai.
  /// Gunakan upsert agar tidak duplikat.
  Future<void> markItemCompleted({
    required String userId,
    required String itemId,
  }) async {
    await _supabase.from('user_item_progress').upsert({
      'user_id': userId,
      'item_id': itemId,
      'is_completed': true,
      'completed_at': DateTime.now().toIso8601String(),
    }, onConflict: 'user_id,item_id');
  }

  /// Kurangi energy user sebesar 1 (minimum 0).
  Future<void> decrementEnergy(String userId) async {
    final data = await _supabase
        .from('user')
        .select('energy')
        .eq('id', userId)
        .maybeSingle();

    if (data == null) return;
    final current = (data['energy'] as int?) ?? 0;
    if (current <= 0) return;

    await _supabase
        .from('user')
        .update({'energy': current - 1})
        .eq('id', userId);
  }

  /// Hitung progress 0.0–1.0 untuk satu stage.
  Future<double> getStageProgress({
    required String userId,
    required String stageId,
  }) async {
    // Total items di stage ini
    final totalResult =
        await _supabase.rpc(
              'count_stage_items',
              params: {'p_stage_id': stageId},
            )
            as int?;

    // Items yang sudah selesai oleh user
    final doneResult =
        await _supabase.rpc(
              'count_stage_items_done',
              params: {'p_stage_id': stageId, 'p_user_id': userId},
            )
            as int?;

    final total = totalResult ?? 0;
    final done = doneResult ?? 0;
    if (total == 0) return 0.0;
    return done / total;
  }
}
