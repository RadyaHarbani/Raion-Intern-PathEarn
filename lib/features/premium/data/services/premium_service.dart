import 'package:supabase_flutter/supabase_flutter.dart';

class PremiumService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Upgrade user to premium
  Future<void> upgradeToPremium(String userId) async {
    try {
      await _supabase
          .from('user')
          .update({'is_premium': true})
          .eq('id', userId);
    } catch (e) {
      throw Exception('Failed to upgrade to premium: $e');
    }
  }

  // Check if user is premium
  Future<bool> isPremiumUser(String userId) async {
    try {
      final response = await _supabase
          .from('user')
          .select('is_premium')
          .eq('id', userId)
          .single();
      return response['is_premium'] ?? false;
    } catch (e) {
      throw Exception('Failed to check premium status: $e');
    }
  }

  // Get current user ID
  String? getCurrentUserId() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.id;
  }
}
