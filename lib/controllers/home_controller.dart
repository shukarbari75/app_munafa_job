


import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'jobs_controller.dart';

class HomeController extends GetxController {
   final JobsController jobsController = Get.put(JobsController());

   final RxString userName = 'Jone Doe'.obs;
   final RxString tradeCategory = 'Electrical & Contracting'.obs;
   final RxString selectedPeriod = 'Monthly'.obs;

   String get greetingMessage {
      final hour = DateTime.now().hour;
   if (hour < 12) {
       return 'Good morning,';
   } else if (hour < 17) {
       return 'Good afternoon,';
   } else {
      return 'Good evening,';
   }
 }

  void setPeriod(String period) {
    selectedPeriod.value = period;
  }

   // Reactive financial stats based on selected period
   double get totalRevenue {
     switch (selectedPeriod.value) {
       case 'Daily':
         return 1250.0;
       case 'Weekly':
         return 4800.0;
       case 'Monthly':
         return 16550.0;
       case 'Yearly':
       default:
          return 148200.0;
     }
   }

   double get totalCosts {
     switch (selectedPeriod.value) {
       case 'Daily':
          return 680.0;
       case 'Weekly':
           return 2950.0;
       case 'Monthly':
           return 9820.0;
       case 'Yearly':
       default:
           return 86400.0;
     }
   }

   double get netProfit => totalRevenue - totalCosts;

   double get marginPercentage =>
       totalRevenue > 0 ? (netProfit / totalRevenue) * 100 : 0.0;

   bool get isProfitable => netProfit >= 0;

   List<TradeJob> get recentJobs => jobsController.jobs.take(4).toList();
}
