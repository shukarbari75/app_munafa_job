import 'dart:async';
import 'package:app_munafa_job/core/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class  SplashController  extends GetxController{
   final RxDouble opacity = 0.0.obs;
   Timer? _navigateTimer;

   @override
   void onInit(){
     super.onInit();
     _startSplashSequence();
   }

   @override
    void onClose(){
     _navigateTimer?.cancel();
      super.onClose();
   }


Future<void> _startSplashSequence() async {
     // 1. Trigger 600ms fade-in animation on load
     await Future.delayed(const Duration(milliseconds: 50));
     opacity.value = 1.0;


     // 2. Check SharedPreferences for onboarding_complete flag
     final prefs = await SharedPreferences.getInstance();
     final bool isOnboardingComplete =
         prefs.getBool('onboarding_complete') ?? false;
     final bool hasSeenBackupSetup = prefs.getBool('backup_setup_seen') ?? false;

     // 3. Clean transition after logo settles in (~1800ms)
     _navigateTimer = Timer(const Duration(milliseconds: 1800), () {
         if(isOnboardingComplete){
           Get.offNamed(
             hasSeenBackupSetup ? AppRoutes.bottomNav : AppRoutes.backupSetup,
           );
         }else{
           Get.offNamed(AppRoutes.onboarding);
         }
     });
   }
}