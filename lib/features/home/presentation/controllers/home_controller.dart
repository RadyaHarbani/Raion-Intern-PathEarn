import 'dart:async';
import 'package:get/get.dart';
import 'package:path_earn_app/features/auth/data/services/auth_service.dart';
import 'package:path_earn_app/features/home/data/services/home_service.dart';
import 'package:path_earn_app/routes/app_routes.dart';

class HomeController extends GetxController {
  
  final AuthService _authService = AuthService();
  final HomeService _homeService = HomeService();

  // --- User Profile ---
  RxString userName = 'Pengguna'.obs;
  RxBool isPremium = false.obs;

  // --- Energy ---
  RxInt energy = 5.obs;
  final int maxEnergy = 5;
  // 4.8 jam = 4 jam 48 menit = 288 menit = 17280 detik
  final Duration restoreInterval = const Duration(hours: 4, minutes: 48);

  // --- Course Progress ---
  RxDouble studyProgress = 0.0.obs;
  RxString studyStage = 'Stage 1'.obs;
  RxString studyStatus = 'Belum Dimulai'.obs;
  RxBool studyLocked = false.obs;
  RxString studyStageId = ''.obs;

  RxDouble trainingProgress = 0.0.obs;
  RxString trainingStage = 'Stage 2'.obs;
  RxString trainingStatus = 'Belum Dimulai'.obs;
  RxBool trainingLocked = true.obs;
  RxString trainingStageId = ''.obs;

  RxDouble contributeProgress = 0.0.obs;
  RxString contributeStage = 'Stage 1'.obs;
  RxString contributeStatus = 'Belum Dimulai'.obs;
  RxBool contributeLocked = true.obs;
  RxString contributeStageId = ''.obs;

  Timer? _energyTimer;

  @override
  void onInit() {
    super.onInit();
    _loadAll();
  }

  Future<void> _loadAll() async {
    final userId = _authService.getCurrentUserId();
    if (userId == null) return;

    await _homeService.initCourseProgressIfEmpty(userId);
    await _fetchUserProfile(userId);
    await _fetchCourseProgress(userId);
  }

  Future<void> _fetchUserProfile(String userId) async {
    final data = await _homeService.getUserProfile(userId);
    if (data == null) return;

    userName.value = data['name'] ?? 'Pengguna';
    isPremium.value = data['is_premium'] ?? false;

    final int savedEnergy = data['energy'] ?? maxEnergy;
    final String? lastRestoreStr = data['last_energy_restore'];

    if (lastRestoreStr != null) {
      final DateTime lastRestore = DateTime.parse(lastRestoreStr).toLocal();
      final DateTime now = DateTime.now();
      final Duration elapsed = now.difference(lastRestore);

      // Hitung berapa kali energy bisa restore
      final int restoreCount = elapsed.inSeconds ~/ restoreInterval.inSeconds;

      if (restoreCount > 0 && savedEnergy < maxEnergy) {
        final int newEnergy = (savedEnergy + restoreCount).clamp(0, maxEnergy);
        energy.value = newEnergy;

        // Update ke Supabase jika ada perubahan
        await _homeService.updateEnergy(
          userId: userId,
          energy: newEnergy,
          lastRestore: lastRestore.add(
            restoreInterval * restoreCount.toDouble(),
          ),
        );
      } else {
        energy.value = savedEnergy;
      }
    } else {
      energy.value = savedEnergy;
    }

    // Mulai timer untuk auto-reload setiap 1 menit (opsional, supaya update real-time)
    _startEnergyTimer(userId);
  }

  void _startEnergyTimer(String userId) {
    _energyTimer?.cancel();
    _energyTimer = Timer.periodic(const Duration(minutes: 1), (_) async {
      if (energy.value < maxEnergy) {
        await _fetchUserProfile(userId);
      }
    });
  }

  Future<void> _fetchCourseProgress(String userId) async {
    final list = await _homeService.getCourseProgress(userId);

    // Update progress dari Supabase
    for (final item in list) {
      final type = item['course_type'] as String;
      final double progress = (item['progress'] as num).toDouble();
      final String stage = item['stage'] ?? 'Stage 1';
      final String status = item['status'] ?? 'Belum Dimulai';
      final bool locked = item['is_locked'] ?? true;

      switch (type) {
        case 'study_path':
          studyProgress.value = progress;
          studyStage.value = stage;
          studyStatus.value = status;
          studyLocked.value = locked;
          break;
        case 'training_path':
          trainingProgress.value = progress;
          trainingStage.value = stage;
          trainingStatus.value = status;
          trainingLocked.value = locked;
          break;
        case 'contribute_path':
          contributeProgress.value = progress;
          contributeStage.value = stage;
          contributeStatus.value = status;
          contributeLocked.value = locked;
          break;
      }
    }

    // Ambil stage IDs dari tabel lms_stages (optional - butuh SQL script dijalankan dulu)
    // Wrapped try-catch supaya tidak crash jika tabel belum ada
    try {
      final stageIds = await _homeService.getStageIds();
      studyStageId.value = stageIds['study_path'] ?? '';
      trainingStageId.value = stageIds['training_path'] ?? '';
      contributeStageId.value = stageIds['contribute_path'] ?? '';
    } catch (_) {
      // lms_stages belum dibuat, abaikan
    }
  }

  void logout() async {
    _energyTimer?.cancel();
    await _authService.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onReady() {
    super.onReady();
    _loadAll();
  }

  @override
  void onClose() {
    _energyTimer?.cancel();
    super.onClose();
  }
}
