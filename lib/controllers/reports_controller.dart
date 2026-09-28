


import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportsController extends GetxController {
  final  RxString  selectedTimeframe = 'Monthly'.obs;

  void setTimeframe(String timeframe) {
    selectedTimeframe.value = timeframe;
  }

  void  exportPDFReport() {
    Get.snackbar(
      titleText: const Text(
        'Exporting Ledger',
        style: TextStyle(
          fontSize: 16,           // pehle se bada
          fontWeight: FontWeight.w800, // bold
          color: Colors.white,
        ),
      ),
      messageText: Text(
        'Generating PDF Job Costing Summary for ${selectedTimeframe.value}...',
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.white70,
        ),
      ),

      'Exporting Ledger',
        'Generating PDF Job Costing Summary for ${selectedTimeframe.value}...',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF17212B),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 16,
        duration: const Duration(seconds: 2),
    );

  }
}