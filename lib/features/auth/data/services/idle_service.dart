import 'dart:async';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IdleTimerService extends GetxService {
  Timer? _idleTimer;

  static const int idleMinutes = 15;

  void startTimer() {
    _idleTimer?.cancel();
    _idleTimer = Timer(const Duration(minutes: idleMinutes), _logOutUser);
  }

  void resetTimer() {
    startTimer();
  }

  void _logOutUser() {
    Supabase.instance.client.auth.signOut();

    Get.snackbar(
      'Sesi Berakhir',
      'Anda telah logout otomatis karena tidak ada aktivitas',
      snackPosition: SnackPosition.TOP,
    );

    Get.offAllNamed('/login');
  }

  @override
  void onClose() {
    _idleTimer?.cancel();
    super.onClose();
  }
}
