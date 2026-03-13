import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:path_earn_app/features/quiz/data/models/question_model.dart';
import 'package:path_earn_app/features/quiz/data/models/quiz_result_model.dart';

class QuizService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Get quiz questions for specific stage and section
  Future<List<Question>> getQuizQuestions(int stage, int section) async {
    try {
      final response = await _supabase
          .from('lms_quiz_questions')
          .select()
          .eq('stage', stage)
          .eq('section', section)
          .order('id', ascending: true);

      return (response as List)
          .map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch quiz questions: $e');
    }
  }

  // Save quiz result to database
  Future<void> saveQuizResult(String userId, QuizResult result) async {
    try {
      await _supabase.from('user_quiz_results').insert({
        'user_id': userId,
        'correct': result.correctCount.toString(),
        'wrong': result.wrongCount.toString(),
        'skipped': result.emptyCount.toString(),
        'score': result.totalScore.toString(),
        'submitted_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      // Log error but don't throw - MVP prioritizes showing results
      print('Warning: Could not save quiz result to database: $e');
    }
  }

  // Update user progress/course progress
  Future<void> updateUserProgress(
    String userId,
    int stage,
    int section,
    int scorePercentage,
  ) async {
    try {
      final String courseType = switch (stage) {
        1 => 'study_path',
        2 => 'training_path',
        3 => 'contribute_path',
        _ => 'study_path',
      };

      final double progress =
          (scorePercentage / 100.0).clamp(0.0, 1.0).toDouble();
      final String status = progress >= 1.0 ? 'Selesai' : 'Sedang Berjalan';

      await _supabase.from('user_course_progress').update({
        'progress': progress,
        'stage': 'Stage $stage',
        'status': status,
      }).match({
        'user_id': userId,
        'course_type': courseType,
      });
    } catch (e) {
      // Log error but don't throw - just silent fail
      print('Warning: Could not update user progress: $e');
    }
  }

  // Get current user ID
  String? getCurrentUserId() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.id;
  }

  // Get mock quiz data for Stage 1 Section 1 (temporary, will be from DB)
  List<Question> getMockQuizQuestions() {
    return [
      Question(
        id: 1,
        questionText:
            'Apa yang dimaksud dengan manajemen dalam konteks bisnis?',
        options: [
          'Proses perencanaan dan pengelolaan sumber daya untuk mencapai tujuan organisasi',
          'Hanya aktivitas pengawasan karyawan saja',
          'Penentuan harga produk secara acak',
          'Proses penjualan produk kepada pelanggan',
          'Aktivitas promosi yang dilakukan di media sosial',
        ],
        correctAnswerIndex: 0,
        points: 5,
      ),
      Question(
        id: 2,
        questionText:
            'Siapa yang umumnya berperan sebagai top manager dalam sebuah perusahaan?',
        options: [
          'Kepala bagian operasional',
          'Direktur Eksekutif (CEO) dan Dewan Direksi',
          'Kepala divisi marketing',
          'Staf administrasi',
          'Asisten manajer',
        ],
        correctAnswerIndex: 1,
        points: 5,
      ),
      Question(
        id: 3,
        questionText:
            'Fungsi manajemen yang pertama dan paling fundamental adalah?',
        options: [
          'Pengorganisasian',
          'Pelaksanaan',
          'Perencanaan',
          'Pengawasan',
          'Evaluasi',
        ],
        correctAnswerIndex: 2,
        points: 5,
      ),
      Question(
        id: 4,
        questionText:
            'Apa yang disebut dengan SMART dalam konteks penetapan tujuan bisnis?',
        options: [
          'Sistem manajemen dan pelaporan terbaru',
          'Specific, Measurable, Achievable, Relevant, dan Time-bound',
          'Strategi marketing dan advertising terpadu',
          'Sistem monitoring aktivitas risiko terkini',
          'Struktur manajemen untuk audit dan review',
        ],
        correctAnswerIndex: 1,
        points: 5,
      ),
      Question(
        id: 5,
        questionText:
            'Dalam teori manajemen Fayol, ada berapa jumlah fungsi manajemen utama?',
        options: [
          'Tiga fungsi',
          'Empat fungsi',
          'Lima fungsi',
          'Enam fungsi',
          'Tujuh fungsi',
        ],
        correctAnswerIndex: 2,
        points: 5,
      ),
    ];
  }
}
