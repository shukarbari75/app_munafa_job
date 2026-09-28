import 'package:app_munafa_job/controllers/home_controller.dart';
import 'package:app_munafa_job/controllers/jobs_controller.dart';
import 'package:app_munafa_job/core/constant/colors/app_colors.dart';
import 'package:app_munafa_job/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:intl/intl.dart';

import '../../controllers/navbar_controller.dart';
import '../../core/utils/extensions/mediaquery_extension.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    final currencyFormat = NumberFormat.currency(
      symbol: '\$',
      decimalDigits: 0,
    );
    return Scaffold(
      backgroundColor: AppColors.screenBackground ,
      body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              context.widthPct(0.02),
              context.heightPct(0.015),
              context.widthPct(0.02),
              context.heightPct(0.12),
            ),
            child: Column(
              children: [
                _buildHeader(context, controller),
                SizedBox(height: context.heightPct(0.022)),
                _buildFinancialCard(context, controller, currencyFormat),
                SizedBox(height: context.heightPct(0.022)),
                 _buildQuickActions(context ,),
                SizedBox(height: context.heightPct(0.022)),
                 _buildJobStatusGrid(context, controller),
                SizedBox(height: context.heightPct(0.026)),
                _buildRecentJobs(context, controller, currencyFormat),
              ],
            ),
          )
      ),
    );
  }
  // ── Header ────────────────────────────────────────────────────────────────x
 Widget _buildHeader(BuildContext context, HomeController controller) {
       return Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text(
                 controller.greetingMessage,
                 style: TextStyle(
                   fontSize: 15,
                   fontWeight: FontWeight.w500,
                   color: AppColors.secondaryText,
                 ),
               ),
               SizedBox(height: 2),
                Obx(
                  () => Text(
                      controller.userName.value,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textHeading,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
             ],
           ),
           // Notification bell
           Container(
             height: 40,
             width: 40,
             decoration: BoxDecoration(
               color: AppColors.cardBackground,
               shape: BoxShape.circle,
               border: Border.all(color: AppColors.borderColor),
             ),
             child: Stack(
               alignment: Alignment.center,
               children: [
                 Icon(Icons.notifications_none_rounded,
                   size: 23,
                   color: AppColors.textHeading,
                 ),
                 Positioned(
                   top: 9,
                     right: 10,
                     child: Container(
                       width: 7,
                       height: 7,
                       decoration: BoxDecoration(
                         color: AppColors.primaryColors,
                         shape: BoxShape.circle,
                       ),
                     )
                 ),
               ],
             ),
           )
         ],
       );
  }


  // ── Financial Overview Card ─────────────────────────────────────────────────
  Widget _buildFinancialCard(
      BuildContext context,
      HomeController controller,
      NumberFormat fmt,
    ) {
    final periods = ['Daily', 'Weekly', 'Monthly', 'Yearly'];

      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.appBarColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.primaryColors.withValues(alpha: 0.2),
          ),
          boxShadow: [ BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 14,
            offset: Offset(0, 5),
          ),
         ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row: label + dropdown selector
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'NET PROFIT LEDGER',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF8D9AA5),
                    letterSpacing: 0.9,
                  ),
                ),

              // ── Dropdown ───────────────────────────────────────────────
                Obx(
                   () => Container(
                     padding: EdgeInsets.symmetric(
                       horizontal: 10,
                       vertical: 4,
                     ),
                     decoration: BoxDecoration(
                       color: Color(0xFF222F3E),
                       borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                         color: AppColors.primaryColors.withValues(alpha: 0.3),
                       ),
                     ),
                     child: DropdownButton<String>(
                       value: controller.selectedPeriod.value,
                         isDense: true,
                         underline: SizedBox.shrink(),
                         dropdownColor: Color(0xFF222F3E),
                         icon: Icon(Icons.keyboard_arrow_down_rounded,
                          size: 14,
                           color: Color(0xFF8D9AA5),
                         ),
                       style: const TextStyle(
                         fontSize: 12,
                         fontWeight: FontWeight.w600,
                         color: Colors.white,
                       ),
                       items: periods
                          .map (
                           (p) => DropdownMenuItem(
                              value: p,
                               child: Text(p),
                           ),
                       ).toList(),
                       onChanged: (p) {
                         if (p != null) controller.setPeriod(p);
                       } ,
                     ),
                   ),
                  ),
              ]
            ),
         // Net profit + margin badge
            SizedBox(height: 5),
             Obx(
                 () => Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   crossAxisAlignment: CrossAxisAlignment.end,
                   children: [
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           'Net Profit',
                           style: TextStyle(fontSize: 12, color: Color(0xFF8D9AA5),fontWeight: FontWeight.w600),
                         ),
                         SizedBox(height: 4,),
                         Text(
                           fmt.format(controller.netProfit),
                           style: TextStyle(
                             fontSize: 30,
                             fontWeight: FontWeight.w700,
                             color:  controller.isProfitable
                                 ? AppColors.profitBadgeBg
                                 : AppColors.error,
                             letterSpacing: -0.5,
                           ),
                         ),
                       ],
                     ),
                     Container(
                       padding: EdgeInsets.symmetric(
                         horizontal: 9,
                         vertical: 5,
                       ),
                       decoration: BoxDecoration(
                         color: AppColors.profitBadgeBg.withValues(alpha: 0.15),
                         borderRadius: BorderRadius.circular(8),
                         border: Border.all(
                           color: AppColors.profitBadgeBg.withValues(alpha: 0.3),
                         )
                       ),
                       child: Row(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           Icon(Icons.trending_up_rounded,
                           size: 15,
                            color: AppColors.profitBadgeBg,
                           ),
                           SizedBox(width: 4),
                           Text(
                             '${controller.marginPercentage.toStringAsFixed(1)}% Margin',
                             style: TextStyle(
                               fontSize: 12,
                               fontWeight: FontWeight.w600,
                               color: AppColors.profitBadgeBg,
                             ),
                           ),
                         ],
                       ),
                     )
                   ],
                 )
             ),
            const SizedBox(height: 14),
            Divider(color: Colors.white.withValues(alpha: 0.08), height: 1),
            const SizedBox(height: 12),

            // Revenue vs Costs split
            Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Revenue',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.greyHeading,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            fmt.format(controller.totalRevenue),
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      width: 1,
                      height: 26,
                      color: AppColors.white.withValues(alpha: 0.1),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'job Costs',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: AppColors.greyHeading,
                            ),
                          ),
                          Text(
                            fmt.format(controller.totalCosts),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
            )

          ],
        ),
      );
  }

 Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: GestureDetector(
          onTap:  () => Get.toNamed(AppRoutes.addJob),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primaryColors,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColors.withValues(alpha: 0.25),
                    blurRadius: 8,
                    offset: Offset(0,3),
                  ),
                ]
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_rounded,color: Colors.white, size: 20),
                  SizedBox(width: 7),
                  Text(
                    'Add New Job',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 17),
        Expanded(
          flex: 2,
            child: GestureDetector(
              onTap: (){
                Get.snackbar(
                    'Receipt Scanner',
                    'Position your supplier bill in the camera view.',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: AppColors.appBarColor,
                  colorText: Colors.white,
                  borderRadius: 12,
                  margin: const EdgeInsets.all(16),
                );
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                       Icons.document_scanner_outlined,
                      size: 18,
                      color: AppColors.textHeading,
                    ),
                    SizedBox(width: 6),
                    Text(
                        'Scan Bill',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textHeading,
                      ),
                    )
                  ],
                ),
              ),
            ),
        ),
      ],
    );
  }


  // ── Job Status Grid ─────────────────────────────────────────────────────────
 Widget _buildJobStatusGrid(BuildContext context,HomeController controller) {
    final jobsCtrl = controller.jobsController;
    final navCtrl = Get.find<BottomNavController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'JOB METRICS',
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: AppColors.secondaryText,
            letterSpacing: 0.8,
          ),
        ),
        SizedBox(height: 10),
        Obx(
            () => GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.95,
              children: [
                _buildMetricTile(
                  title: 'Active Job',
                  count: '${jobsCtrl.activeCount}',
                  subtitle: 'In progress',
                  icon: Icons.play_circle_outline_rounded,
                  accent: AppColors.primaryColors,
                  onTap: () {
                    jobsCtrl.setFilter('Active');
                    navCtrl.changeTab(1);
                  },

                ),
                _buildMetricTile(
                  title: 'pending',
                  count: '${jobsCtrl.pendingCount}',
                  subtitle: 'Awaiting Client',
                  icon: Icons.hourglass_top_rounded,
                  accent: AppColors.warning,
                  onTap: () {
                    jobsCtrl.setFilter('Pending');
                    navCtrl.changeTab(1);
                  },

                ),
                _buildMetricTile(
                  title: 'Completed',
                  count: '${jobsCtrl.completedCount}',
                  subtitle: 'Fully Settled',
                  icon: Icons.check_circle_outline_rounded,
                  accent: AppColors.success,
                  onTap: () {
                    jobsCtrl.setFilter('Completed');
                    navCtrl.changeTab(1);
                  },

                ),
                _buildMetricTile(
                  title: 'Cancelled',
                  count: '${jobsCtrl.cancelledCount}',
                  subtitle: 'Not Invoiced',
                  icon: Icons.cancel_outlined,
                  accent: AppColors.error,
                  onTap: () {
                    jobsCtrl.setFilter('Cancelled');
                    navCtrl.changeTab(1);
                  },

                ),
              ],

            )
        )
      ],
    );
  }


 Widget _buildMetricTile({
   required String title,
   required String count,
   required String subtitle,
   required IconData icon,
   required Color accent,
   required VoidCallback onTap,
}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderColor),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 8,
              offset: Offset(0, 2),
            )
          ]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: AppColors.textBody,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.5,
                ),
              ),
              Icon(icon,size: 17, color: accent),
            ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  count,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                    color: AppColors.textHeading,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: AppColors.secondaryText,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
}


// ── Recent Jobs ─────────────────────────────────────────────────────────────
  Widget _buildRecentJobs(
      BuildContext context,
      HomeController controller,
      NumberFormat fmt,
      ) {
    final navCtrl = Get.find<BottomNavController>();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'RECENT JOBS',
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: AppColors.secondaryText,
                letterSpacing: 0.8,
              ),
            ),
            GestureDetector(
              onTap: () => navCtrl.changeTab(1),
              child: Row(
                children: [
                  Text(
                    'View all',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColors,
                    ),
                  ),
                  const SizedBox(width: 3),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 11,
                    color: AppColors.primaryColors,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Obx(
              () => ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.recentJobs.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final job = controller.recentJobs[index];
              return _buildJobCard(job, fmt);
            },
          ),
        ),
      ],
    );

  }

  Widget _buildJobCard(TradeJob job, NumberFormat fmt) {
    Color statusBg;
    Color statusColor;

    switch (job.status) {
      case JobStatus.active:
        statusBg = AppColors.primaryColors.withValues(alpha: 0.1);
        statusColor = AppColors.primaryColors;
        break;
      case JobStatus.pending:
        statusBg = AppColors.warning.withValues(alpha: 0.1);
        statusColor = AppColors.warning;
        break;
      case JobStatus.completed:
        statusBg = AppColors.success.withValues(alpha: 0.1);
        statusColor = AppColors.success;
        break;
      case JobStatus.cancelled:
        statusBg = AppColors.error.withValues(alpha: 0.1);
        statusColor = AppColors.error;
    }

    return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderColor),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.screenBackground,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        job.id,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textHeading,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
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
                  padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
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
            const SizedBox(height: 8),
            Text(
              job.title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.textHeading,
              ),
            ),
            Text(
              'Client: ${job.client}',
              style: TextStyle(fontSize: 12, color: AppColors.secondaryText),
            ),
            const SizedBox(height: 8),
            Divider(color: AppColors.dividerColor, height: 1),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quote: ${fmt.format(job.quotedAmount)}',
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: AppColors.textBody,
                  ),
                ),
                if (job.status == JobStatus.completed ||
                    job.status == JobStatus.active)
                  Text(
                    'Profit: ${fmt.format(job.netProfit)}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: job.isProfitable
                          ? AppColors.success
                          : AppColors.error,
                    ),
                  )
                else
                  Text(
                    'Est. Cost: ${fmt.format(job.totalCost)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.secondaryText,
                    ),
                  ),
              ],
            ),
          ],
        )
    );
  }
}
