import 'package:get/get.dart';
import 'package:path_earn_app/features/auth/presentation/controllers/login_controller.dart';
import 'package:path_earn_app/features/auth/presentation/controllers/register_controller.dart';
import 'package:path_earn_app/features/auth/presentation/controllers/splash_controller.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() => SplashController());
  }
}

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}

class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}