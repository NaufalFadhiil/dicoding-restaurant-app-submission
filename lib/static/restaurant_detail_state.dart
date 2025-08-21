import 'package:restaurant_api/data/models/restaurant_detail.dart';

sealed class RestaurantDetailState {}

final class RestaurantDetailLoading extends RestaurantDetailState {}

final class RestaurantDetailLoaded extends RestaurantDetailState {
  final RestaurantDetail data;
  
  RestaurantDetailLoaded({required this.data});
}

final class RestaurantDetailError extends RestaurantDetailState {
  final String message;
  
  RestaurantDetailError({required this.message});
}
