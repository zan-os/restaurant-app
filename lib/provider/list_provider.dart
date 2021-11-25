import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/restaurant.dart';

enum StateList { noData, hasData, loading, error }

class ListProvider extends ChangeNotifier {
  final ApiService apiService;

  ListProvider({required this.apiService}) {
    fetchAllList();
  }

  StateList? _state;
  RestaurantList? _restaurantList;
  String _message = '';

  RestaurantList? get searchResult => _restaurantList;
  String get message => _message;
  StateList? get searchState => _state;

  Future<dynamic> fetchAllList() async {
    try {
      _state = StateList.loading;
      notifyListeners();
      final restaurantApi = await apiService.listRestaurant();

      if (restaurantApi.restaurants.isNotEmpty) {
        _state = StateList.hasData;
        notifyListeners();
        return _restaurantList = restaurantApi;
      } else {
        _state = StateList.noData;
        notifyListeners();
        return _message = 'Data is empty';
      }
    } catch (error) {
      _state = StateList.error;
      notifyListeners();
      return _message = 'Error => $error';
    }
  }
}
