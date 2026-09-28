import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackupController extends GetxController {
  static const accountKey = 'backup_account';
  static const frequencyKey = 'backup_frequency';
  static const setupKey = 'backup_setup_seen';
  static const lastBackupKey = 'backup_last_completed';

  final account = ''.obs;
  final frequency = 'Weekly'.obs;
  final lastBackup = Rxn<DateTime>();
  final isSaving = false.obs;

   @override
   void onInit() {
     super.onInit();
     load();
   }

   Future<void> load() async {
      final prefs = await SharedPreferences.getInstance();
      account.value = prefs.getString(accountKey) ?? '';
      frequency.value = prefs.getString(frequencyKey) ?? 'Weekly';
      final savedLastBackup = prefs.getString(lastBackupKey);
      if (savedLastBackup != null) {
         lastBackup.value = DateTime.tryParse(savedLastBackup);
      }
   }


  Future<void> saveSettings({String? email}) async {
    isSaving.value = true;
    final prefs = await SharedPreferences.getInstance();
    final cleanedEmail = (email ?? account.value).trim();
    account.value = cleanedEmail;
    await prefs.setString(accountKey, cleanedEmail);
    await prefs.setString(frequencyKey, frequency.value);
    await prefs.setBool(setupKey, true);
    isSaving.value = false;
  }

    Future<void> skipSetup() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(setupKey, true);
    }

   Future<void> backupNow() async {
     isSaving.value = true;
     final now = DateTime.now();
     final prefs = await SharedPreferences.getInstance();
     lastBackup.value = now;
     await prefs.setString(lastBackupKey, now.toIso8601String());
     await prefs.setBool(setupKey, true);
     isSaving.value = false;
   }

  String get accountLabel =>
      account.value.isEmpty ? 'Not connected' : account.value;

  String get lastBackupLabel {
    final value = lastBackup.value;
    if (value == null) return 'No backup yet';
    return 'Last backup ${value.day}/${value.month}/${value.year}';
  }
}
