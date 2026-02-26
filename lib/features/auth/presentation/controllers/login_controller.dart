import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  RxBool isPasswordVisible = false.obs;
  RxBool isLoading = false.obs;

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
    emailController.dispose();
    passwordController.dispose();
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
      // TODO : syarat password
      Get.snackbar('Error', 'Password must be at least 8 characters');
      return;
    }

    try {
      isLoading.value = true;

      // TODO : implement login logic here (e.g., API call)

      await Future.delayed(Duration(seconds: 2));

      Get.snackbar('Success', 'Login successful');
      // TODO : navigate to home page or dashboard
    } catch (e) {
      Get.snackbar('Error', 'Login failed: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void navigateToRegister() {
    // TODO : navigate to register page
    // Get.toNamed(Routes.REGISTER);
  }
}
