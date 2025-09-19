import 'package:flutter/material.dart';
import 'package:restaurant_api/data/services/local_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class ReminderProvider extends ChangeNotifier {
  bool _isDailyReminderActive = false;
  bool get isDailyReminderActive => _isDailyReminderActive;

  ReminderProvider() {
    _loadPreferences();
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _isDailyReminderActive = prefs.getBool('daily_reminder') ?? false;

    if (_isDailyReminderActive) {
      await _scheduleReminderWithPermission();
    }
    notifyListeners();
  }

  Future<void> toggleDailyReminder(
    bool value, {
    Function(String)? onMessage,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    _isDailyReminderActive = value;
    await prefs.setBool('daily_reminder', value);

    if (value) {
      PermissionStatus status = await Permission.notification.status;
      if (!status.isGranted) {
        status = await Permission.notification.request();
      }

      if (status.isGranted) {
        LocalNotificationService.scheduleDailyReminder();
      } else {
        _isDailyReminderActive = false;
        await prefs.setBool('daily_reminder', false);
        onMessage?.call(
          'Permission notifikasi ditolak, Daily Reminder tidak aktif!',
        );
      }
    } else {
      LocalNotificationService.cancelReminder();
    }
    notifyListeners();
  }

  Future<void> _scheduleReminderWithPermission() async {
    PermissionStatus status = await Permission.notification.status;
    if (!status.isGranted) {
      status = await Permission.notification.request();
    }

    if (status.isGranted) {
      LocalNotificationService.scheduleDailyReminder();
    }
  }
}
