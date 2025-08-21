import 'package:flutter/widgets.dart';
import 'package:restaurant_api/data/services/api_service.dart';
import 'package:restaurant_api/static/restaurant_detail_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  RestaurantDetailProvider({required this.apiService});

  RestaurantDetailState _state = RestaurantDetailLoading();
  RestaurantDetailState get state => _state;

  Future<void> fetchRestaurantDetail(String id) async {
    try {
      _state = RestaurantDetailLoading();
      notifyListeners();
      final result = await apiService.getRestaurantDetail(id);
      _state = RestaurantDetailLoaded(data: result.restaurant);
      notifyListeners();
    } catch (e) {
      _state = RestaurantDetailError(
        message: 'Failed to load data: ${e.toString()}',
      );
      notifyListeners();
    }
  }
}
