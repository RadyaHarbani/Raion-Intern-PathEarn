import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_earn_app/core/themes/app_theme.dart';
import 'package:path_earn_app/routes/app_pages.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// import 'core/constants/secret_const.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://ljfxporhfdbqcuggblly.supabase.co',
    anonKey: 'sb_publishable_85DLmovlxbMzSFj3za9-1A_n2iHDwb_',
  );
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'PathEarn App',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          // initialBinding: InitialBinding(),
          // TESTING SLICING PAGE
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      },
    );
  }
}
