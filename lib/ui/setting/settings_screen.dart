import 'package:app_munafa_job/core/constant/colors/app_colors.dart';
import 'package:app_munafa_job/ui/setting/backup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../core/utils/extensions/mediaquery_extension.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.fromLTRB(
            context.widthPct(0.02),
            context.heightPct(0.01),
            context.widthPct(0.02),
            context.heightPct(0.1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Setting & preferences',
                style: TextStyle(
                  fontSize: context.scaledFont(23),
                  fontWeight: FontWeight.w700,
                  color: AppColors.textHeading,
                ),
              ),
              Text(
                'Manage your profile, app preferences and account',
                style: TextStyle(
                  fontSize: context.scaledFont(12.5),
                  fontWeight: FontWeight.w500,
                  color: AppColors.secondaryText,
                ),
              ),
              SizedBox(height: 20),

              Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColors.withValues(
                              alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'JD',
                            style: TextStyle(
                              fontSize: context.scaledFont(19),
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryColors,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jone Doe',
                              style: TextStyle(
                                fontSize: context.scaledFont(16),
                                fontWeight: FontWeight.w700,
                                color: AppColors.textHeading,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Apex Electrical & Contracting',
                              style: TextStyle(
                                fontSize: context.scaledFont(12.5),
                                color: AppColors.secondaryText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.edit_outlined,
                        size: 20,
                        color: AppColors.iconGrey,
                      )
                    ],
                  )
              ),
              SizedBox(height: 24),

              // -----------------------------------------
              // TRADE DEFAULTS
              // -----------------------------------------

              _buildSectionTitle(context, 'TRADE DEFAULTS'),
              SizedBox(height: 8),

              _buildSettingsGroup(context, [
                _buildSettingRow(
                  context,
                  Icons.attach_money_rounded,
                  'Default Currency',
                  '\$',
                )
              ]),
              SizedBox(height: 20),
              // -----------------------------------------
              // APP & LOCALIZATION
              // -----------------------------------------
              _buildSectionTitle(context, 'APP & LOCALIZATION'),
              SizedBox(height: 8),

              _buildSettingsGroup(context, [
                _buildSettingRow(
                  context,
                  Icons.translate_rounded,
                  'App Language',
                  'English',
                ),
                _buildSettingRow(
                  context,
                  Icons.receipt_long_outlined,
                  'Auto_tax Calculation',
                  'Enabled (8.25%)',
                )
              ]),
              SizedBox(height: 20),

              // -----------------------------------------
              // SUPPORT & LEGAL
              // -----------------------------------------
              _buildSectionTitle(context, 'SUPPORT & LEGAL'),
              SizedBox(height: 8),

              _buildSettingsGroup(context, [
                _buildSettingRow(
                    context,
                    Icons.help_outline_rounded,
                    'Help & Support',
                    'Get Help',
                    onTap: () {
                      // Open support screen / email
                    }
                ),
                _buildDivider(),

                _buildSettingRow(
                    context,
                    Icons.feedback_outlined,
                    'Send Feedback',
                    'Tell us what you think',
                    onTap: () {
                      // Open feedback
                    }
                ),
                _buildDivider(),

                _buildSettingRow(
                    context,
                    Icons.privacy_tip_outlined,
                    'privacy Policy',
                    'Read policy',
                    onTap: () {
                      // Open privacy policy
                    }
                ),
                _buildDivider(),

                _buildSettingRow(
                    context,
                    Icons.description_outlined,
                    'Terms & Conditions',
                    'Read terms',
                    onTap: () {
                      // open terms
                    }
                ),
                _buildDivider(),

                _buildSettingRow(
                    context,
                    Icons.info_outline_rounded,
                    'About Munafa',
                    'App Information',
                    onTap: () {
                      _showAboutDialog(context);
                    }
                )
              ]),
              SizedBox(height: 20),

              // -----------------------------------------
              // DATA & SYSTEM
              // -----------------------------------------
              _buildSectionTitle(context, 'DATA & SYSTEM'),
              SizedBox(height: 8),

              _buildSettingsGroup(context, [
                _buildSettingRow(
                    context,
                    Icons.cloud_done_outlined,
                    'Cloud Ledger Backup',
                    'Manage backup & restore',
                    onTap: () {
                      Get.to(() => BackupScreen());
                    }
                )
              ]),
              SizedBox(height: 28),

              //   verdion

              Center(
                child: Column(
                  children: [
                    Text(
                      'Munafa Job Costing',
                      style: TextStyle(
                        fontSize: context.scaledFont(12),
                        fontWeight: FontWeight.w600,
                        color: AppColors.textHeading,
                      ),
                    ),
                    SizedBox(height: 3),
                    Text(
                      'version 0.1.0 (Build 1)',
                      style: TextStyle(
                          fontSize: context.scaledFont(11),
                          fontWeight: FontWeight.w400,
                          color: AppColors.textHint
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }


// --------------------------------------------------
// SECTION TITLE
// --------------------------------------------------

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: context.scaledFont(11.5),
        fontWeight: FontWeight.w700,
        color: AppColors.secondaryText,
        letterSpacing: 0.8,
      ),
    );
  }

// --------------------------------------------------
// SETTINGS GROUP
// --------------------------------------------------

  Widget _buildSettingsGroup(BuildContext context, List<Widget> rows) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(children: rows),
    );
  }


// --------------------------------------------------
// SETTING ROW
// --------------------------------------------------

  Widget _buildSettingRow(BuildContext context,
      IconData icon,
      String title,
      String value, {
        VoidCallback? onTap,
      }) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.textHeading),

            const SizedBox(width: 14),

            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: context.scaledFont(13.5),
                  fontWeight: FontWeight.w500,
                  color: AppColors.textHeading,
                ),
              ),
            ),

            const SizedBox(width: 8),

            // Flexible(
            //   child: Text(
            //     value,
            //     textAlign: TextAlign.end,
            //     overflow: TextOverflow.ellipsis,
            //     style: TextStyle(
            //       fontSize: context.scaledFont(12),
            //       color: AppColors.secondaryText,
            //     ),
            //   ),
            // ),
            if (onTap != null) ...[
              const SizedBox(width: 7),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 11,
                color: AppColors.iconGrey,
              ),
            ],
          ],
        ),
      ),
    );
  }


// --------------------------------------------------
// DIVIDER
// --------------------------------------------------

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 0.7,
      indent: 50,
      endIndent: 16,
      color: AppColors.borderColor,
    );
  }


// --------------------------------------------------
// ABOUT DIALOG
// --------------------------------------------------


  void _showAboutDialog(BuildContext context) {
     showDialog(
        context: context,
        builder: (context) {
           return AlertDialog(
             backgroundColor: AppColors.cardBackground,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(16),
             ),
             title: Text(
               'Munafa Job Costing',
               style: TextStyle(
                 color: AppColors.textHeading,
                 fontWeight: FontWeight.w700,
               ),
             ),
             content: Text(
               'Munafa helps contractors and trade professionals '
                   'manage jobs, track costs and keep their business '
                   'organized.\n\nVersion 0.1.0 (Build 1)',
               style: TextStyle(color: AppColors.secondaryText, height: 1.5),
             ),
             actions: [
               TextButton(
                   onPressed: () => Navigator.pop(context),
                   child: Text(
                       'Close',
                     style: TextStyle(
                       fontWeight: FontWeight.w600,
                       color: AppColors.primaryColors,
                     ),
                   )
               ),
             ],
           );
        });
  }
}