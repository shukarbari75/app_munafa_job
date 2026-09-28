import 'dart:math';
import 'package:app_munafa_job/controllers/backup_controller.dart';
import 'package:app_munafa_job/core/constant/colors/app_colors.dart';
import 'package:app_munafa_job/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../../core/routes/app_routes.dart';
import '../../core/utils/extensions/mediaquery_extension.dart';

class BackupScreen extends StatefulWidget {
  final bool firstRun;
  const BackupScreen({super.key, this.firstRun = false});

  @override
  State<BackupScreen> createState() => _BackupScreenState();
}

class _BackupScreenState extends State<BackupScreen> {
  late final BackupController controller;
  late final TextEditingController emailController;
  late final Worker accountWorker;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<BackupController>()
        ? Get.find<BackupController>()
        : Get.put(BackupController());
    emailController = TextEditingController(text: controller.account.value);
    accountWorker = ever<String>(controller.account, (value) {
      if (mounted && emailController.text.isEmpty) emailController.text = value;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    accountWorker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        title: Text(
          widget.firstRun ? 'Protect your Munafa Data ' : 'Backup & Stroge',
        ),
        leading: widget.firstRun ? null : const BackButton(),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.fromLTRB(
              context.widthPct(0.05),
              context.heightPct(0.018),
              context.widthPct(0.05),
              context.heightPct(0.04),
            ),

            child: Obx(
                    () =>
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildHero(context),
                        const SizedBox(height: 22),
                        _buildStorageCard(context),
                        const SizedBox(height: 24),
                        // _buildSectionLabel(context, 'GOOGLE ACCOUNT'),
                        // const SizedBox(height: 8),
                        _buildAccountField(context),
                        const SizedBox(height: 24),
                        _buildSectionLabel(context, 'BACKUP FREQUENCY'),
                        const SizedBox(height: 8),
                        _buildFrequencyOptions(context),
                        const SizedBox(height: 12),
                        Text(
                          'Your preference is saved on this device. Connect an account to keep a cloud copy of your ledger.',
                          style: TextStyle(
                            fontSize: context.scaledFont(12),
                            height: 1.45,
                            color: AppColors.secondaryText,
                          ),
                        ),

                        const SizedBox(height: 26),
                        CustomButton(
                          title: controller.isSaving.value
                              ? 'saving...'
                              : 'Save backup setting',
                          onTap: controller.isSaving.value ? null : _save,
                          height: context.heightPct(0.062),
                          borderRadius: 12,
                          backgroundColor: AppColors.primaryColors,
                        ),
                        if (widget.firstRun)...[
                          const SizedBox(height: 8),
                          Center(
                            child: TextButton(
                              onPressed: _skip,
                              child: Text(
                                'skip for now',
                                style: TextStyle(
                                  color: AppColors.secondaryText,
                                  fontSize: context.scaledFont(13),
                                ),
                              ),
                            ),
                          ),
                        ] else
                          ...[
                            const SizedBox(height: 18),
                            _buildBackupAction(context),
                            const SizedBox(height: 10),
                            _buildRestoreAction(context),
                          ],
                      ],
                    )
            ),

          )
      ),
    );
  }


  Future<void> _save() async {
    await controller.saveSettings(email: emailController.text);
    if (!mounted) return;
    if (widget.firstRun) {
      Get.offAllNamed(AppRoutes.bottomNav);
    } else {
      Get.snackbar(
        'Backup settings saved',
        'Your backup preference has been updated.',
      );
    }
  }

  Future<void> _skip() async {
    await controller.skipSetup();
    if (mounted) Get.offAllNamed(AppRoutes.bottomNav);
  }

  Widget _buildHero(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.textHeading,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: AppColors.primaryColors,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(Icons.cloud_upload_outlined, color: Colors.white,),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.firstRun
                      ? 'Never lose a job record'
                      : 'your data, your control',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: context.scaledFont(20),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Back up job, costs and reports securely.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.72),
                    fontSize: context.scaledFont(13),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStorageCard(BuildContext context,) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.folder_copy_outlined,
                color: AppColors.primaryColors,
              ),
              SizedBox(width: 14),
              Expanded(
                child: Text(
                  'Munafa storage',
                  style: TextStyle(
                    color: AppColors.textHeading,
                    fontSize: context.scaledFont(16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '2.4 MB 0f 15 GB',
                style: TextStyle(
                  color: AppColors.secondaryText,
                  fontSize: context.scaledFont(12),
                ),
              ),
            ],
          ),
          SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: 0.08,
              minHeight: 8,
              backgroundColor: AppColors.dividerColor,
              color: AppColors.primaryColors,
            ),
          ),
          SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Job and reports', style: _mutedStyle(context)),
              Text(controller.lastBackupLabel, style: _mutedStyle(context)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAccountField(BuildContext context) {
    return TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: 'you@gmail.com',
        prefixIcon: Icon(Icons.account_circle_outlined),
        suffixIcon: controller.account.value.isNotEmpty
            ? Icon(Icons.verified_rounded, color: AppColors.success)
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
      ),
    );
  }

  Widget _buildFrequencyOptions(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: ['Daily', 'Weekly', 'Monthly', 'Never'].map((option) {
        final selected = controller.frequency.value == option;
        return ChoiceChip(
          label: Text(option),
          selected: selected,
          onSelected: (_) => controller.frequency.value = option,
          selectedColor: AppColors.primaryColors,
          backgroundColor: AppColors.cardBackground,
          side: BorderSide(
            color: selected ? AppColors.primaryColors : AppColors.borderColor,
          ),
          labelStyle: TextStyle(
            color: selected ? Colors.white : AppColors.textBody,
            fontSize: context.scaledFont(12.5),
            fontWeight: FontWeight.w600,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBackupAction(BuildContext context) {
    return InkWell(
        onTap: controller.isSaving.value ? null : controller.backupNow,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Row(
            children: [
              Icon(Icons.sync_rounded, color: AppColors.primaryColors,),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Back Up Now',
                  style: TextStyle(
                    color: AppColors.textHeading,
                    fontSize: context.scaledFont(13.5),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: AppColors.iconGrey),
            ],
          ),
        ));
  }

  Widget _buildRestoreAction(BuildContext context) {
    return InkWell(
      onTap: _restore,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Row(
          children: [
            const Icon(Icons.restore_rounded, color: AppColors.info),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Restore from backup',
                style: TextStyle(
                  color: AppColors.textHeading,
                  fontSize: context.scaledFont(13.5),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: AppColors.iconGrey),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(BuildContext context, String title) {
    return Text(
      title,
      style: TextStyle(
        color: AppColors.secondaryText,
        fontSize: context.scaledFont(11),
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
      ),
    );
  }


//  error ki wja sy ya _mutedStyle ka mathod lagaya
  TextStyle _mutedStyle(BuildContext context) =>
      TextStyle(
        color: AppColors.secondaryText,
        fontSize: context.scaledFont(11.5),
      );

  void _restore() {
    Get.dialog(
      AlertDialog(
        title: const Text('Restore your data?'),
        content: const Text(
          'Your latest cloud backup will be restored. Any newer local changes may be replaced.',
        ),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                'Restore ready',
                'Your latest backup is ready to restore.',
              );
            },
            child: const Text('Restore'),
          ),
        ],
      ),
    );
  }
}