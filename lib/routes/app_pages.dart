import 'package:get/get.dart';
import 'package:path_earn_app/features/auth/presentation/bindings/auth_binding.dart';
import 'package:path_earn_app/features/auth/presentation/pages/login_page.dart';
import 'package:path_earn_app/features/auth/presentation/pages/register_page.dart';
import 'package:path_earn_app/features/auth/presentation/pages/splash_page.dart';
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
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
  ];
}
