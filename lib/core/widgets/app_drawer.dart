import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';
import 'package:path_earn_app/features/auth/data/services/auth_service.dart';
import 'package:path_earn_app/routes/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.whiteColor,
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColors.primaryColor),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[300], // Placeholder
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Alya Putri',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: AppColors.primaryColor),
            title: Text(
              'Home',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
            ),
            onTap: () {
              Get.back(); // Close drawer
              // Only navigate if not already on home
              if (Get.currentRoute != Routes.HOME) {
                Get.offAllNamed(Routes.HOME);
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.star, color: AppColors.primaryColor),
            title: Text(
              'Premium',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.blackColor,
              ),
            ),
            onTap: () {
              Get.back(); // Close drawer
              // Only navigate if not already on premium
              if (Get.currentRoute != Routes.PREMIUM) {
                Get.toNamed(Routes.PREMIUM);
              }
            },
          ),
          const Spacer(),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.dangerColor),
            title: Text(
              'Logout',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.dangerColor,
              ),
            ),
            onTap: () async {
              Get.back(); // Close drawer
              await AuthService().signOut();
              Get.offAllNamed(Routes.LOGIN);
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
