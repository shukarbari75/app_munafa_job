import 'package:app_munafa_job/core/config/global_manger.dart';
import 'package:app_munafa_job/core/localization/app_localization.dart';
import 'package:app_munafa_job/core/routes/app_routes.dart';
import 'package:app_munafa_job/core/theme/app_theme.dart';
import 'package:app_munafa_job/ui/startUp/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/constant/colors/app_colors.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Munafa',
      debugShowCheckedModeBanner: false,
     theme: AppTheme.lightTheme,
     navigatorKey: GlobalManger.instance.navigatorKey,

      // Localization Configuration
      translations: AppTranslation(),
      locale: const Locale('en','US'),
      fallbackLocale: const Locale('en', 'US'),
      supportedLocales: AppLocalization.supportedLocale,
      localizationsDelegates: [
        AppLocalization.delegate,
        // GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate,
      ],

     initialRoute: AppRoutes.splash,
      getPages: AppRoutes.getPages,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}




