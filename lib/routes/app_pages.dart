import 'package:get/get.dart';
import 'package:path_earn_app/features/auth/data/services/auth_gate.dart';
import 'package:path_earn_app/features/auth/presentation/bindings/auth_binding.dart';
import 'package:path_earn_app/features/auth/presentation/pages/login_page.dart';
import 'package:path_earn_app/features/auth/presentation/pages/onboard_page.dart';
import 'package:path_earn_app/features/auth/presentation/pages/premium_page.dart';
import 'package:path_earn_app/features/auth/presentation/pages/register_page.dart';
import 'package:path_earn_app/features/auth/presentation/pages/splash_page.dart';
import 'package:path_earn_app/features/personal-data/presentation/bindings/personal_data_binding.dart';
import 'package:path_earn_app/features/personal-data/presentation/pages/personal_data_page.dart';
import 'package:path_earn_app/features/home/presentation/bindings/home_binding.dart';
import 'package:path_earn_app/features/lms/presentation/bindings/lms_binding.dart';
import 'package:path_earn_app/features/lms/presentation/pages/lms_page.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.LMS;

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
    GetPage(name: Routes.PREMIUM, page: () => PremiumPage()),
    GetPage(name: Routes.LMS, page: () => LmsPage(), binding: LmsBinding()),
  ];
}
