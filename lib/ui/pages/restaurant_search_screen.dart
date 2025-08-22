import 'package:flutter/material.dart';

class RestaurantSearchScreen extends StatelessWidget {
  const RestaurantSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Restaurants')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari restoran atau menu...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (query) {
                // TODO: Panggil provider untuk mencari restoran
              },
            ),
          ),
          // Placeholder untuk hasil pencarian
          Expanded(
            child: Center(
              child: Text('Masukkan kata kunci untuk mencari restoran.'),
            ),
          ),
        ],
      ),
    );
  }
}
