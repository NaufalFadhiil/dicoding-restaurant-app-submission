import 'package:flutter/material.dart';
import 'package:restaurant_api/style/theme/restaurant_theme.dart';

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurant App')),
      body: Center(
        child: Text(
          'Helloo Poppins',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
