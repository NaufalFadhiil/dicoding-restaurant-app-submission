import 'package:restaurant_api/data/models/restaurant.dart';

sealed class RestaurantListState {}

final class RestaurantListLoading extends RestaurantListState {}

final class RestaurantListLoaded extends RestaurantListState {
  final List<Restaurant> data;

  RestaurantListLoaded({required this.data});
}

final class RestaurantListError extends RestaurantListState {
  final String message;

  RestaurantListError({required this.message});
}

final class RestaurantListNone extends RestaurantListState {}
