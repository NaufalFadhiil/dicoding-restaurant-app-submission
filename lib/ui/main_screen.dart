// lib/ui/main_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/providers/navigation_provider.dart';
import 'package:restaurant_api/providers/theme_notifier.dart';
import 'package:restaurant_api/ui/pages/restaurant_list_screen.dart';
import 'package:restaurant_api/ui/pages/restaurant_search_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  final List<Widget> _pages = const [
    RestaurantListScreen(),
    RestaurantSearchScreen(),
  ];

  final List<String> _pageTitles = const [
    'Restaurant App',
    'Search Restaurants',
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, navigation, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_pageTitles[navigation.selectedIndex]),
            actions: [
              Consumer<ThemeNotifier>(
                builder: (context, theme, child) {
                  return Switch(
                    value: theme.themeMode == ThemeMode.dark,
                    onChanged: (value) {
                      theme.toggleTheme();
                    },
                  );
                },
              ),
            ],
          ),
          body: _pages[navigation.selectedIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
            ],
            currentIndex: navigation.selectedIndex,
            onTap: (index) {
              navigation.onItemTapped(index);
            },
          ),
        );
      },
    );
  }
}
