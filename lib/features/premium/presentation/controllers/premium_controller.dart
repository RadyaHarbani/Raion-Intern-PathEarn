import 'package:get/get.dart';
import 'package:path_earn_app/features/premium/data/services/premium_service.dart';

class PremiumController extends GetxController {
  final PremiumService _premiumService = PremiumService();

  // Reactive variables
  var isLoading = false.obs;
  var isPremium = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    checkPremiumStatus();
  }

  // Check if user is premium
  Future<void> checkPremiumStatus() async {
    try {
      final userId = _premiumService.getCurrentUserId();
      if (userId != null) {
        bool premium = await _premiumService.isPremiumUser(userId);
        isPremium.value = premium;
        errorMessage.value = '';
      }
    } catch (e) {
      errorMessage.value = 'Error checking premium status: ${e.toString()}';
      print('Error: $e');
    }
  }

  // Upgrade user to premium
  Future<void> upgradeToPremium() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final userId = _premiumService.getCurrentUserId();
      if (userId == null) {
        errorMessage.value = 'User not logged in';
        isLoading.value = false;
        return;
      }

      // Call service to update is_premium to true
      await _premiumService.upgradeToPremium(userId);

      // Update local state
      isPremium.value = true;
      isLoading.value = false;

      // Show success message
      Get.snackbar(
        'Berhasil!',
        'Anda telah menjadi member premium',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      errorMessage.value = e.toString();
      isLoading.value = false;

      // Show error message
      Get.snackbar(
        'Error',
        'Gagal upgrade ke premium: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      print('Error upgrading to premium: $e');
    }
  }
}
