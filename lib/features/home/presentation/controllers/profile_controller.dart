import 'package:get/get.dart';
import 'package:path_earn_app/features/auth/data/services/auth_service.dart';
import 'package:path_earn_app/features/home/data/services/home_service.dart';

class ProfileController extends GetxController {
  final HomeService _homeService = HomeService();
  final AuthService _authService = AuthService();

  RxString nama = ''.obs;
  RxString pendidikan = ''.obs;
  RxString jurusan = ''.obs;
  RxString email = ''.obs;
  RxString birthDate = ''.obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    try {
      isLoading.value = true;

      final userId = _authService.getCurrentUserId();
      if (userId == null) return;

      final profileData = await _homeService.getProfileData(userId);

      if (profileData != null) {
        nama.value = profileData['name'] ?? '';
        pendidikan.value = profileData['pendidikan_terakhir'] ?? '';
        jurusan.value = profileData['jurusan'] ?? '';
        email.value = profileData['email'] ?? '';
        birthDate.value = profileData['birth_date'] ?? '';
      }
    } catch (e) {
      print('Error loading profile: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
