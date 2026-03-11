import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';
import 'package:path_earn_app/routes/app_routes.dart';
import '../controllers/profile_controller.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

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
              _buildTopSection(context, controller),
              SafeArea(top: false, child: _buildBottomSection()),
            ],
          ),
        ),
      );
    });
  }
}

Widget _buildTopSection(BuildContext context, ProfileController controller) {
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
          top: 16,
          bottom: 33,
          left: 16,
          right: 16,
        ),
        child: Column(
          children: [
            // const SizedBox(height: 16),
            _BackButton(),
            const SizedBox(height: 16),
            _ProfileAvatar(),
            const SizedBox(height: 16),
            _ProfileName(controller: controller),
            const SizedBox(height: 6),
            _ProfileSubtitle(controller: controller),
            const SizedBox(height: 24),
            _EditProfileButton(),
          ],
        ),
      ),
    ),
  );
}

Widget _buildBottomSection() {
  return Container(
    color: AppColors.primaryColor,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
    child: Column(
      children: [
        _BioCard(),
        const SizedBox(height: 20),
        _MenuCard(),
        const SizedBox(height: 20),
        _LogOutButton(),
        const SizedBox(height: 20),
      ],
    ),
  );
}

class _BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: GestureDetector(
          onTap: () => Navigator.maybePop(context),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.chevron_left, color: Color(0xFF7B2D8B), size: 24),
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
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
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
            child: const Icon(Icons.person, size: 50, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}

class _ProfileName extends StatelessWidget {
  final ProfileController controller;

  const _ProfileName({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        controller.nama.value,
        style: const TextStyle(
          color: Color(0xFF7B2D8B),
          fontSize: 22,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

class _ProfileSubtitle extends StatelessWidget {
  final ProfileController controller;

  const _ProfileSubtitle({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Text(
        controller.pendidikan.value,
        style: const TextStyle(
          color: Color(0xFF9C4DB8),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class _EditProfileButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 44,
      child: ElevatedButton(
        onPressed: () {
          Get.toNamed(Routes.EDITPROFILE);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 2,
        ),
        child: const Text(
          'Edit Profile',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _BioCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BioCardTitle(),
          const SizedBox(height: 8),
          _BioCardContent(),
        ],
      ),
    );
  }
}

class _BioCardTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Bio',
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}

class _BioCardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Text(
      'Lorem ipsum dolor sit amet consectetur. Interdum ullamcorper aliquet mi consequat feugiat velit amet eu. Pellentesque lacus in augue consectetur id scelerisque amet. Elit fringilla quam faucibus morbi amet feugiat nunc morbi. Nec mi nunc magnis justo interdum adipiscing. Eget nisi dolor enim gravida dapibus sem aliquam proin.',
      textAlign: TextAlign.justify,
      style: TextStyle(fontSize: 13, color: Colors.black54, height: 1.6),
    );
  }
}

class _MenuCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: [
          _MenuItem(
            icon: Icons.person_outline,
            label: 'Akun',
            onTap: () {
              // TODO: Navigate to Akun
            },
            showDivider: true,
          ),
          _MenuItem(
            icon: Icons.notifications_none,
            label: 'Notifikasi',
            onTap: () {
              // TODO: Navigate to Notifikasi
            },
            showDivider: true,
          ),
          _MenuItem(
            icon: Icons.business_outlined,
            label: 'Perusahaan',
            onTap: () {
              // TODO: Navigate to Perusahaan
            },
            showDivider: true,
          ),
          _MenuItem(
            icon: Icons.description_outlined,
            label: 'Sertifikat',
            onTap: () {
              // TODO: Navigate to Sertifikat
            },
            showDivider: false,
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool showDivider;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Icon(icon, color: Colors.black54, size: 24),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.black38,
                  size: 22,
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          const Divider(height: 1, thickness: 1, indent: 16, endIndent: 16),
      ],
    );
  }
}

class _LogOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 48,
      child: OutlinedButton(
        onPressed: () {
          // TODO: Handle logout
          _showLogoutDialog(context);
        },
        style: OutlinedButton.styleFrom(
          foregroundColor: const Color(0xFF7B2D8B),
          side: const BorderSide(color: Color(0xFF7B2D8B), width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor: Colors.white,
        ),
        child: const Text(
          'Log Out',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Apakah Anda yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              // TODO: Implement actual logout logic
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7B2D8B),
            ),
            child: const Text(
              'Ya, Keluar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
