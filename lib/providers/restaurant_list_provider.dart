import 'package:flutter/foundation.dart';
import 'package:restaurant_api/data/services/api_service.dart';
import 'package:restaurant_api/static/restaurant_list_state.dart';
import 'dart:io';

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
    } on SocketException {
      _state = RestaurantListError(message: 'Tidak ada koneksi internet.');
      notifyListeners();
    } catch (e) {
      _state = RestaurantListError(
        message: 'Gagal memuat data restoran: ${e.toString()}',
      );
      notifyListeners();
    }
  }
}
