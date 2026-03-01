import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;

  // Sign in / log in
  Future<AuthResponse> signInWithEmail(String email, String password) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // Sign up / register
  Future<AuthResponse> signUpWithEmail(String email, String password) async {
    return await _supabase.auth.signUp(email: email, password: password);
  }

  // Sign out / log out
  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  // Get User email
  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
}
