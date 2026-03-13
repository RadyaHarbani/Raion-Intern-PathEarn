import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/lms_models.dart';

class LmsService {
  final SupabaseClient _supabase = Supabase.instance.client;

  /// Ambil seluruh sections + items dari satu stage,
  /// lalu merge dengan progress milik [userId].
  /// Bisa handle stageId sebagai UUID atau course_type (study_path, training_path, etc)
  Future<LmsStage> getStageWithProgress({
    required String stageId,
    required String userId,
  }) async {
    print('🔍 getStageWithProgress: stageId=$stageId, userId=$userId');

    // Tentukan stage ID yang actual (UUID format)
    String actualStageId = stageId;

    // Kalau bukan format UUID (hanya alfanumerik + dash), try map from course_type
    if (!_isUuidFormat(stageId)) {
      print(
        '🔍 stageId bukan UUID format, coba map dari course_type: $stageId',
      );
      try {
        final mapResult = await _getCourseTypeToStageIdMap();
        actualStageId = mapResult[stageId] ?? stageId;
        print('🔍 Mapped $stageId -> $actualStageId');
      } catch (e) {
        print('✗ Error mapping course_type: $e');
        // Tetap gunakan stageId sebagai-nya
      }
    }

    try {
      // 1. Fetch stage
      print('🔍 Querying lms_stage dengan id: $actualStageId');
      final stageDataList = await _supabase
          .from('lms_stage')
          .select()
          .eq('id', actualStageId);

      print('🔍 Stage query returned ${stageDataList.length} items');

      if (stageDataList.isEmpty) {
        print('✗ Stage tidak ditemukan dengan id: $actualStageId');
        throw Exception('Stage tidak ditemukan dengan id: $actualStageId');
      }

      final stageData = stageDataList.first;
      print('🔍 Stage data: $stageData');

      // 2. Fetch sections milik stage ini, urut by order_num
      print('🔍 Querying lms_sections dengan stage_id: $actualStageId');
      final sectionsData = await _supabase
          .from('lms_sections')
          .select()
          .eq('stage_id', actualStageId)
          .order('order_num');
      print('🔍 Sections fetched: ${sectionsData.length} items');

      if (sectionsData.isEmpty) {
        print('⚠️ Tidak ada sections untuk stage $actualStageId');
        // Return stage dengan sections kosong
        return LmsStage.fromMap(Map<String, dynamic>.from(stageData), []);
      }

      print('🔍 Sections data: $sectionsData');

      // 3. Fetch semua items dari sections di atas
      final sectionIds = sectionsData.map((s) => s['id'] as String).toList();
      print('🔍 Section IDs: $sectionIds');

      final itemsData = sectionIds.isEmpty
          ? []
          : await _supabase
                .from('lms_items')
                .select(
                  'id, section_id, order_num, item_type, title, duration, pdf_url, video_url',
                )
                .inFilter('section_id', sectionIds)
                .order('order_num');
      print('🔍 Items fetched: ${itemsData.length} items');

      if (itemsData.isNotEmpty) {
        print('🔍 Items data: $itemsData');
      } else {
        print('⚠️ Tidak ada items untuk sections ini');
      }

      // 4. Fetch progress user untuk item-item tersebut
      final itemIds = itemsData.map((i) => i['id'] as String).toList();

      final progressData = itemIds.isEmpty
          ? []
          : await _supabase
                .from('user_item_progress')
                .select('item_id, is_completed')
                .eq('user_id', userId)
                .inFilter('item_id', itemIds);

      print('🔍 Progress data fetched: ${progressData.length} items');

      // Buat set item_id yang sudah completed
      final completedItemIds = {
        for (final p in progressData)
          if (p['is_completed'] == true) p['item_id'] as String,
      };

      // 5. Bangun struktur LmsSection -> LmsItem
      final sections = sectionsData.map((secData) {
        final sectionId = secData['id'] as String;
        print('🔍 Processing section: $sectionId, title: ${secData['title']}');

        final sectionItems = itemsData
            .where((i) => i['section_id'] == sectionId)
            .map((itemData) {
              print('🔍 Item raw data: $itemData');
              print('🔍   - id: ${itemData['id']}');
              print('🔍   - title: ${itemData['title']}');
              print('🔍   - item_type: ${itemData['item_type']}');
              print('🔍   - pdf_url: ${itemData['pdf_url']}');
              print('🔍   - video_url: ${itemData['video_url']}');

              final item = LmsItem.fromMap(Map<String, dynamic>.from(itemData));
              item.isCompleted = completedItemIds.contains(item.id);

              print(
                '🔍 Mapped item: id=${item.id}, title=${item.title}, videoUrl=${item.videoUrl}',
              );
              return item;
            })
            .toList();

        print('🔍 Section $sectionId has ${sectionItems.length} items');

        sectionItems.sort((a, b) => a.orderNum.compareTo(b.orderNum));
        return LmsSection.fromMap(
          Map<String, dynamic>.from(secData),
          sectionItems,
        );
      }).toList();

      sections.sort((a, b) => a.orderNum.compareTo(b.orderNum));
      print('🔍 Final sections: ${sections.length}');
      print('✓ Successfully built LmsStage with title: ${stageData['title']}');
      return LmsStage.fromMap(Map<String, dynamic>.from(stageData), sections);
    } catch (e) {
      print('❌ Error di getStageWithProgress: $e');
      print('❌ Stack trace: ${StackTrace.current}');
      rethrow;
    }
  }

  /// Helper: cek apakah string adalah UUID format
  bool _isUuidFormat(String id) {
    // UUID format: 8-4-4-4-12 hex chars
    final uuidRegex = RegExp(
      r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
      caseSensitive: false,
    );
    return uuidRegex.hasMatch(id);
  }

  /// Helper: map course_type ke stage UUID
  /// Return: {'study_path': uuid, 'training_path': uuid, 'contribute_path': uuid}
  Future<Map<String, String>> _getCourseTypeToStageIdMap() async {
    try {
      final response = await _supabase
          .from('lms_stage')
          .select('id, order_num, title')
          .order('order_num');

      final list = List<Map<String, dynamic>>.from(response);
      final Map<String, String> result = {};

      for (final stage in list) {
        final orderNum = stage['order_num'] as int;
        final id = stage['id'] as String;

        String key = '';
        switch (orderNum) {
          case 1:
            key = 'study_path';
            break;
          case 2:
            key = 'training_path';
            break;
          case 3:
            key = 'contribute_path';
            break;
        }

        if (key.isNotEmpty) {
          result[key] = id;
          print('🔍 Mapped order_num=$orderNum -> $key = $id');
        }
      }

      return result;
    } catch (e) {
      print('✗ Error mapping course_type: $e');
      rethrow;
    }
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
