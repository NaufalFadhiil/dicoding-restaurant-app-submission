import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/data/services/api_service.dart';
import 'package:restaurant_api/providers/restaurant_detail_provider.dart';
import 'package:restaurant_api/providers/restaurant_list_provider.dart';
import 'package:restaurant_api/style/colors/restaurant_colors.dart';
import 'package:restaurant_api/ui/pages/restaurant_list_screen.dart';

void main() {
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
      ],
      child: MaterialApp(
        title: 'Restaurant App',
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
        home: const RestaurantListScreen(),
      ),
    );
  }
}
