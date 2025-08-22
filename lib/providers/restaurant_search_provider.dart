import 'package:flutter/foundation.dart';
import 'package:restaurant_api/data/services/api_service.dart';
import 'package:restaurant_api/static/restaurant_search_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;
  RestaurantSearchProvider({required this.apiService});

  RestaurantSearchState _state = RestaurantSearchInitial();
  RestaurantSearchState get state => _state;

  Future<void> searchRestaurant(String query) async {
    if (query.isEmpty) {
      _state = RestaurantSearchInitial();
      notifyListeners();
      return;
    }

    try {
      _state = RestaurantSearchLoading();
      notifyListeners();
      final result = await apiService.searchRestaurants(query);
      _state = RestaurantSearchLoaded(result: result.restaurants);
      notifyListeners();
    } catch (e) {
      _state = RestaurantSearchError(message: 'Failed to find restaurants: ${e.toString()}');
      notifyListeners();
    }
  }
}