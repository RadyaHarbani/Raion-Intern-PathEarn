import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class PersonalDataService {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<String> uploadFile(File file, String path) async {
    final String fullPath = await _supabase.storage
        .from('documents')
        .upload(
          path,
          file,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
        );
    return _supabase.storage.from('documents').getPublicUrl(path);
  }

  String? getCurrentUserId() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.id;
  }

  Future<bool> hasPersonalData(String userId) async {
    try {
      final data = await _supabase
          .from('user_documents')
          .select('id')
          .eq('user_id', userId)
          .maybeSingle();
      return data != null;
    } catch (e) {
      return false;
    }
  }

  Future<void> createUserDocument({
    required String userId,
    required String ijazahUrl,
    required String cvUrl,
    required String tahunLulus,
    required String pendidikanTerakhir,
    required String jurusan,
  }) async {
    await _supabase.from('user_documents').insert({
      'user_id': userId,
      'ijazah_url': ijazahUrl,
      'cv_url': cvUrl,
      'tahun_lulus': tahunLulus,
      'pendidikan_terakhir': pendidikanTerakhir,
      'jurusan': jurusan,
    });
  }
}
