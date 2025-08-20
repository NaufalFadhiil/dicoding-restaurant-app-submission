import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/providers/restaurant_list_provider.dart';
import 'package:restaurant_api/static/restaurant_list_state.dart';
import 'package:restaurant_api/ui/widgets/restaurant_card.dart';

class RestaurantListScreen extends StatefulWidget {
  const RestaurantListScreen({super.key});

  @override
  State<RestaurantListScreen> createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<RestaurantListProvider>(
        context,
        listen: false,
      ).fetchRestaurantList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurant List')),
      body: Consumer<RestaurantListProvider>(
        builder: (context, provider, child) {
          if (provider.state is RestaurantListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.state is RestaurantListLoaded) {
            final restaurants = (provider.state as RestaurantListLoaded).data;
            return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return RestaurantCard(restaurant: restaurant);
              },
            );
          } else if (provider.state is RestaurantListError) {
            final error = (provider.state as RestaurantListError).message;
            return Center(child: Text(error));
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}

