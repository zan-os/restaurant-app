import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/models/details.dart';

enum StateDetail { noData, hasData, loading, error }

class DetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailProvider({required this.apiService, required this.id}) {
    _fetchAllDetails();
  }

  StateDetail? _state;
  RestaurantDetail? _restaurantDetail;
  String _message = '';

  String get message => _message;
  StateDetail? get detailState => _state;
  RestaurantDetail? get resultState => _restaurantDetail;

  Future<dynamic> _fetchAllDetails() async {
    try {
      _state = StateDetail.loading;
      notifyListeners();
      final restaurantApi = await apiService.detailRestaurant(id);

      if (restaurantApi.restaurant.id.isNotEmpty) {
        _state = StateDetail.hasData;
        notifyListeners();
        return _restaurantDetail = restaurantApi;
      } else {
        _state = StateDetail.noData;
        notifyListeners();
        return _message = 'Data is empty';
      }
    } catch (error) {
      _state = StateDetail.error;
      notifyListeners();
      return _message = 'Error => $error';
    }
  }
}
