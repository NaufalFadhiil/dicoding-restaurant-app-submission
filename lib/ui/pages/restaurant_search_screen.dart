import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/providers/restaurant_search_provider.dart';
import 'package:restaurant_api/static/restaurant_search_state.dart';
import 'package:restaurant_api/ui/widgets/restaurant_card.dart';

class RestaurantSearchScreen extends StatelessWidget {
  const RestaurantSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari restoran di sini',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (query) {
                Provider.of<RestaurantSearchProvider>(
                  context,
                  listen: false,
                ).searchRestaurant(query);
              },
            ),
          ),
          // Placeholder untuk hasil pencarian
          Expanded(
            child: Consumer<RestaurantSearchProvider>(
              builder: (context, provider, child) {
                if (provider.state is RestaurantSearchInitial) {
                  return const Center(
                    child: Text(
                      'Masukkan kata kunci untuk menemukan restoran anda.',
                    ),
                  );
                } else if (provider.state is RestaurantSearchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (provider.state is RestaurantSearchLoaded) {
                  final restaurants =
                      (provider.state as RestaurantSearchLoaded).result;
                  if (restaurants.isEmpty) {
                    return const Center(
                      child: Text('Tidak ada restoran yang ditemukan.'),
                    );
                  }
                  return ListView.builder(
                    itemCount: restaurants.length,
                    itemBuilder: (context, index) {
                      return RestaurantCard(restaurant: restaurants[index]);
                    },
                  );
                } else if (provider.state is RestaurantSearchError) {
                  final error =
                      (provider.state as RestaurantSearchError).message;
                  return Center(child: Text(error));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
