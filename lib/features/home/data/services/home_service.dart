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
          'stage': 'Stage 3',
          'status': 'Belum Dimulai',
          'is_locked': true,
        },
      ]);
    }
  }

  Future<Map<String, dynamic>?> getProfileData(String userId) async {
    final userResponse = await _supabase
        .from('user')
        .select('name, email, birth_date')
        .eq('id', userId)
        .maybeSingle();

    if (userResponse == null) return null;

    final docResponse = await _supabase
        .from('user_documents')
        .select('pendidikan_terakhir, jurusan')
        .eq('user_id', userId)
        .maybeSingle();

    return {...userResponse, ...?docResponse};
  }

  Future<void> updateProfile({
    required String userId,
    required String nama,
    required String birthDate,
    required String jurusan,
  }) async {
    // Update user table
    await _supabase
        .from('user')
        .update({'name': nama, 'birth_date': birthDate})
        .eq('id', userId);

    // Update user_documents table - jurusan
    await _supabase
        .from('user_documents')
        .update({'jurusan': jurusan})
        .eq('user_id', userId);
  }

  // Ambil ID tiap stage dari tabel lms_stages
  // Return: {'study_path': uuid, 'training_path': uuid, 'contribute_path': uuid}
  Future<Map<String, String>> getStageIds() async {
    final response = await _supabase
        .from('lms_stage')
        .select('id, order_num, title')
        .order('order_num');

    print('📊 Raw response from lms_stage: $response');
    print('📊 Response type: ${response.runtimeType}');

    final list = List<Map<String, dynamic>>.from(response);
    print('📊 Parsed list: $list');

    final Map<String, String> result = {};
    
    // Map berdasarkan order_num, bukan index
    for (final stage in list) {
      final orderNum = stage['order_num'] as int;
      final id = stage['id'] as String;
      final title = stage['title'] as String;
      
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
        print('📊 Mapped order_num=$orderNum ($title) -> $key = $id');
      }
    }
    
    print('📊 Final result map: $result');
    return result;
  }
}
