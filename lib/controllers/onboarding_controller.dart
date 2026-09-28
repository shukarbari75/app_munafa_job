
import 'package:app_munafa_job/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingPageData {
  final IconData icon;
  final String heading;
  final String subtext;

  const OnboardingPageData({
    required this.icon,
    required this.heading,
    required this.subtext,
  });
}

class OnboardingController  extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<OnboardingPageData> pages = const [
    OnboardingPageData(
        icon: Icons.table_chart_outlined,
        heading: "Spreadsheets don't tell you the truth",
        subtext:
        "Materials, labor, permits — by the time you add it all up, you've already moved to the next job.",
    ),
    OnboardingPageData(
      icon: Icons.trending_up_rounded,
      heading: "See your real profit, per job",
      subtext:
      "Not what you invoiced. What you actually made, after everything it cost you.",
    ),
    OnboardingPageData(
      icon: Icons.handyman_outlined,
      heading: "Just job costing. Nothing you won't use.",
      subtext:
      "No CRM, no dispatch, no scheduling you didn't ask for. One thing, done well.",
    ),
    OnboardingPageData(
      icon: Icons.receipt_long_outlined,
      heading: "Snap a receipt. We'll do the math.",
      subtext:
      "Scan supplier invoices and Munafa sorts materials from labor automatically — you just confirm.",
    ),
  ];

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged(int index){
    currentPage.value = index;
  }

  bool get isLastPage => currentPage.value == pages.length -1;

  void nextPage(){
    if(isLastPage){
     completeOnboarding();
    }else{
     pageController.nextPage(
         duration: const Duration(milliseconds: 350),
         curve: Curves.easeInOut,
     );
    }
  }

  void skip() {
    completeOnboarding();
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_complete',true);
    Get.offNamed(AppRoutes.backupSetup);
  }
}
