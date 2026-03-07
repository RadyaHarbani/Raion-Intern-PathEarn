import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalDataController extends GetxController {
  late TextEditingController yearController;
  late TextEditingController educationController;
  late TextEditingController majorController;

  final Rx<File?> selectedCertificationFile = Rx<File?>(null);
  final Rx<File?> selectedCvFile = Rx<File?>(null);

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    yearController = TextEditingController();
    educationController = TextEditingController();
    majorController = TextEditingController();
  }

  void pickCertificationFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      selectedCertificationFile.value = File(result.files.single.path!);
    }
  }

  void pickCvFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      selectedCvFile.value = File(result.files.single.path!);
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
