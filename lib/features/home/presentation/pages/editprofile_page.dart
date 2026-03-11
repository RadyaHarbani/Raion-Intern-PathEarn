import 'package:flutter/material.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  // late TextEditingController _namaController;
  // late TextEditingController _emailController;
  // late TextEditingController _tanggalLahirController;
  // late TextEditingController _manajemenController;
  // late TextEditingController _kataSandiController;

  @override
  void initState() {
    super.initState();
    // _namaController = TextEditingController();
    // _emailController = TextEditingController();
    // _tanggalLahirController = TextEditingController();
    // _manajemenController = TextEditingController();
    // _kataSandiController = TextEditingController();
  }

  @override
  void dispose() {
    // _namaController.dispose();
    // _emailController.dispose();
    // _tanggalLahirController.dispose();
    // _manajemenController.dispose();
    // _kataSandiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            SafeArea(top: false, child: _buildFormSection()),
          ],
        ),
      ),
    );
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

  Widget _buildFormSection() {
    return Container(
      color: AppColors.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          SizedBox(height: 40),
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
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(
                    // controller: _namaController,
                    label: 'Nama',
                    icon: Icons.person_outline,
                    hint: 'Nama',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    // controller: _emailController,
                    label: 'Email',
                    icon: Icons.email_outlined,
                    hint: 'Email',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    // controller: _tanggalLahirController,
                    label: 'Tanggal Lahir',
                    icon: Icons.calendar_today_outlined,
                    hint: 'Tanggal Lahir',
                    isDate: true,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    // controller: _manajemenController,
                    label: 'Manajemen',
                    hint: 'Manajemen',
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    // controller: _kataSandiController,
                    label: 'Kata Sandi',
                    icon: Icons.lock_outline,
                    hint: 'Masukkan kata sandi',
                    isPassword: true,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildSimpanButton(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildTextField({
    // required TextEditingController controller,
    required String label,
    required String hint,
    IconData? icon,
    bool isPassword = false,
    bool isDate = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          // controller: controller,
          obscureText: isPassword,
          readOnly: isDate,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.grey[100],
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
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1980),
                    lastDate: DateTime.now(),
                  );
                  // TODO: Tampilkan tanggal yang dipilih
                }
              : null,
        ),
      ],
    );
  }

  Widget _buildSimpanButton() {
    return SizedBox(
      width: 160,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // TODO: Implement save logic
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 2,
        ),
        child: const Text(
          'Simpan',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
