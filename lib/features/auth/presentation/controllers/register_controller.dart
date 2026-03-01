import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_earn_app/features/auth/data/services/auth_service.dart';
import 'package:path_earn_app/routes/app_routes.dart';

class RegisterController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  RxBool isPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;
  RxBool isLoading = false.obs;

  RxString passwordError = ''.obs;
  RxString confirmPasswordError = ''.obs;

  final AuthService _authService = AuthService();

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    emailController.addListener(() => update());

    passwordController.addListener(() {
      _validatePasswordRealtime(passwordController.text);
      if (confirmPasswordController.text.isNotEmpty) {
        _validateConfirmPasswordRealtime(confirmPasswordController.text);
      }
      update();
    });

    confirmPasswordController.addListener(() {
      _validateConfirmPasswordRealtime(confirmPasswordController.text);
      update();
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  bool validatePassword(String password) {
    // Minimal 8 karakter, 1 huruf besar, 1 huruf kecil, 1 angka
    final regex = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{8,}$');
    return regex.hasMatch(password);
  }

  void _validatePasswordRealtime(String password) {
    if (password.isEmpty) {
      passwordError.value = '';
    } else if (!validatePassword(password)) {
      passwordError.value =
          'Kata sandi harus mengandung 1 huruf besar, 1 huruf kecil, & 1 karakter angka. Minimal 8 karakter.';
    } else {
      passwordError.value = '';
    }
  }

  void _validateConfirmPasswordRealtime(String confirmPassword) {
    if (confirmPassword.isEmpty) {
      confirmPasswordError.value = '';
    } else if (confirmPassword != passwordController.text) {
      confirmPasswordError.value = 'Konfirmasi kata sandi tidak cocok.';
    } else {
      confirmPasswordError.value = '';
    }
  }

  Future<void> register() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    // Email
    if (email.isEmpty) {
      // TODO : ubah ke bingkai
      Get.snackbar('Error', 'Email tidak boleh kosong');
      return;
    }
    if (!validateEmail(email)) {
      Get.snackbar('Error', 'Format email tidak valid');
      return;
    }

    // Password
    if (password.isEmpty) {
      Get.snackbar('Error', 'Password tidak boleh kosong');
      return;
    }
    if (!validatePassword(password)) {
      Get.snackbar('Error', 'Password tidak valid');
      return;
    }

    // Confirm Password
    if (confirmPassword.isEmpty) {
      Get.snackbar('Error', 'Konfirmasi password tidak boleh kosong');
      return;
    }
    if (confirmPassword != password) {
      Get.snackbar('Error', 'Konfirmasi password tidak cocok');
      return;
    }

    try {
      isLoading.value = true;

      await _authService.signUpWithEmail(email, password);
      Get.offAllNamed(Routes.LOGIN);

      await Future.delayed(Duration(seconds: 2));

      Get.snackbar('Sukses', 'Registrasi berhasil');
    } catch (e) {
      Get.snackbar('Error', 'Registrasi gagal');
    } finally {
      isLoading.value = false;
    }

    // void navigateToLogin() {
    //   // TODO : navigate to login page
    // }
  }
}
