import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path_earn_app/features/auth/data/services/auth_gate.dart';
import 'package:path_earn_app/features/auth/presentation/bindings/auth_binding.dart';
import 'package:path_earn_app/features/auth/presentation/pages/login_page.dart';
import 'package:path_earn_app/features/auth/presentation/pages/onboard_page.dart';
import 'package:path_earn_app/features/home/presentation/bindings/profile_binding.dart';
import 'package:path_earn_app/features/home/presentation/bindings/editprofile_binding.dart';
import 'package:path_earn_app/features/home/presentation/pages/editprofile_page.dart';
import 'package:path_earn_app/features/home/presentation/pages/profile_page.dart';
import 'package:path_earn_app/features/lms/presentation/bindings/stage_binding.dart';
import 'package:path_earn_app/features/lms/presentation/pages/stage_page.dart';
import 'package:path_earn_app/features/premium/presentation/pages/premium_page.dart';
import 'package:path_earn_app/features/auth/presentation/pages/register_page.dart';
import 'package:path_earn_app/features/auth/presentation/pages/splash_page.dart';
import 'package:path_earn_app/features/lms/presentation/bindings/material_binding.dart';
import 'package:path_earn_app/features/lms/presentation/pages/material_page.dart';
import 'package:path_earn_app/features/lms/presentation/bindings/video_binding.dart';
import 'package:path_earn_app/features/lms/presentation/pages/video_page.dart';
import 'package:path_earn_app/features/personal-data/presentation/bindings/personal_data_binding.dart';
import 'package:path_earn_app/features/personal-data/presentation/pages/personal_data_page.dart';
import 'package:path_earn_app/features/home/presentation/bindings/home_binding.dart';
import 'package:path_earn_app/features/quiz/presentation/pages/quiz_page.dart';

import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.ONBOARD,
      page: () => OnboardPage(),
      binding: OnboardBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 600),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.PERSONALDATA,
      page: () => PersonalDataPage(),
      binding: PersonalDataBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => AuthGate(),
      binding: BindingsBuilder(() {
        HomeBinding().dependencies();
        LoginBinding().dependencies();
      }),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.EDITPROFILE,
      page: () => EditProfilePage(),
      binding: EditProfileBinding(),
    ),
    GetPage(name: Routes.PREMIUM, page: () => PremiumPage()),
    GetPage(
      name: Routes.STAGE,
      page: () => StagePage(),
      binding: StageBinding(),
    ),
    GetPage(
      name: Routes.MATERIAL,
      page: () => MaterialPage(),
      binding: MaterialBinding(),
    ),
    GetPage(
      name: Routes.VIDEO,
      page: () => VideoPage(),
      binding: VideoBinding(),
    ),
    GetPage(name: Routes.QUIZ, page: () => QuizPage()),
  ];
}
