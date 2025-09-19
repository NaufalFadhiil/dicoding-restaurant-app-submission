import 'package:flutter/material.dart';
import 'package:restaurant_api/data/services/local_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      LocalNotificationService.scheduleDailyReminder();
    }
    notifyListeners();
  }

  void toggleDailyReminder(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    _isDailyReminderActive = value;
    await prefs.setBool('daily_reminder', value);

    if (value) {
      LocalNotificationService.scheduleDailyReminder();
    } else {
      LocalNotificationService.cancelReminder();
    }
    notifyListeners();
  }
}
