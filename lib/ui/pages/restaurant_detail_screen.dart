import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/data/models/restaurant.dart';
import 'package:restaurant_api/providers/favorite_provider.dart';
import 'package:restaurant_api/providers/restaurant_detail_provider.dart';
import 'package:restaurant_api/static/restaurant_detail_state.dart';
import 'package:restaurant_api/ui/widgets/restaurant_menu_section.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final String restaurantId;

  const RestaurantDetailScreen({Key? key, required this.restaurantId})
    : super(key: key);

  @override
  State<RestaurantDetailScreen> createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<RestaurantDetailProvider>(
        context,
        listen: false,
      ).fetchRestaurantDetail(widget.restaurantId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurant Detail')),
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, provider, child) {
          if (provider.state is RestaurantDetailLoaded) {
            final restaurant = (provider.state as RestaurantDetailLoaded).data;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Hero(
                    tag: 'restaurant_hero_${restaurant.id}',
                    child: Image.network(
                      'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                      fit: BoxFit.cover,
                      height: 250,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              restaurant.name,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Consumer<FavoriteProvider>(
                              builder: (context, favProvider, child) {
                                return FutureBuilder<bool>(
                                  future: favProvider.isFavorite(restaurant.id),
                                  builder: (context, snapshot) {
                                    final isFav = snapshot.data ?? false;
                                    return IconButton(
                                      icon: Icon(
                                        isFav
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isFav ? Colors.red : null,
                                      ),
                                      onPressed: () {
                                        if (isFav) {
                                          favProvider.removeFavorite(
                                            restaurant.id,
                                          );
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Dihapus dari favorit',
                                              ),
                                            ),
                                          );
                                        } else {
                                          favProvider.addFavorite(
                                            Restaurant(
                                              id: restaurant.id,
                                              name: restaurant.name,
                                              description:
                                                  restaurant.description,
                                              pictureId: restaurant.pictureId,
                                              city: restaurant.city,
                                              rating: restaurant.rating,
                                            ),
                                          );
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'Ditambahkan ke favorit',
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          children: restaurant.categories
                              .map(
                                (category) => Chip(label: Text(category.name)),
                              )
                              .toList(),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20,
                            ),
                            const SizedBox(width: 4),
                            Text(restaurant.rating.toString()),
                            const SizedBox(width: 16),
                            const Icon(Icons.location_on, size: 20),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                '${restaurant.city}, ${restaurant.address}',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(restaurant.description),
                      ],
                    ),
                  ),
                  RestaurantMenuSection(
                    title: 'Foods',
                    menuList: restaurant.menus.foods,
                  ),
                  RestaurantMenuSection(
                    title: 'Drinks',
                    menuList: restaurant.menus.drinks,
                  ),
                ],
              ),
            );
          } else if (provider.state is RestaurantDetailError) {
            final error = (provider.state as RestaurantDetailError).message;
            return Center(child: Text(error));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
