
import 'package:app_munafa_job/core/constant/colors/app_colors.dart';
import 'package:flutter/services.dart';

class AppStatusBar {
  /// Set status bar color and icon brightness globally
  static void setStatusBar() {
     SystemChrome.setSystemUIOverlayStyle(
       SystemUiOverlayStyle(
         statusBarColor: AppColors.primaryColors,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
     );
  }
}