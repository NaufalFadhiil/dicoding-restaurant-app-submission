import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/providers/theme_notifier.dart';
import 'package:restaurant_api/ui/pages/restaurant_list_screen.dart';
import 'package:restaurant_api/ui/pages/restaurant_search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const RestaurantListScreen(),
    const RestaurantSearchScreen(),
  ];
  final List<String> _pageTitles = ['Restaurant App', 'Search Restaurants'];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageTitles[_selectedIndex]),
        actions: [
          Consumer<ThemeNotifier>(
            builder: (context, theme, child) {
              return Switch(
                value: theme.themeMode == ThemeMode.dark,
                onChanged: (value) {
                  theme.toggleTheme();
                },
                activeThumbColor: Colors.white24,
                activeTrackColor: Colors.black,
                inactiveTrackColor: Colors.white,
              );
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
