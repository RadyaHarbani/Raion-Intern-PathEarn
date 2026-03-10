import 'package:supabase_flutter/supabase_flutter.dart';

class HomeService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Ambil profil user: name, energy, last_energy_restore
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final response = await _supabase
        .from('user')
        .select('name, energy, last_energy_restore')
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
}
