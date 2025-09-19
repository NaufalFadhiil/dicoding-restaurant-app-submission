import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/providers/theme_notifier.dart';
import 'package:restaurant_api/providers/reminder_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Consumer<ThemeNotifier>(
        builder: (context, theme, child) {
          return ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Pilih Tema Aplikasi',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SwitchListTile(
                secondary: const Icon(Icons.dark_mode),
                title: const Text('Dark Mode'),
                subtitle: const Text(
                  'Ganti tampilan menjadi mode terang atau gelap',
                ),
                value: theme.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  theme.toggleTheme();
                },
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Notifikasi',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Consumer<ReminderProvider>(
                builder: (context, reminder, _) {
                  return SwitchListTile(
                    secondary: const Icon(Icons.notifications),
                    title: const Text('Daily Reminder'),
                    subtitle: const Text(
                      'Dapatkan notifikasi setiap hari pada pukul 11:00 Siang.',
                    ),
                    value: reminder.isDailyReminderActive,
                    onChanged: (value) {
                      reminder.toggleDailyReminder(value);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            value
                                ? 'Daily Reminder aktif!'
                                : 'Daily Reminder nonaktif!',
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
