import 'package:flutter/material.dart';
import 'package:restaurant_api/models/restaurant_list.dart';
import 'package:restaurant_api/services/api_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RestaurantListPage(),
    );
  }
}

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Restaurants",
          style: TextStyle(fontSize: 24, fontFamily: 'Poppins'),
        ),
      ),
      body: FutureBuilder<RestaurantListResponse>(
        future: ApiService().getRestaurantList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.restaurants.isEmpty) {
            return const Center(child: Text("No data available"));
          } else {
            final restaurants = snapshot.data!.restaurants;
            return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                final restaurant = restaurants[index];
                return ListTile(
                  leading: Image.network(
                    "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                  title: Text(restaurant.name),
                  subtitle: Text("${restaurant.city} • ⭐ ${restaurant.rating}"),
                );
              },
            );
          }
        },
      ),
    );
  }
}
