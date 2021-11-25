import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/search.dart';

enum StateSearch { noData, hasData, loading, error }

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchProvider({required this.apiService}) {
    fetchAllSearch(q);
  }

  StateSearch? _stateSearch;
  RestaurantSearch? _restaurantSearch;
  String _message = '';
  String _q = '';

  RestaurantSearch? get searchResult => _restaurantSearch;
  StateSearch? get searchState => _stateSearch;
  String get mesage => _message;
  String get q => _q;

  Future<dynamic> fetchAllSearch(String q) async {
    try {
      _q = q;
      _stateSearch = StateSearch.loading;

      final restaurantApi = await apiService.searchRestaurant(q);
      if (restaurantApi.restaurants.isNotEmpty) {
        _stateSearch = StateSearch.hasData;
        notifyListeners();
        return _restaurantSearch = restaurantApi;
      } else {
        _stateSearch = StateSearch.noData;
        notifyListeners();
        return _message = 'Data is Empty';
      }
    } catch (error) {
      _stateSearch = StateSearch.error;
      notifyListeners();
      return _message = 'No data was found';
    }
  }
}
