import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';
import '../controllers/editprofile_controller.dart';

class EditProfilePage extends GetView<EditProfileController> {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Scaffold(
          backgroundColor: AppColors.primaryColor,
          body: Center(child: CircularProgressIndicator()),
        );
      }

      return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(context),
              SafeArea(top: false, child: _buildFormSection(controller)),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: AppColors.primaryColor,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(165),
          bottomRight: Radius.circular(165),
        ),
        child: Container(
          width: double.infinity,
          color: AppColors.whiteColor,
          padding: const EdgeInsets.only(
            top: 44,
            bottom: 33,
            left: 16,
            right: 16,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.chevron_left,
                        color: Color(0xFF7B2D8B),
                        size: 24,
                      ),
                      Text(
                        'Kembali',
                        style: TextStyle(
                          color: Color(0xFF7B2D8B),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF7B2D8B), width: 3),
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://i.pravatar.cc/150?img=47',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection(EditProfileController controller) {
    return Container(
      color: AppColors.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildTextField(
                  controller: controller.namaController,
                  label: 'Nama',
                  icon: Icons.person_outline,
                  hint: 'Nama',
                  enabled: true,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: controller.emailController,
                  label: 'Email',
                  icon: Icons.email_outlined,
                  hint: 'Email',
                  enabled: false,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: controller.tanggalLahirController,
                  label: 'Tanggal Lahir',
                  icon: Icons.calendar_today_outlined,
                  hint: 'Tanggal Lahir',
                  isDate: true,
                  enabled: true,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: controller.jurusanController,
                  label: 'Jurusan',
                  hint: 'Jurusan',
                  enabled: true,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: controller.passwordController,
                  label: 'Kata Sandi',
                  icon: Icons.lock_outline,
                  hint: 'Masukkan kata sandi',
                  isPassword: true,
                  enabled: false,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Obx(() => _buildSimpanButton(controller)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    IconData? icon,
    bool isPassword = false,
    bool isDate = false,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          readOnly: isDate || !enabled,
          enabled: enabled,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: enabled ? Colors.grey[100] : Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            prefixIcon: icon != null
                ? Icon(icon, color: Colors.grey[400], size: 20)
                : null,
            suffixIcon: isPassword
                ? Icon(
                    Icons.visibility_off_outlined,
                    color: Colors.grey[400],
                    size: 20,
                  )
                : (isDate
                      ? Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[400],
                          size: 16,
                        )
                      : null),
          ),
          onTap: isDate
              ? () async {
                  final pickedDate = await showDatePicker(
                    context: Get.context!,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1980),
                    lastDate: DateTime.now(),
                  );
                  if (pickedDate != null) {
                    controller.text =
                        '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
                  }
                }
              : null,
        ),
      ],
    );
  }

  Widget _buildSimpanButton(EditProfileController controller) {
    return SizedBox(
      width: 160,
      height: 48,
      child: ElevatedButton(
        onPressed: controller.isSaving.value
            ? null
            : () {
                controller.simpanProfil();
              },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 2,
        ),
        child: controller.isSaving.value
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Text(
                'Simpan',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}
