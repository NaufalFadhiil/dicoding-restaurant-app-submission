import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/data/services/api_service.dart';
import 'package:restaurant_api/data/services/local_notification_service.dart';
import 'package:restaurant_api/providers/favorite_provider.dart';
import 'package:restaurant_api/providers/navigation_provider.dart';
import 'package:restaurant_api/providers/reminder_provider.dart';
import 'package:restaurant_api/providers/restaurant_detail_provider.dart';
import 'package:restaurant_api/providers/restaurant_list_provider.dart';
import 'package:restaurant_api/providers/restaurant_search_provider.dart';
import 'package:restaurant_api/providers/theme_notifier.dart';
import 'package:restaurant_api/style/colors/restaurant_colors.dart';
import 'package:restaurant_api/ui/main_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await LocalNotificationService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantListProvider>(
          create: (_) => RestaurantListProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<RestaurantDetailProvider>(
          create: (_) => RestaurantDetailProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<RestaurantSearchProvider>(
          create: (_) => RestaurantSearchProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider<NavigationProvider>(
          create: (_) => NavigationProvider(),
        ),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => ReminderProvider()),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Restaurant App',
          themeMode: theme.themeMode,
          theme: ThemeData(
            fontFamily: 'Poppins',
            brightness: Brightness.light,
            primaryColor: RestaurantColors.teal.color,
            appBarTheme: AppBarTheme(
              backgroundColor: RestaurantColors.teal.color,
            ),
          ),
          darkTheme: ThemeData(
            fontFamily: 'Poppins',
            brightness: Brightness.dark,
            primaryColor: RestaurantColors.orange.color,
            appBarTheme: AppBarTheme(
              backgroundColor: RestaurantColors.orange.color,
            ),
          ),
          home: const MainScreen(),
        ),
      ),
    );
  }
}
