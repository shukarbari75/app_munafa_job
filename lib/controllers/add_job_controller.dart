import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'jobs_controller.dart';

/// A single line-item cost entry (material, labour, fee, etc.)
  class JobCostItem {
     final RxString name;
     final RxDouble cost;

    JobCostItem({String name = '', double cost = 0})
       : name = name.obs,
          cost = cost.obs;
  }

class AddJobController extends GetxController {

  final TextEditingController customerCtrl = TextEditingController();
  final TextEditingController jobTitleCtrl = TextEditingController();
  final TextEditingController priceChargedCtrl = TextEditingController();

  final RxList<JobCostItem> costItems = <JobCostItem>[JobCostItem()].obs;
  final RxDouble priceCharged = 0.0.obs;

  double get totalCost =>
      costItems.fold(0.0, (sum, item) => sum + item.cost.value);

  double get profit => priceCharged.value - totalCost;

  bool get isProfitable => profit >= 0;

  void addItem() {
    costItems.add(JobCostItem());
  }

  void removeItem(int index) {
    if (costItems.length > 1) {
      costItems.removeAt(index);
    }
  }

  void updateItemName(int index, String value) {
    costItems[index].name.value = value;
  }

  void updateItemCost(int index, String value) {
    costItems[index].cost.value = double.tryParse(value) ?? 0.0;
    // Trigger reactivity on totalCost and profit
    costItems.refresh();
  }

  void updatePriceCharged(String value) {
    priceCharged.value = double.tryParse(value) ?? 0.0;
  }

void saveJob() {
    final title = jobTitleCtrl.text.trim();
    final client = customerCtrl.text.trim();
    final price = priceCharged.value;

   if (title.isEmpty || client.isEmpty) {
      Get.snackbar(
         'Missing Info',
         'Please enter at least a Job Title and Customer.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFB23A2E),
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.all(16),
      );
      return;
   }


  final totalMaterials = totalCost;
     final jobsCtrl = Get.find<JobsController>();
    jobsCtrl.addJob(
       title: title,
       client: client,
       tradeCategory: 'General',
       quotedAmount: price,
       materialsCost: totalMaterials,
       laborHours: 0,
       hourlyRate: 0,
       permitsCost: 0,
       status: JobStatus.active,
       costItemsData: costItems
             .map((e) => {'name': e.name.value, 'cost': e.cost.value})
             .toList(),
    );

    Get.back();
  }

  @override
  void onClose() {
    customerCtrl.dispose();
    jobTitleCtrl.dispose();
    priceChargedCtrl.dispose();
    super.onClose();
  }
}