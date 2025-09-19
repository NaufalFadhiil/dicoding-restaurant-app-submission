import 'package:flutter/foundation.dart';
import 'package:restaurant_api/db/database_helper.dart';
import '../data/models/restaurant.dart';

class FavoriteProvider extends ChangeNotifier {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  FavoriteProvider() {
    _getFavorites();
  }

  void _getFavorites() async {
    _favorites = await _dbHelper.getFavorites();
    notifyListeners();
  }

  Future<void> addFavorite(Restaurant restaurant) async {
    await _dbHelper.insertFavorite(restaurant);
    _getFavorites();
  }

  Future<void> removeFavorite(String id) async {
    await _dbHelper.removeFavorite(id);
    _getFavorites();
  }

  Future<bool> isFavorite(String id) async {
    final fav = await _dbHelper.getFavoriteById(id);
    return fav != null;
  }
}
