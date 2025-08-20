import 'package:flutter/foundation.dart';
import 'package:restaurant_api/data/services/api_service.dart';
import 'package:restaurant_api/static/restaurant_list_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;
  RestaurantListProvider({required this.apiService});

  RestaurantListState _state = RestaurantListLoading();
  RestaurantListState get state => _state;

  Future<void> fetchRestaurantList() async {
    try {
      _state = RestaurantListLoading();
      notifyListeners();
      final result = await apiService.getRestaurantList();
      _state = RestaurantListLoaded(data: result.restaurants);
      notifyListeners();
    } catch (e) {
      _state = RestaurantListError(
        message: 'Failed to load data: ${e.toString()}',
      );
      notifyListeners();
    }
  }
}
