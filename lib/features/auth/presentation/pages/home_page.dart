import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_earn_app/features/auth/data/services/auth_service.dart';
import 'package:path_earn_app/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout() async {
    Get.offAllNamed(Routes.LOGIN);
    await AuthService().signOut();
  }

  /**
   * 
   * FOR TESTING
   * 
   */

  @override
  Widget build(BuildContext context) {
    final currentEmail = AuthService().getCurrentUserEmail();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(currentEmail.toString()),
            ElevatedButton(onPressed: logout, child: Text('Logout')),
          ],
        ),
      ),
    );
  }
}
