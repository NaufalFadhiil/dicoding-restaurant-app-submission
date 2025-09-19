import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_api/data/models/restaurant.dart';
import 'package:restaurant_api/data/models/restaurant_list.dart';
import 'package:restaurant_api/data/services/api_service.dart';
import 'package:restaurant_api/providers/restaurant_list_provider.dart';
import 'package:restaurant_api/static/restaurant_list_state.dart';

import 'restaurant_list_provider_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  late MockApiService mockApiService;
  late RestaurantListProvider provider;

  setUp(() {
    mockApiService = MockApiService();
    provider = RestaurantListProvider(apiService: mockApiService);
  });

  tearDown(() {
    reset(mockApiService);
  });

  test('State awal provider harus RestaurantListLoading', () {
    expect(provider.state, isA<RestaurantListLoading>());
  });

  test('Mengembalikan daftar restoran ketika API berhasil', () async {
    final restaurants = [
      Restaurant(
        id: '1',
        name: 'Resto A',
        description: 'Desc A',
        city: 'Jakarta',
        pictureId: 'pic1',
        rating: 4.5,
      ),
      Restaurant(
        id: '2',
        name: 'Resto B',
        description: 'Desc B',
        city: 'Bandung',
        pictureId: 'pic2',
        rating: 4.0,
      ),
    ];

    final mockResponse = RestaurantListResponse(
      error: false,
      message: "success",
      count: 2,
      restaurants: restaurants,
    );

    when(
      mockApiService.getRestaurantList(),
    ).thenAnswer((_) async => mockResponse);

    await provider.fetchRestaurantList();

    expect(provider.state, isA<RestaurantListLoaded>());
    final state = provider.state as RestaurantListLoaded;
    expect(state.data, restaurants);
  });

  test('Mengembalikan error ketika API gagal', () async {
    when(
      mockApiService.getRestaurantList(),
    ).thenThrow(Exception("Failed to fetch"));

    await provider.fetchRestaurantList();

    expect(provider.state, isA<RestaurantListError>());
    final state = provider.state as RestaurantListError;
    expect(state.message, contains("Gagal memuat data restoran"));
  });
}
