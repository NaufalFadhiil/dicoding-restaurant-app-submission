import 'package:flutter/material.dart';

enum RestaurantColors {
  teal("Teal", Colors.teal),
  orange("Orange", Colors.orange);

  const RestaurantColors(this.name, this.color);

  final String name;
  final Color color;
}
