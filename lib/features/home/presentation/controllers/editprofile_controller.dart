import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_earn_app/features/auth/data/services/auth_service.dart';
import 'package:path_earn_app/features/home/data/services/home_service.dart';

class EditProfileController extends GetxController {
  final HomeService _homeService = HomeService();
  final AuthService _authService = AuthService();

  // Controllers
  late TextEditingController namaController;
  late TextEditingController emailController;
  late TextEditingController tanggalLahirController;
  late TextEditingController jurusanController;
  late TextEditingController passwordController;

  RxBool isLoading = true.obs;
  RxBool isSaving = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initControllers();
    loadProfileData();
  }

  void _initControllers() {
    namaController = TextEditingController();
    emailController = TextEditingController();
    tanggalLahirController = TextEditingController();
    jurusanController = TextEditingController();
    passwordController = TextEditingController(text: '••••••••');
  }

  Future<void> loadProfileData() async {
    try {
      isLoading.value = true;

      final userId = _authService.getCurrentUserId();
      if (userId == null) return;

      final profileData = await _homeService.getProfileData(userId);

      if (profileData != null) {
        namaController.text = profileData['name'] ?? '';
        emailController.text = profileData['email'] ?? '';
        tanggalLahirController.text = profileData['birth_date'] ?? '';
        jurusanController.text = profileData['jurusan'] ?? '';
        // Password tetap hidden, jangan isi dari data
      }
    } catch (e) {
      print('Error loading profile: $e');
      Get.snackbar('Error', 'Gagal memuat data profil');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> simpanProfil() async {
    try {
      isSaving.value = true;

      final userId = _authService.getCurrentUserId();
      if (userId == null) {
        Get.snackbar('Error', 'User tidak terautentikasi');
        return;
      }

      // Validasi input
      if (namaController.text.isEmpty) {
        Get.snackbar('Error', 'Nama tidak boleh kosong');
        return;
      }

      if (tanggalLahirController.text.isEmpty) {
        Get.snackbar('Error', 'Tanggal lahir tidak boleh kosong');
        return;
      }

      if (jurusanController.text.isEmpty) {
        Get.snackbar('Error', 'Jurusan tidak boleh kosong');
        return;
      }

      // Update ke Supabase
      await _homeService.updateProfile(
        userId: userId,
        nama: namaController.text,
        birthDate: tanggalLahirController.text,
        jurusan: jurusanController.text,
      );

      Get.snackbar('Sukses', 'Profil berhasil diperbarui');
      Get.back(); // Kembali ke ProfilePage
    } catch (e) {
      print('Error saving profile: $e');
      Get.snackbar('Error', 'Gagal menyimpan profil: $e');
    } finally {
      isSaving.value = false;
    }
  }

  @override
  void onClose() {
    namaController.dispose();
    emailController.dispose();
    tanggalLahirController.dispose();
    jurusanController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
