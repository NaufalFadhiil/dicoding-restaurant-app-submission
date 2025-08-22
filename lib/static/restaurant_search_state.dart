import 'package:restaurant_api/data/models/restaurant.dart';

sealed class RestaurantSearchState {}

final class RestaurantSearchInitial extends RestaurantSearchState {}

final class RestaurantSearchLoading extends RestaurantSearchState {}

final class RestaurantSearchLoaded extends RestaurantSearchState {
  final List<Restaurant> result;
  RestaurantSearchLoaded({required this.result});
}

final class RestaurantSearchError extends RestaurantSearchState {
  final String message;
  RestaurantSearchError({required this.message});
}
