import 'package:danceattix/core/app_constants/app_constants.dart';
import 'package:danceattix/core/dependancy_injaction.dart';
import 'package:danceattix/helper/prefs_helper.dart';
import 'package:danceattix/services/socket_services.dart';
import 'package:danceattix/views/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auto_translate/flutter_auto_translate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'core/config/app_route.dart';
import 'core/config/light_themes.dart';

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize translation service
  await TranslationService().init();

  String token = await PrefsHelper.getString(AppConstants.bearerToken);
  if (token.isNotEmpty) {
    await SocketServices.instance.init();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      builder: (context, child) {
        return GetMaterialApp(
          initialBinding: DependencyInjection(),
          title: 'Droke',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splashScreen,
          getPages: AppRoutes.routes,
          theme: AppThemeData.lightThemeData,
          themeMode: ThemeMode.light,
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}
