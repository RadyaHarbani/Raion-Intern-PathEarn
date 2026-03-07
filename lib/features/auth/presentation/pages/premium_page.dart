import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_earn_app/core/constants/app_colors.dart';
import 'package:path_earn_app/core/constants/app_text_style.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
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
                  horizontal: 32,
                  vertical: 40,
                ),
                child: Column(
                  children: [
                    _buildPremiumCard(
                      context: context,
                      gradientColors: [Color(0xFFFFA800), Color(0xFFFAE653)],
                      price: '29.000/Bulan',
                      border: Border.all(color: Color(0xFFBCA605), width: 2),
                      imagePath: 'assets/images/prem_card1.svg',
                    ),
                    const SizedBox(height: 24),
                    _buildPremiumCard(
                      context: context,
                      gradientColors: [Color(0xFF8D5293), Color(0xFFCD93D8)],
                      price: '280.000/3 Bulan',
                      border: Border.all(color: Color(0xFF8F05BC), width: 2),
                      imagePath: 'assets/images/prem_card2.svg',
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Yuk Premiumkan Akunmu!',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 16,
        left: 24,
        right: 0,
        bottom: 25,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Kiri: profile + teks
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: AppColors.whiteColor.withOpacity(0.3),
                  child: const Icon(
                    Icons.person,
                    color: AppColors.whiteColor,
                    size: 30,
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
                Text(
                  'Ke Level Profesional!',
                  style: AppTextStyle.tsHeadingLargeBold(
                    context,
                    AppColors.whiteColor,
                  ),
                ),
              ],
            ),
          ),
          // Kanan: gambar SVG
          Transform.translate(
            offset: const Offset(0, 29),
            child: SvgPicture.asset(
              'assets/images/premium_page.svg',
              height: 180,
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
    String? imagePath,
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
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Premium',
                style: AppTextStyle.tsTitleLargeBold(
                  context,
                  AppColors.whiteColor,
                ),
              ),
              const SizedBox(height: 20),
              // feature list
              ...features.map(
                (features) => Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check,
                        color: AppColors.whiteColor,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        features,
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
              //price button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.whiteColor,
                    foregroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    price,
                    style: AppTextStyle.tsBodyLargeBold(
                      context,
                      AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (imagePath != null)
            Positioned(
              right: -12,
              top: -20,
              bottom: 48,
              child: SvgPicture.asset(
                imagePath,
                width: 122,
                fit: BoxFit.contain,
              ),
            ),
        ],
      ),
    );
  }
}
