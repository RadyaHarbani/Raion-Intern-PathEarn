import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_earn_app/features/personal-data/data/services/personal_data_service.dart';
import 'package:path_earn_app/routes/app_routes.dart';

class PersonalDataController extends GetxController {
  final PersonalDataService _personalDataService = PersonalDataService();

  late TextEditingController yearController;
  late TextEditingController educationController;
  late TextEditingController majorController;

  final Rx<File?> selectedCertificationFile = Rx<File?>(null);
  final Rx<File?> selectedCvFile = Rx<File?>(null);

  RxBool isLoading = false.obs;
  final RxString userId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    userId.value = _personalDataService.getCurrentUserId() ?? '';
    yearController = TextEditingController();
    educationController = TextEditingController();
    majorController = TextEditingController();

    // Listen to changes to update UI
    yearController.addListener(() => update());
    educationController.addListener(() => update());
    majorController.addListener(() => update());
  }

  void pickCertificationFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      selectedCertificationFile.value = File(result.files.single.path!);
      update(); // Update UI
    }
  }

  void pickCvFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      selectedCvFile.value = File(result.files.single.path!);
      update(); // Update UI
    }
  }

  Future<void> registerPersonalData() async {
    // Ijazah
    if (selectedCertificationFile.value == null) {
      Get.snackbar('Error', 'Ijazah tidak boleh kosong');
      return;
    }

    // CV
    if (selectedCvFile.value == null) {
      Get.snackbar('Error', 'CV tidak boleh kosong');
      return;
    }

    // Tahun Lulus
    if (yearController.text.isEmpty) {
      Get.snackbar('Error', 'Tahun lulus tidak boleh kosong');
      return;
    }

    // Pendidikan Terakhir
    if (educationController.text.isEmpty) {
      Get.snackbar('Error', 'Pendidikan terakhir tidak boleh kosong');
      return;
    }

    // Jurusan
    if (majorController.text.isEmpty) {
      Get.snackbar('Error', 'Jurusan tidak boleh kosong');
      return;
    }

    try {
      isLoading.value = true;

      final currentUserId = userId.value;
      if (currentUserId.isNotEmpty) {
        // Upload Ijazah
        final ijazahFile = selectedCertificationFile.value!;
        final ijazahPath =
            '$currentUserId/${ijazahFile.path.split(Platform.pathSeparator).last}';
        final ijazahUrl = await _personalDataService.uploadFile(
          ijazahFile,
          ijazahPath,
        );

        // Upload CV
        final cvFile = selectedCvFile.value!;
        final cvPath =
            '$currentUserId/${cvFile.path.split(Platform.pathSeparator).last}';
        final cvUrl = await _personalDataService.uploadFile(cvFile, cvPath);

        await _personalDataService.createUserDocument(
          userId: currentUserId,
          ijazahUrl: ijazahUrl,
          cvUrl: cvUrl,
          tahunLulus: yearController.text.trim(),
          pendidikanTerakhir: educationController.text.trim(),
          jurusan: majorController.text.trim(),
        );

        Get.offAllNamed(Routes.HOME);
      }

      await Future.delayed(Duration(seconds: 1));

      Get.snackbar('Sukses', 'Registrasi berhasil');
    } catch (e) {
      Get.snackbar('Error', 'Registrasi gagal: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    yearController.dispose();
    educationController.dispose();
    majorController.dispose();
  }
}
