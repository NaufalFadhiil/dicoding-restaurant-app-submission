import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/providers/navigation_provider.dart';
import 'package:restaurant_api/ui/pages/favorite_screen.dart';
import 'package:restaurant_api/ui/pages/restaurant_list_screen.dart';
import 'package:restaurant_api/ui/pages/restaurant_search_screen.dart';
import 'package:restaurant_api/ui/pages/settings_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  final List<Widget> _pages = const [
    RestaurantListScreen(),
    RestaurantSearchScreen(),
    FavoriteScreen(),
  ];

  final List<String> _pageTitles = const [
    'Restaurant App',
    'Search Restaurants',
    'Favorite Restaurants',
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, navigation, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(_pageTitles[navigation.selectedIndex]),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsScreen(),
                    ),
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
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorite',
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
