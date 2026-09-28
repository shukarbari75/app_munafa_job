
 import 'dart:io';
import 'dart:ui';
import 'package:app_munafa_job/core/constant/colors/app_colors.dart';
import 'package:app_munafa_job/core/utils/extensions/mediaquery_extension.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:upgrader/upgrader.dart';

import '../../controllers/navbar_controller.dart';
import '../../ui/home/home_screen.dart';
import '../../ui/job/jobs_screen.dart';
import '../../ui/reports/reports_screen.dart';
import '../../ui/setting/settings_screen.dart';
import 'custom_dialogbox.dart';


class CustomBottomNavbar  extends StatelessWidget{
   CustomBottomNavbar({super.key});

   final BottomNavController controller =
         Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
     final List<Widget> pages = [
       const HomeScreen(),
       const JobsScreen(),
       const ReportsScreen(),
       const SettingsScreen(),
     ];
     return Obx(() {
       final int currentIndex = controller.currentIndex.value;

       return PopScope(
           canPop: false,
          onPopInvokedWithResult: ((didPop, result) async {
            if (didPop) return;

            await showProfessionalDialog(
              context: context,
              title: "Exit App",
              message: "Are you sure you want to exit Munafa",
              confirmText: "Exit",
              cancelText: "cancel",
              icon: Icons.exit_to_app_rounded,
              onConfirm: () {
                exit(0);
              },
            );
          }),
            child: UpgradeAlert(
               dialogStyle: Platform.isIOS
                   ? UpgradeDialogStyle.cupertino
                   : UpgradeDialogStyle.material,
              upgrader: Upgrader(
                durationUntilAlertAgain: const Duration(hours: 24),
              ),
              child:  Scaffold(
                body: IndexedStack(index: currentIndex,children: pages),

                // Modern floating trades ledger navbar
                bottomNavigationBar: _buildLedgerNavBar(context, currentIndex),

               extendBody:true,
             ),
            ),

       );
     });
  }

  Widget _buildLedgerNavBar(BuildContext context, int currentIndex) {
    return Padding(
        padding:  EdgeInsetsGeometry.fromLTRB(16, 0, 16, 14),
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.appBarColor,
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: AppColors.primaryColors.withValues(alpha: 0.25),
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowColor,
                blurRadius: 16,
                offset: Offset(0, 6),
              )
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            //   home
              _buildNavItem(
                context,
                index : 0,
                currentIndex: currentIndex,
                icon:Icons.grid_view_rounded,
                label:"Home",
              ),

              //   jobs
              _buildNavItem(
                context,
                index: 1 ,
                currentIndex:currentIndex,
                icon:Icons.business_center_outlined,
                label: "Jobs",
              ),

              //   Reports
              _buildNavItem(
                context,
                index: 2,
                currentIndex:currentIndex,
                icon:Icons.bar_chart_rounded,
                label: "Reports",
              ),

              //  Settings
               _buildNavItem(
                context,
                index: 3,
                currentIndex:currentIndex,
                 icon:Icons.tune_rounded,
                 label: "Settings",
                 ),
            ],
          ),
        ),
    );
  }

 Widget _buildNavItem(
    BuildContext context, {
      required int index,
       required int currentIndex,
       required IconData icon,
       required String label,
   }) {
     final bool isSelected = currentIndex == index;
     return GestureDetector(
       onTap: () {
         controller.changeTab(index);
       },
        behavior: HitTestBehavior.opaque,
        child:  AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(
            horizontal: isSelected ? 14 : 10,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColors : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 20,
                color: isSelected ?  AppColors.white : const Color(0xFF8D9AA5),
              ),
              if (isSelected)...[
                 const SizedBox(width: 6),
                Text(
                  label,
                  style: GoogleFonts.spaceGrotesk(
                    color:Colors.white,
                    fontSize: context.scaledFont(12.5),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ],
          ),
        ),
     );
 }

}





