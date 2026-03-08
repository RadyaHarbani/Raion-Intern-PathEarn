import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:path_earn_app/features/auth/data/services/auth_service.dart';
import 'package:path_earn_app/features/personal-data/data/services/personal_data_service.dart';
import 'package:path_earn_app/routes/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  RxBool isPasswordVisible = false.obs;
  RxBool isLoading = false.obs;

  final AuthService _authService = AuthService();
  final PersonalDataService _personalDataService = PersonalDataService();

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();

    emailController.addListener(() {
      // Trigger UI update when email text changes
      update();
    });

    passwordController.addListener(() {
      // Trigger UI update when password text changes
      update();
    });
  }

  @override
  void onClose() {
    // emailController.dispose();
    // passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    /// For Email Validation
    if (email.isEmpty) {
      Get.snackbar('Error', 'Email is required');
      return;
    }

    if (!validateEmail(email)) {
      Get.snackbar('Error', 'Invalid email format');
      return;
    }

    /// For Password Validation
    if (password.isEmpty) {
      Get.snackbar('Error', 'Password is required');
      return;
    }

    if (password.length < 8) {
      Get.snackbar('Error', 'Password must be at least 8 characters');
      return;
    }

    try {
      isLoading.value = true;

      final response = await _authService.signInWithEmail(email, password);

      if (response.user != null) {
        final userId = response.user!.id;
        final hasData = await _personalDataService.hasPersonalData(userId);

        if (hasData) {
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.offAllNamed(Routes.PERSONALDATA);
        }

        Get.snackbar('Sukses', 'Login berhasil');
      }
    } catch (e) {
      if (e is AuthException) {
        if (e.message.contains('Invalid login credentials')) {
          Get.snackbar('Error', 'Invalid email or password');
        }
      } else {
        Get.snackbar('Error', 'Login failed: ${e.toString()}');
      }
    } finally {
      isLoading.value = false;
    }
  }
}
