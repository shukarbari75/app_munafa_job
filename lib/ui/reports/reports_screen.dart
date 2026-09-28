import 'package:app_munafa_job/controllers/reports_controller.dart';
import 'package:app_munafa_job/core/constant/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import '../../core/utils/extensions/mediaquery_extension.dart';
class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportsController());
    final timeframes = ['Weekly', 'Monthly', 'Quarterly', 'Yearly'];

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              context.widthPct(0.05),
              context.heightPct(0.015),
              context.widthPct(0.05),
              context.heightPct(0.12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Profit & Loss Reports',
                          style: TextStyle(
                            color: AppColors.textHeading,
                            fontSize: context.scaledFont(22),
                            fontWeight: FontWeight.w700
                          ),
                        ),
                        Text(
                            'True job cost vs quote analytics',
                          style: TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: context.scaledFont(13),
                          ),
                        ),
                      ],
                    ),

                    IconButton(
                        onPressed: controller.exportPDFReport,
                        icon:Icon(Icons.picture_as_pdf_outlined),
                        color: AppColors.primaryColors,
                    ),
                  ],
                ),
                SizedBox(height: 16),


                // Timeframe selector
                Obx(
                    () => Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.borderColor),
                      ),
                      child: Row(
                        children: timeframes.map((tf) {
                          final isSelected =
                              controller.selectedTimeframe.value == tf;
                          return Expanded(
                            child: GestureDetector(
                              onTap: () => controller.setTimeframe(tf),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primaryColors
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  tf,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: context.scaledFont(12),
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? AppColors.white
                                        : AppColors.textBody,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    )
                ),
                SizedBox(height: 20),

                // Hero P&L Summary Card
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.appBarColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowColor,
                        blurRadius: 16,
                        offset: Offset(0, 6),
                      ),
                    ]
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TOTAL NET PROFIT',
                        style: TextStyle(
                          color: Color(0xFF8D9AA5),
                          fontWeight: FontWeight.w600,
                          fontSize: context.scaledFont(12),
                          letterSpacing: 1.0,
                        ),
                      ),
                      SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '+\$6,730.00',
                            style: TextStyle(
                              color: Color(0xFF00C853),
                              fontSize: context.scaledFont(30),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF4EBA80).withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                              child: Text(
                                '40.7% Avg Margin',
                                style: TextStyle(
                                  fontSize: context.scaledFont(11),
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF00C853),
                                ),
                              ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Divider(color: AppColors.white.withValues(alpha: 0.1)),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildReportHeroStat(
                            context,
                            'Total Billed',
                            '\$16,550.00',
                          ),
                          _buildReportHeroStat(
                            context,
                            'Materials',
                            '\$5,820.00',
                          ),
                          _buildReportHeroStat(
                            context,
                            'Labor & Permits',
                            '\$16,550.00',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 24),

                // Cost Distribution Breakdown
                Text(
                  'COST ALLOCATION BREAKDOWN',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontWeight: FontWeight.w600,
                    fontSize: context.scaledFont(13),
                    letterSpacing: 0.8,
                    ),
                ),
                SizedBox(height: 12),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Column(
                    children: [
                      _buildCostBarItem(
                        context,
                        'Material & Supplies',
                        59,
                        '\$5,820.00',
                        colors:  AppColors.primaryColors,
                      ),
                      const SizedBox(height: 14),
                      _buildCostBarItem(
                        context,
                        'Crew Labor',
                        33,
                        '\$3,280.00',
                         colors: Color(0xFF2C5680),
                      ),
                      const SizedBox(height: 14),
                      _buildCostBarItem(
                        context,
                        'Permits & Municipal Fees',
                        8,
                        '\$720.00',
                       colors:  AppColors.warning,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Export CTA Card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardSecondary,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColors.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.download_rounded,
                          color: AppColors.primaryColors,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Export Monthly P&L Ledger',
                              style: TextStyle(
                                fontSize: context.scaledFont(14),
                                fontWeight: FontWeight.w600,
                                color: AppColors.textHeading,
                              ),
                            ),
                            Text(
                              'PDF format for accountants and tax filing.',
                              style: TextStyle(
                                fontSize: context.scaledFont(12),
                                color: AppColors.secondaryText,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: controller.exportPDFReport,
                        child: Text(
                          'Export',
                          style: TextStyle(
                            fontSize: context.scaledFont(13),
                            fontWeight: FontWeight.w700,
                            color: AppColors.primaryColors,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
  }

  Widget _buildReportHeroStat(
      BuildContext context,
      String label,
       String value,
  ) {
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            Text(
              label,
                style: TextStyle(
                  fontSize: context.scaledFont(12),
                  color: const Color(0xFF8D9AA5),
                  fontWeight: FontWeight.w600
                ),
            ),
           const SizedBox(height: 2),
            Text(
               value,
               style: TextStyle(
                 fontSize: context.scaledFont(15),
                 fontWeight: FontWeight.w600,
                 color: AppColors.white,
               ),
            ),
         ],
     );
 }




Widget _buildCostBarItem(
    BuildContext context,
    String title,
    int percentage,
    String amount,
     {required Color colors}
    ) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: context.scaledFont(13),
              fontWeight: FontWeight.w500,
              color: AppColors.textHeading,
            ),
          ),
          Text(
            '$amount ($percentage%)',
            style: TextStyle(
              fontSize: context.scaledFont(13),
              fontWeight: FontWeight.w600,
              color: AppColors.textHeading,
            ),
          ),
        ],
      ),
      const SizedBox(height: 6),
      ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: percentage / 100,
          backgroundColor: AppColors.screenBackground,
          valueColor: AlwaysStoppedAnimation<Color>(colors),
          minHeight: 6,
        ),
      ),
    ],
  );
}
