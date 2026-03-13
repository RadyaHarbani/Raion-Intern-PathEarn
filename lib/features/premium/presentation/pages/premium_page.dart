import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';
import 'package:path_earn_app/core/constants/app_text_style.dart';
import 'package:path_earn_app/core/widgets/app_drawer.dart';
import 'package:path_earn_app/features/premium/presentation/controllers/premium_controller.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize PremiumController
    final controller = Get.put(PremiumController());

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      drawer: const AppDrawer(),
      body: Builder(
        builder: (context) {
          return Column(
            children: [
              _buildHeader(context),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        blurRadius: 20,
                        offset: Offset(0, -10),
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 40,
                    ),
                    child: Obx(
                      () => Column(
                        children: [
                          _buildPremiumCard(
                            context: context,
                            gradientColors: [
                              Color(0xFFFFA800),
                              Color(0xFFFAE653),
                            ],
                            price: '29.000/Bulan',
                            border: Border.all(
                              color: Color(0xFFBCA605),
                              width: 2,
                            ),
                            onTap: () => controller.upgradeToPremium(),
                            isLoading: controller.isLoading.value,
                            isPremium: controller.isPremium.value,
                          ),
                          const SizedBox(height: 24),
                          _buildPremiumCard(
                            context: context,
                            gradientColors: [
                              Color(0xFF8D5293),
                              Color(0xFFCD93D8),
                            ],
                            price: '280.000/3 Bulan',
                            border: Border.all(
                              color: Color(0xFF8F05BC),
                              width: 2,
                            ),
                            onTap: () => controller.upgradeToPremium(),
                            isLoading: controller.isLoading.value,
                            isPremium: controller.isPremium.value,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget _buildHeader(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top + 16,
      left: 24,
      right: 0,
      bottom: 29,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Kiri: profile + teks
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: CircleAvatar(
                  radius: 26,
                  backgroundColor: AppColors.whiteColor.withValues(alpha: 0.3),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Akselerasi Path-mu',
                style: AppTextStyle.tsBodyLargeRegular(
                  context,
                  AppColors.whiteColor,
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Ke Level',
                      style: AppTextStyle.tsHeadingLargeBold(
                        context,
                        AppColors.whiteColor,
                      ),
                    ),
                    TextSpan(
                      text: '\nProfesional!',
                      style: AppTextStyle.tsHeadingLargeBold(
                        context,
                        AppColors.whiteColor,
                      ).copyWith(height: .95),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // Kanan: gambar SVG
        Transform.translate(
          offset: const Offset(20, 29),
          child: SvgPicture.asset(
            'assets/images/premium_page.svg',
            height: 190,
            fit: BoxFit.contain,
          ),
        ),
      ],
    ),
  );
}

Widget _buildPremiumCard({
  required BuildContext context,
  required List<Color> gradientColors,
  required String price,
  Border? border,
  required VoidCallback onTap,
  required bool isLoading,
  required bool isPremium,
}) {
  final features = [
    'Unlimited Battery',
    'Lanjutkan Path-mu',
    'Dapatkan Sertifikasi',
  ];
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: gradientColors,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(20),
      border: border,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Premium',
              style: AppTextStyle.tsTitleLargeBold(
                context,
                AppColors.whiteColor,
              ),
            ),
            // Badge to show premium status
            if (isPremium)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'PREMIUM',
                  style: AppTextStyle.tsBodySmallBold(
                    context,
                    AppColors.primaryColor,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 20),
        // feature list
        ...features.map(
          (feature) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              children: [
                const Icon(Icons.check, color: AppColors.whiteColor, size: 18),
                const SizedBox(width: 8),
                Text(
                  feature,
                  style: AppTextStyle.tsBodyMediumBold(
                    context,
                    AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 23),
        // price button with loading
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isPremium ? null : (isLoading ? null : onTap),
            style: ElevatedButton.styleFrom(
              backgroundColor: isPremium
                  ? AppColors.whiteColor.withValues(alpha: 0.5)
                  : AppColors.whiteColor,
              foregroundColor: AppColors.primaryColor,
              disabledBackgroundColor: AppColors.whiteColor.withValues(
                alpha: 0.5,
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: isLoading
                ? LoadingAnimationWidget.discreteCircle(
                    size: 20,
                    secondRingColor: AppColors.primaryColor,
                    thirdRingColor: AppColors.primaryColor.withValues(
                      alpha: 0.5,
                    ),
                    color: AppColors.primaryColor,
                  )
                : Text(
                    isPremium ? 'Sudah Premium' : price,
                    style: AppTextStyle.tsBodyLargeBold(
                      context,
                      AppColors.primaryColor,
                    ),
                  ),
          ),
        ),
      ],
    ),
  );
}
