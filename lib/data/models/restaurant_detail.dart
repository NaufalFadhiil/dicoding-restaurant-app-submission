import 'package:restaurant_api/data/models/category.dart';

import 'menus.dart';

class RestaurantDetail {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String pictureId;
  final Menus menus;
  final List<Category> categories;
  final double rating;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.menus,
    required this.categories,
    required this.rating,
  });

  factory RestaurantDetail.fromJson(Map<String, dynamic> json) =>
      RestaurantDetail(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        city: json['city'] as String,
        address: json['address'] as String,
        pictureId: json['pictureId'] as String,
        menus: Menus.fromJson(json['menus']),
        categories: List<Category>.from(
          (json['categories'] as List).map((x) => Category.fromJson(x)),
        ),
        rating: (json['rating'] as num).toDouble(),
      );
}
