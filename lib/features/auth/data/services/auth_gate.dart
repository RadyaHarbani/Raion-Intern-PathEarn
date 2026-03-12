import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';
import 'package:path_earn_app/features/home/presentation/pages/home_page.dart';
import 'package:path_earn_app/features/auth/presentation/pages/login_page.dart';
import 'package:path_earn_app/features/personal-data/data/services/personal_data_service.dart';
import 'package:path_earn_app/features/personal-data/presentation/pages/personal_data_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/**
 * 
 * unauthenticated -> login page
 * authenticated -> home page (if personal data exists) or personal data page
 */

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: Supabase.instance.client.auth.onAuthStateChange,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Color(0xFFF5F0F6),
            body: Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: AppColors.primaryColor,
                size: 45.sp,
              ),
            ),
          );
        }

        final session = snapshot.data?.session;

        if (session != null) {
          return FutureBuilder<bool>(
            future: PersonalDataService().hasPersonalData(session.user.id),
            builder: (context, dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  backgroundColor: Color(0xFFF5F0F6),
                  body: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColors.primaryColor,
                      size: 45.sp,
                    ),
                  ),
                );
              }

              if (dataSnapshot.hasData && dataSnapshot.data == true) {
                return const HomePage();
              } else {
                return const PersonalDataPage();
              }
            },
          );
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
