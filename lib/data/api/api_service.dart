import 'dart:convert';

import 'package:restaurant_app/data/models/details.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/models/search.dart';

class ApiService {
  Future<RestaurantList> listRestaurant() async {
    final apiResponse =
        await http.get(Uri.parse('https://restaurant-api.dicoding.dev/list'));
    if (apiResponse.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(apiResponse.body));
    } else {
      throw Exception('Failed to load data :(');
    }
  }

  Future<RestaurantSearch> searchRestaurant(String q) async {
    final apiResponse = await http
        .get(Uri.parse('https://restaurant-api.dicoding.dev/search?q=$q'));
    if (apiResponse.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(apiResponse.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<RestaurantDetail> detailRestaurant(String id) async {
    final apiResponse = await http
        .get(Uri.parse('https://restaurant-api.dicoding.dev/detail/$id'));
    if (apiResponse.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(apiResponse.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
