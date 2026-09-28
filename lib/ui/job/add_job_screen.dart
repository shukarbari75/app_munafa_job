import 'package:app_munafa_job/controllers/add_job_controller.dart';
import 'package:app_munafa_job/controllers/jobs_controller.dart';
import 'package:app_munafa_job/core/constant/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:intl/intl.dart';

import '../../core/utils/extensions/mediaquery_extension.dart';

class AddJobScreen extends StatelessWidget {
  const AddJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Fresh controller each time we enter this page
    final AddJobController ctrl = Get.put(AddJobController(), tag:'add_job');
    // Ensure JobsController is available
    Get.put(JobsController());

    final currency = NumberFormat.currency(symbol: '\$', decimalDigits: 0);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.screenBackground,
        appBar: AppBar(
          backgroundColor: AppColors.cardBackground,
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded,size: 18),
            onPressed: () => Get.back(),
          ),
          title: const Text(
            'New job',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textHeading
            ),
          ),
          centerTitle: false,
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1, color: AppColors.dividerColor),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Customer ──────────────────────────────────────────
                      _SectionLabel(text: 'customer'),
                      SizedBox(height: 6),
                      _PlainField(
                        controller: ctrl.customerCtrl,
                        hint: 'e.g. Ahmed sahab',
                      ),
                      SizedBox(height: 16),
                      // ── Job title ─────────────────────────────────────────
                      _SectionLabel(text: 'Job title'),
                      const SizedBox(height: 6),
                      _PlainField(
                        controller: ctrl.jobTitleCtrl,
                        hint: 'e.g. Kitchen wiring',
                      ),
                      const SizedBox(height: 24),
                      // ── Cost Items ────────────────────────────────────────
                      const _SectionLabel(text: 'COST ITEMS', isUpperCase: true),
                      const SizedBox(height: 10),

                      // Items list
                      Obx(
                            () => Column(
                          children: List.generate(ctrl.costItems.length, (i) {
                            return _CostItemRow(
                              index: i,
                              item: ctrl.costItems[i],
                              onRemove: () => ctrl.removeItem(i),
                              onNameChanged: (v) => ctrl.updateItemName(i, v),
                              onCostChanged: (v) => ctrl.updateItemCost(i, v),
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: 4),

                      // + Add item button
                      GestureDetector(
                        onTap: ctrl.addItem,
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: AppColors.cardBackground,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppColors.borderColor,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                size: 18,
                                color: AppColors.primaryColors,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '+ Add item',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryColors,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 24),

                      // ── Price charged to customer ─────────────────────────
                      const _SectionLabel(text: 'Price charged to customer'),
                      const SizedBox(height: 6),
                      _PlainField(
                        controller: ctrl.priceChargedCtrl,
                        hint: '0',
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                        ],
                        onChanged: ctrl.updatePriceCharged,
                      ),

                      const SizedBox(height: 24),

                      // ── Live Calculation Card ─────────────────────────────
                      Obx(
                            () => Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: AppColors.appBarColor,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Total cost row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total cost',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF9AA1A9),
                                    ),
                                  ),
                                  Text(
                                    currency.format(ctrl.totalCost),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),

                              // Cost bar
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: ctrl.priceCharged.value > 0
                                      ? (ctrl.totalCost / ctrl.priceCharged.value).clamp(0.0, 1.0)
                                      : 0,
                                  backgroundColor: const Color(0xFF2C3E50),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    ctrl.isProfitable
                                        ? AppColors.success
                                        : AppColors.error,
                                  ),
                                  minHeight: 6,
                                ),
                              ),

                              const SizedBox(height: 14),
                              const Divider(color: Color(0xFF2C3E50), height: 1),
                              const SizedBox(height: 14),

                              // Profit row
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Profit',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                        color: Color(0xFF9AA1A9),
                                    ),
                                  ),
                                  Text(
                                    currency.format(ctrl.profit),
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700,
                                      color: ctrl.isProfitable
                                          ? const Color(0xFF4EBA80)
                                          : AppColors.error,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 100), // Space for bottom button
                    ],
                  ),
                )
            ),

            // ── Save Button pinned at bottom ──────────────────────────────
            Container(
              padding: EdgeInsets.fromLTRB(
                20,
                12,
                20,
                context.heightPct(0.03) + 12,
              ),
              decoration: const BoxDecoration(
                color: AppColors.cardBackground,
                border: Border(
                  top: BorderSide(color: AppColors.dividerColor),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: ctrl.saveJob,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColors,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save job & make invoice',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}


// ──────────────────────────────────────────────────────────────────────────────
// Reusable Widgets for this screen
// ──────────────────────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  final String text;
  final bool isUpperCase;

  const _SectionLabel({required this.text, this.isUpperCase = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        fontSize: isUpperCase ? 12 : 14,
        fontWeight: FontWeight.w600,
        color: isUpperCase ? AppColors.secondaryText : AppColors.textHeading,
        letterSpacing: isUpperCase ? 0.8 : 0,
      ),
    );
  }
}


class _PlainField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;

  const _PlainField({
    required this.controller,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
        color: AppColors.textHeading,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 15,
          color: AppColors.textHint,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: AppColors.cardBackground,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColors.primaryColors,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}


/// A single cost item row: [Description field] [Cost field] [Remove button]
class _CostItemRow extends StatelessWidget {
  final int index;
  final JobCostItem item;
  final VoidCallback onRemove;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onCostChanged;

  const _CostItemRow({
    required this.index,
    required this.item,
    required this.onRemove,
    required this.onNameChanged,
    required this.onCostChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          // Description
          Expanded(
            flex: 3,
            child: TextField(
              onChanged: onNameChanged,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textHeading,
              ),
              decoration: InputDecoration(
                hintText: 'e.g. Copper wire 50m',
                hintStyle: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textHint,
                ),
                filled: true,
                fillColor: AppColors.cardBackground,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 13,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppColors.primaryColors,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Cost
          Expanded(
            flex: 2,
            child: TextField(
              onChanged: onCostChanged,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textHeading,
              ),
              decoration: InputDecoration(
                hintText: '0',
                hintStyle: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textHint,
                ),
                filled: true,
                fillColor: AppColors.cardBackground,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 13,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: AppColors.primaryColors,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 6),

          // Remove button
          GestureDetector(
            onTap: onRemove,
            child: Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              child: Icon(
                Icons.close,
                size: 18,
                color: AppColors.iconGrey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
