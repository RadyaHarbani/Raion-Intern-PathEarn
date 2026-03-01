import 'package:flutter/material.dart';
import 'package:path_earn_app/features/auth/presentation/pages/home_page.dart';
import 'package:path_earn_app/features/auth/presentation/pages/login_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/**
 * 
 * unauthenticated -> login page
 * authenticated -> home page
 */

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final session = snapshot.hasData ? snapshot.data!.session : null;

        if (session != null) {
          return const HomePage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
