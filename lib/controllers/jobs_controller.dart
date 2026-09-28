

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

enum JobStatus { active, pending, completed, cancelled }

class TradeJob {
  final String id;
  final String title;
  final String client;
  final String tradeCategory; // Electric, Plumbing, HVAC, Carpentry, General
  final JobStatus status;
  final double quotedAmount;
  final double invoicedAmount;
  final double materialsCost;
  final double laborHours;
  final double hourlyRate;
  final double permitsCost;
  final DateTime date;

  const TradeJob({
    required this.id,
    required this.title,
    required this.client,
    required this.tradeCategory,
    required this.status,
    required this.quotedAmount,
    required this.invoicedAmount,
    required this.materialsCost,
    required this.laborHours,
    this.hourlyRate = 45.0,
    required this.permitsCost,
    required this.date,
  });

  double get laborCost => laborHours * hourlyRate;
  double get totalCost => materialsCost + laborCost + permitsCost;
  double get netProfit => invoicedAmount - totalCost;
  double get marginPercentage =>
      invoicedAmount > 0 ? (netProfit / invoicedAmount) * 100 : 0.0;
  bool get isProfitable => netProfit >= 0;

  String get statusDisplay {
    switch (status) {
      case JobStatus.active:
        return 'Active';
      case JobStatus.pending:
        return 'Pending';
      case JobStatus.completed:
        return 'Completed';
      case JobStatus.cancelled:
        return 'Cancelled';
    }
  }
}

class JobsController extends GetxController {
  final RxString selectedFilter = 'All'.obs;
  final RxString searchQuery = ''.obs;

   final RxList<TradeJob> jobs = <TradeJob>[
  TradeJob(
     id: 'JOB-104',
     title: 'Kitchen Full Rewire',
     client: 'Marcus Vance',
     tradeCategory: 'Electrical',
     status: JobStatus.active,
     quotedAmount: 4800,
     invoicedAmount: 4800,
     materialsCost: 1850,
     laborHours: 28,
     hourlyRate: 50,
     permitsCost: 220,
     date: DateTime.now().subtract(const Duration(days: 1)),
  ),
  TradeJob(
     id: 'JOB-210',
     title: 'Master Bathroom Rough-In',
     client: 'Sarah Jenkins',
     tradeCategory: 'Plumbing',
     status: JobStatus.completed,
     quotedAmount: 3200,
     invoicedAmount: 3450,
     materialsCost: 1100,
     laborHours: 16,
     hourlyRate: 55,
     permitsCost: 150,
     date: DateTime.now().subtract(const Duration(days: 3)),
  ),
  TradeJob(
     id: 'JOB-305',
     title: 'Commercial HVAC Ductwork',
     client: 'Oakridge Plaza',
     tradeCategory: 'HVAC',
     status: JobStatus.active,
     quotedAmount: 6500,
     invoicedAmount: 6500,
     materialsCost: 2600,
     laborHours: 35,
     hourlyRate: 60,
     permitsCost: 350,
     date: DateTime.now().subtract(const Duration(days: 5)),
  ),
  TradeJob(
     id: 'JOB-412',
     title: 'Basement Sub-Panel Upgrade',
     client: 'David Miller',
     tradeCategory: 'Electrical',
     status: JobStatus.pending,
     quotedAmount: 2200,
     invoicedAmount: 0,
     materialsCost: 950,
     laborHours: 10,
     hourlyRate: 50,
     permitsCost: 180,
     date: DateTime.now().subtract(const Duration(days: 7)),
  ),
  TradeJob(
     id: 'JOB-520',
     title: 'Water Heater Replacement',
     client: 'Elena Rostova',
     tradeCategory: 'Plumbing',
     status: JobStatus.completed,
     quotedAmount: 1850,
     invoicedAmount: 1850,
     materialsCost: 820,
     laborHours: 6,
     hourlyRate: 55,
     permitsCost: 90,
     date: DateTime.now().subtract(const Duration(days: 10)),
  ),
    TradeJob(
     id: 'JOB-601',
     title: 'Attic Fan & Vent Routing',
     client: 'Tom Bradley',
     tradeCategory: 'Electrical',
     status: JobStatus.cancelled,
     quotedAmount: 1200,
     invoicedAmount: 0,
     materialsCost: 300,
     laborHours: 0,
     hourlyRate: 50,
     permitsCost: 0,
     date: DateTime.now().subtract(const Duration(days: 14)),
  ),
].obs;

  List<TradeJob> get filteredJobs {
    return jobs.where((job) {
      final matchesSearch = job.title
            .toLowerCase()
            .contains(searchQuery.value.toLowerCase()) ||
       job.client.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
       job.id.toLowerCase().contains(searchQuery.value.toLowerCase());

     if (!matchesSearch) return false;

      if (selectedFilter.value == 'All') return true;
      if (selectedFilter.value == 'Active') {
          return job.status == JobStatus.active;
      }
      if (selectedFilter.value == 'Pending') {
          return job.status == JobStatus.pending;
      }
      if (selectedFilter.value == 'Completed') {
           return job.status == JobStatus.completed;
      }
      if (selectedFilter.value == 'Cancelled') {
           return job.status == JobStatus.cancelled;
      }
      return true;
    }).toList();
  }

  int get activeCount =>
     jobs.where((j) => j.status == JobStatus.active).length;
  int get pendingCount =>
     jobs.where((j) => j.status == JobStatus.pending).length;
  int get completedCount =>
     jobs.where((j) => j.status == JobStatus.completed).length;
   int get cancelledCount =>
      jobs.where((j) => j.status == JobStatus.cancelled).length;

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

  void setSearchQuery(String query) {
    searchQuery.value = query;
  }



  void addJob({
    required String title,
    required String client,
    required String tradeCategory,
    required double quotedAmount,
    required double materialsCost,
    required double laborHours,
    required double hourlyRate,
    required double permitsCost,
    required JobStatus status,
    List<Map<String, dynamic>>? costItemsData,
  }) {
    final currency = NumberFormat.currency(symbol: '\$', decimalDigits: 0);
    final newJob = TradeJob(
      id: 'JOB-${(jobs.length + 101).toString().padLeft(3, '0')}',
      title: title,
      client: client,
      tradeCategory: tradeCategory,
      status: status,
      quotedAmount: quotedAmount,
      invoicedAmount: status == JobStatus.pending ? 0 : quotedAmount,
      materialsCost: materialsCost,
      laborHours: laborHours,
      hourlyRate: hourlyRate,
      permitsCost: permitsCost,
      date: DateTime.now(),
    );

    jobs.insert(0, newJob);
    Get.snackbar(
      'Job Saved',
      '${newJob.id} — ${newJob.title} (${currency.format(quotedAmount)}) added.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF17212B),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }
}