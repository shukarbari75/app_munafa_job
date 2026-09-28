import 'package:app_munafa_job/controllers/splash_controller.dart';
import 'package:app_munafa_job/core/constant/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/extensions/mediaquery_extension.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashController());
    return Scaffold(
      backgroundColor: AppColors.appBarColor,
      body: Stack(
        children: [
          // Ambient warm glow behind brand mark
           Positioned(
                 top: context.heightPct(0.3),
                 left: context.widthPct(0.2),
                 right: context.widthPct(0.2),
             child: Container(
                height: context.widthPct(0.6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                      colors: [ AppColors.primaryColors.withValues(alpha: 0.15),
                         Colors.transparent,
                     ]
                  )
                ),
             )
           ),

           //    MAIN CENTER CONTENT

            Center(child: Obx(
               () => AnimatedOpacity(
                 opacity: controller.opacity.value,
                 duration: const Duration(milliseconds: 600),
                 curve: Curves.easeOutCubic,
                 child: Column(
                   mainAxisSize: MainAxisSize.min,
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Container(
                       width: context.scaledFont(72),
                       height: context.scaledFont(72),
                       decoration: BoxDecoration(
                         color: const Color(0xFF1F2B37),
                         borderRadius: BorderRadius.circular(20),
                         border: Border.all(
                           color: AppColors.primaryColors.withValues(alpha: 0.35),
                           width: 1.5,
                         ),
                         boxShadow: [
                           BoxShadow(
                             color: AppColors.primaryColors.withValues(alpha: 0.2),
                             blurRadius: 24,
                             offset: const Offset(0, 8),
                         ),
                         ],
                       ),
                       child: Center(
                           child: Icon(
                               Icons.bar_chart_rounded,
                             size: context.scaledFont(36),
                             color: AppColors.primaryColors,
                           ),
                       ),
                     ),
                      SizedBox(height: context.heightPct(0.028)),

                      //   "Munafa." Wordmark
                      Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Munafa",
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: context.scaledFont(34),
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              TextSpan(
                                text: ".",
                                style: GoogleFonts.spaceGrotesk(
                                  fontSize: context.scaledFont(34),
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryColors,
                                ),
                              ),
                            ],
                          ),
                      ),

                      SizedBox(height:  8),

                     // Tagline
                      Padding(
                        padding: EdgeInsets.symmetric(
                         horizontal: context.widthPct(0.1),
                        ),
                        child: Text(
                         'Know your profit. Before the next quote.',
                         style: GoogleFonts.ibmPlexSans(
                           fontSize: context.scaledFont(13.5),
                           fontWeight: FontWeight.w400,
                           color: const Color(0xFF8D9AA5),
                           letterSpacing: 0.25,
                         ),
                         textAlign: TextAlign.center,
                                             ),
                      )

                   ],
                 ),
               ),
            ),
            ),

            // Bottom subtle ledger tag
            Positioned(
              bottom: context.safePadding.bottom + 24,
                left: 0,
                right: 0,
                child: Obx(
                    () =>  AnimatedOpacity(
                        opacity: controller.opacity.value,
                      duration: const Duration(milliseconds: 600),
                      child: Center(
                        child: Container(
                           padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                  vertical: 4,
                           ),
                           decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.04),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                 color: AppColors.white.withValues(alpha: 0.08),
                                 width: 1,
                              ),
                           ),
                          child: Text(
                            'JOB COSTING FOR TRADES',
                            style: GoogleFonts.spaceGrotesk(
                              fontSize: context.scaledFont(10),
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF6B7785),
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                )
                 )

        ],
      ),
    );
  }
}


