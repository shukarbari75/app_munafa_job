import 'package:app_munafa_job/controllers/jobs_controller.dart';
import 'package:app_munafa_job/core/constant/colors/app_colors.dart';
import 'package:app_munafa_job/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../core/utils/extensions/mediaquery_extension.dart';

class JobsScreen extends StatelessWidget {
  const JobsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JobsController());
    final currencyFormat =
        NumberFormat.currency(symbol: '\$',decimalDigits: 2);


    final filterOptions = ['All', 'Active', 'Pending', 'Completed', 'Cancelled'];

    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar Area
            Padding(
              padding: EdgeInsets.fromLTRB(
                context.widthPct(0.05),
                context.heightPct(0.015),
                context.widthPct(0.05),
                0,
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
                            'Job Ledger',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textHeading,
                            ),
                          ),
                          Obx(
                                () => Text(
                              '${controller.jobs.length} Total Jobs Tracked',
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                          onPressed: () => Get.toNamed(AppRoutes.addJob), 
                          icon: Icon(Icons.add_rounded, size: 16),
                          label: Text(
                            'Add job',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColors,
                          foregroundColor: AppColors.white,
                          elevation: 0,
                          padding: EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 14),
                  // Search Bar

                TextField(
                    onChanged: controller.setSearchQuery,
                    style: GoogleFonts.ibmPlexSans(
                      fontSize: 14,
                      color: AppColors.textHeading,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search jobs, clients, or #JOB ID...',
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: AppColors.textHeading,
                      ),
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        size: 20,
                        color: AppColors.iconGrey,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 11,
                      ),
                      filled: true,
                      fillColor: AppColors.cardBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.borderColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppColors.primaryColors,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 14),
                //   Filter Chip

                  SizedBox(
                    height: 34,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        separatorBuilder:  (context, index) => const SizedBox(width: 8) ,
                        itemCount: filterOptions.length,
                        itemBuilder: (BuildContext context, int index) {
                          final filter = filterOptions[index];
                          return Obx((){
                            final isSelected =
                                controller.selectedFilter.value == filter;
                            return GestureDetector(
                              onTap: () => controller.setFilter(filter),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.textHeading
                                      : AppColors.cardBackground,
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.textHeading
                                        : AppColors.borderColor,
                                  ),
                                ),
                                child: Text(
                                  filter,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? AppColors.white
                                        : AppColors.textBody,
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            // Jobs List View
              Expanded(
                  child: Obx(() {
                    final jobs = controller.filteredJobs;

                    if (jobs.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.inbox_outlined,
                              size: 48,
                              color: AppColors.textHint.withValues(alpha: 0.6),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No jobs found for this filter',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textHeading,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.separated(
                      padding: EdgeInsets.fromLTRB(
                        context.widthPct(0.05),
                        6,
                        context.widthPct(0.05),
                        context.heightPct(0.12),
                      ),
                      physics: const BouncingScrollPhysics(),
                      itemCount: jobs.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final job = jobs[index];
                        return _buildJobDetailCard(context, job, currencyFormat);
                      },
                    );
                  }),
              ),

          ],
        ),
      ),
    );
  }

  Widget _buildJobDetailCard(
      BuildContext context,
      TradeJob job,
      NumberFormat currencyFormat,

    ) {
    Color statusBg;
    Color statusColor;

    switch (job.status) {
      case JobStatus.active:
        statusBg = AppColors.primaryColors.withValues(alpha: 0.12);
        statusColor = AppColors.primaryColors;
        break;
      case JobStatus.pending:
        statusBg = AppColors.warning.withValues(alpha: 0.12);
        statusColor = AppColors.warning;
        break;
      case JobStatus.completed:
        statusBg = AppColors.success.withValues(alpha: 0.12);
        statusColor = AppColors.success;
        break;
      case JobStatus.cancelled:
        statusBg = AppColors.error.withValues(alpha: 0.12);
        statusColor = AppColors.error;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start  ,
        children: [
          // Header: ID + Trade + Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.screenBackground,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      job.id,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textHeading,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    job.tradeCategory,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.secondaryText,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  job.statusDisplay.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          // Title & Client
          Text(
            job.title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textHeading,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Client: ${job.client}',
            style: TextStyle(
              fontSize: 12.5,
              color: AppColors.secondaryText,
            ),
          ),

          SizedBox(height: 12),
          // Costing Details Mini Grid
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cardSecondary,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.dividerColor),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCostItem(context, 'Materials', currencyFormat.format(job.materialsCost)),
                _buildCostItem(context, 'Labor (${job.laborHours.toInt()}h)', currencyFormat.format(job.laborCost)),
                _buildCostItem(context, 'Permits', currencyFormat.format(job.permitsCost)),
              ],
            ),
          ),

          SizedBox(height: 12),
          // Bottom Quote & Profit Ledger Line

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quote: ${currencyFormat.format(job.quotedAmount)}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textBody,
                ),
              ),
              if (job.status == JobStatus.completed || job.status == JobStatus.active)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: (job.isProfitable ? AppColors.success : AppColors.error)
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Net Profit: ${currencyFormat.format(job.netProfit)} (${job.marginPercentage.toStringAsFixed(1)}%)',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: job.isProfitable
                          ? AppColors.success
                          : AppColors.error,
                    ),
                  ),
                )
              else
                Text(
                  'Total Est. Cost: ${currencyFormat.format(job.totalCost)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.secondaryText,
                  ),
                ),

            ],
          )
        ],
      ),
    );

  }

  _buildCostItem(BuildContext context, String label, String value) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: AppColors.secondaryText,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: AppColors.textHeading,
          ),
        ),
      ],
    );
  }
}
