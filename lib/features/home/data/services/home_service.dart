import 'package:supabase_flutter/supabase_flutter.dart';

class HomeService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Ambil profil user: name, energy, last_energy_restore
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final response = await _supabase
        .from('user')
        .select('name, energy, last_energy_restore, is_premium')
        .eq('id', userId)
        .maybeSingle();
    return response;
  }

  // Update energy dan timestamp restore
  Future<void> updateEnergy({
    required String userId,
    required int energy,
    required DateTime lastRestore,
  }) async {
    await _supabase
        .from('user')
        .update({
          'energy': energy,
          'last_energy_restore': lastRestore.toIso8601String(),
        })
        .eq('id', userId);
  }

  // Ambil semua course progress milik user
  Future<List<Map<String, dynamic>>> getCourseProgress(String userId) async {
    final response = await _supabase
        .from('user_course_progress')
        .select()
        .eq('user_id', userId);
    return List<Map<String, dynamic>>.from(response);
  }

  // Insert row default jika user belum punya data progress
  Future<void> initCourseProgressIfEmpty(String userId) async {
    final existing = await _supabase
        .from('user_course_progress')
        .select('id')
        .eq('user_id', userId);

    if (existing.isEmpty) {
      await _supabase.from('user_course_progress').insert([
        {
          'user_id': userId,
          'course_type': 'study_path',
          'progress': 0.0,
          'stage': 'Stage 1',
          'status': 'Belum Dimulai',
          'is_locked': false,
        },
        {
          'user_id': userId,
          'course_type': 'training_path',
          'progress': 0.0,
          'stage': 'Stage 2',
          'status': 'Belum Dimulai',
          'is_locked': true,
        },
        {
          'user_id': userId,
          'course_type': 'contribute_path',
          'progress': 0.0,
          'stage': 'Stage 1',
          'status': 'Belum Dimulai',
          'is_locked': true,
        },
      ]);
    }
  }

  // Ambil ID tiap stage dari tabel lms_stages
  // Return: {'study_path': uuid, 'training_path': uuid, 'contribute_path': uuid}
  Future<Map<String, String>> getStageIds() async {
    final response = await _supabase
        .from('lms_stages')
        .select('id, order_num')
        .order('order_num');

    final list = List<Map<String, dynamic>>.from(response);
    final Map<String, String> result = {};
    const keys = ['study_path', 'training_path', 'contribute_path'];
    for (int i = 0; i < list.length && i < keys.length; i++) {
      result[keys[i]] = list[i]['id'] as String;
    }
    return result;
  }
}
