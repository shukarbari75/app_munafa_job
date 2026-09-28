import 'package:app_munafa_job/controllers/onboarding_controller.dart';
import 'package:app_munafa_job/core/constant/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/extensions/mediaquery_extension.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
          child: Column(
            children: [
              // Top Bar (Munafa Brand Wordmark + Skip Button)
              _buildTopBar(context, controller),

              // Middle Swipeable PageView
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                    onPageChanged: controller.onPageChanged,
                    itemCount: controller.pages.length,
                    itemBuilder: (context, index){
                    return OnboardingPage(
                      data : controller.pages[index],
                      pageIndex: index,
                    );
                    }),
              ),

              // Bottom Section (Indicators + Primary CTA)
              _buildBottomSection(context, controller)
            ],
          ),
      ),
    );
  }
}


Widget _buildTopBar(BuildContext context, OnboardingController controller) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: context.widthPct(0.06),
      vertical: context.heightPct(0.012),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Subtle brand wordmark
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Munafa',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: context.scaledFont(18),
                  fontWeight: FontWeight.w700,
                  color: AppColors.textHeading,
                ),
              ),
              TextSpan(
                text: '.',
                style: GoogleFonts.spaceGrotesk(
                  fontSize: context.scaledFont(18),
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColors,
                ),
              ),
            ],
          ),
        ),

        // Skip Button
        Obx(
              () => AnimatedOpacity(
            opacity: controller.isLastPage ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: IgnorePointer(
              ignoring: controller.isLastPage,
              child: TextButton(
                onPressed: controller.skip,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.textBody,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(
                      color: AppColors.borderColor,
                      width: 1,
                    ),
                  ),
                ),
                child: Text(
                  'Skip',
                  style: GoogleFonts.ibmPlexSans(
                    fontSize: context.scaledFont(13),
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryText,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBottomSection(
    BuildContext context,
    OnboardingController controller,
    ) {
  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: context.widthPct(0.06),
      vertical: context.heightPct(0.024),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Page Indicator Dots
        Obx(
              () => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              controller.pages.length,
                  (index) => _buildDot(
                isActive: controller.currentPage.value == index,
              ),
            ),
          ),
        ),
        SizedBox(height: context.heightPct(0.022)),

        // Primary Full-Width CTA Button (12px radius, Ochre)
        Obx(
              () => SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: controller.nextPage,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColors,
                foregroundColor: AppColors.white,
                elevation: 0,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.isLastPage ? 'Get started' : 'Next',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: context.scaledFont(16),
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                      letterSpacing: 0.3,
                    ),
                  ),
                  if (controller.isLastPage) ...[
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward_rounded,
                      size: 18,
                      color: AppColors.white,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildDot({required bool isActive}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 250),
    margin: const EdgeInsets.symmetric(horizontal: 4),
    width: isActive ? 22 : 8,
    height: 7,
    decoration: BoxDecoration(
      color: isActive ? AppColors.primaryColors : AppColors.borderColor,
      borderRadius: BorderRadius.circular(4),
    ),
  );
}


/// Single reusable OnboardingPage widget with visual trade ledger mockups
class OnboardingPage extends StatelessWidget {
  final OnboardingPageData data;
  final int pageIndex;

  const OnboardingPage({
    super.key,
    required this.data,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.widthPct(0.06)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Top Interactive Trade Ledger Mockup Card (~45-50% height equivalent)
            _buildTradeVisualCard(context),

            SizedBox(height: context.heightPct(0.032)),

            // Category step indicator
            _buildCategoryTag(context),

            SizedBox(height: context.heightPct(0.012)),

            // Heading & Subtext constrained to ~85% width
            SizedBox(
              width: context.widthPct(0.85),
              child: Column(
                children: [
                  Text(
                    data.heading,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: context.scaledFont(22),
                      fontWeight: FontWeight.w600,
                      color: AppColors.textHeading,
                      height: 1.25,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: context.heightPct(0.012)),
                  Text(
                    data.subtext,
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: context.scaledFont(14),
                      fontWeight: FontWeight.w400,
                      color: AppColors.textBody,
                      height: 1.45,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTag(BuildContext context) {
    final tags = [
      '01 / THE PROBLEM',
      '02 / REAL PROFIT',
      '03 / NO BLOAT',
      '04 / SMART SCAN',
    ];
    final tagText = tags[pageIndex.clamp(0, tags.length - 1)];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primaryColors.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        tagText,
        style: GoogleFonts.spaceGrotesk(
          fontSize: context.scaledFont(11),
          fontWeight: FontWeight.w700,
          color: AppColors.primaryColors,
          letterSpacing: 0.8,
        ),
      ),
    );
  }

  Widget _buildTradeVisualCard(BuildContext context) {
    return Container(
      width: double.infinity,
      height: context.heightPct(0.38),
      constraints: const BoxConstraints(maxHeight: 310, minHeight: 220),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderColor, width: 1),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Card Header Bar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.cardSecondary,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.borderColor),
                    ),
                    child: Icon(
                      data.icon,
                      size: 18,
                      color: AppColors.primaryColors,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _getJobTitleForPage(pageIndex),
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: context.scaledFont(12.5),
                      fontWeight: FontWeight.w600,
                      color: AppColors.textHeading,
                    ),
                  ),
                ],
              ),
              _getStatusBadge(context, pageIndex),
            ],
          ),

          const Divider(color: AppColors.dividerColor, height: 20),

          // Dynamic Trade Ledger Content based on screen index
          Expanded(
            child: _buildCardBodyContent(context, pageIndex),
          ),
        ],
      ),
    );
  }

  String _getJobTitleForPage(int index) {
    switch (index) {
      case 0:
        return 'Kitchen Rewire #104';
      case 1:
        return 'Bathroom Plumbing #210';
      case 2:
        return 'HVAC Install #305';
      case 3:
      default:
        return 'Supplier Invoice #8831';
    }
  }

  Widget _getStatusBadge(BuildContext context, int index) {
    switch (index) {
      case 0:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.error.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'LOSS DETECTED',
            style: GoogleFonts.spaceGrotesk(
              fontSize: context.scaledFont(9.5),
              fontWeight: FontWeight.w700,
              color: AppColors.error,
            ),
          ),
        );
      case 1:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.success.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            '+42.2% MARGIN',
            style: GoogleFonts.spaceGrotesk(
              fontSize: context.scaledFont(9.5),
              fontWeight: FontWeight.w700,
              color: AppColors.success,
            ),
          ),
        );
      case 2:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.primaryColors.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'PURE COSTING',
            style: GoogleFonts.spaceGrotesk(
              fontSize: context.scaledFont(9.5),
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColors,
            ),
          ),
        );
      case 3:
      default:
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: AppColors.primaryColors.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'AUTO EXTRACTED',
            style: GoogleFonts.spaceGrotesk(
              fontSize: context.scaledFont(9.5),
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColors,
            ),
          ),
        );
    }
  }

  Widget _buildCardBodyContent(BuildContext context, int index) {
    switch (index) {
    // Screen 1 — The Problem (Spreadsheet trap vs reality)
      case 0:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildLedgerRow(context, 'Quoted Price', '\$4,800.00', isBold: false),
            _buildLedgerRow(context, 'Materials & Permits', '\$2,950.00', isBold: false),
            _buildLedgerRow(context, 'Crew Labor (32 hrs)', '\$1,970.00', isBold: false),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.error.withValues(alpha: 0.25),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Actual Profit Leak:',
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: context.scaledFont(12),
                      fontWeight: FontWeight.w500,
                      color: AppColors.error,
                    ),
                  ),
                  Text(
                    '-\$120.00 Loss',
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: context.scaledFont(13),
                      fontWeight: FontWeight.w700,
                      color: AppColors.error,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

    // Screen 2 — Real Profit Per Job
      case 1:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildLedgerRow(context, 'Client Invoiced', '\$3,200.00', isBold: false),
            _buildLedgerRow(context, 'Job Direct Costs', '-\$1,850.00', isBold: false),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.success.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Actual Net Profit',
                        style: GoogleFonts.ibmPlexSans(
                          fontSize: context.scaledFont(11),
                          fontWeight: FontWeight.w500,
                          color: AppColors.textBody,
                        ),
                      ),
                      Text(
                        '+\$1,350.00',
                        style: GoogleFonts.spaceGrotesk(
                          fontSize: context.scaledFont(18),
                          fontWeight: FontWeight.w700,
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.arrow_upward_rounded,
                      size: 16,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );

    // Screen 3 — No Bloat, Just Job Costing
      case 2:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildFeaturePillRow(context, Icons.check_circle_rounded, 'Materials & Fittings Ledger', '\$840'),
            _buildFeaturePillRow(context, Icons.check_circle_rounded, 'Crew Labor & Hourly Rates', '16 hrs'),
            _buildFeaturePillRow(context, Icons.check_circle_rounded, 'Permits & Waste Allowances', '\$120'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.cardSecondary,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  'Zero complex CRM • Zero dispatch bloat',
                  style: GoogleFonts.ibmPlexSans(
                    fontSize: context.scaledFont(11.5),
                    fontWeight: FontWeight.w500,
                    color: AppColors.secondaryText,
                  ),
                ),
              ),
            ),
          ],
        );

    // Screen 4 — Receipt Scanning & Automatic Math
      case 3:
      default:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildReceiptItemRow(context, '12/2 Romex Wire (250ft)', 'Materials', '\$185.00'),
            _buildReceiptItemRow(context, '200A Main Breaker Box', 'Hardware', '\$240.00'),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                color: AppColors.primaryColors.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.primaryColors.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.bolt_rounded,
                    size: 16,
                    color: AppColors.primaryColors,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      'Matched & allocated to Job #104 in 2s',
                      style: GoogleFonts.ibmPlexSans(
                        fontSize: context.scaledFont(11.5),
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColors,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
    }
  }

  Widget _buildLedgerRow(
      BuildContext context,
      String label,
      String value, {
        required bool isBold,
      }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.ibmPlexSans(
            fontSize: context.scaledFont(12.5),
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            color: AppColors.textBody,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.spaceGrotesk(
            fontSize: context.scaledFont(13),
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            color: AppColors.textHeading,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturePillRow(
      BuildContext context,
      IconData icon,
      String label,
      String val,
      ) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.success),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.ibmPlexSans(
              fontSize: context.scaledFont(12),
              fontWeight: FontWeight.w500,
              color: AppColors.textHeading,
            ),
          ),
        ),
        Text(
          val,
          style: GoogleFonts.spaceGrotesk(
            fontSize: context.scaledFont(12),
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColors,
          ),
        ),
      ],
    );
  }

  Widget _buildReceiptItemRow(
      BuildContext context,
      String item,
      String category,
      String cost,
      ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item,
              style: GoogleFonts.ibmPlexSans(
                fontSize: context.scaledFont(12),
                fontWeight: FontWeight.w600,
                color: AppColors.textHeading,
              ),
            ),
            Text(
              category,
              style: GoogleFonts.ibmPlexSans(
                fontSize: context.scaledFont(10.5),
                color: AppColors.secondaryText,
              ),
            ),
          ],
        ),
        Text(
          cost,
          style: GoogleFonts.spaceGrotesk(
            fontSize: context.scaledFont(13),
            fontWeight: FontWeight.w700,
            color: AppColors.textHeading,
          ),
        ),
      ],
    );
  }
}



