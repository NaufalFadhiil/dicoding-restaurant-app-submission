import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_api/models/restaurant_detail.dart';
import 'package:restaurant_api/models/restaurant_list.dart';

class ApiService {
  static const String _baseUrl = "https://restaurant-api.dicoding.dev/";

  /// Get list of restaurants
  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse("${_baseUrl}list"));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load restaurant list");
    }
  }

  /// Get restaurant detail by ID
  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("${_baseUrl}detail/$id"));

    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to load restaurant detail");
    }
  }
}
