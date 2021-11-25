import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/models/restaurant.dart';

enum StateDatabase { noData, hasData, loading, error }

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorite();
  }

  StateDatabase? _stateDatabase;
  StateDatabase? get state => _stateDatabase;

  String _message = '';
  String get message => _message;

  List<RestaurantElement> _favorites = [];
  List<RestaurantElement> get favorites => _favorites;

  void _getFavorite() async {
    _favorites = await databaseHelper.getFavorite();

    if (_favorites.length > 0) {
      _stateDatabase = StateDatabase.hasData;
    } else {
      _stateDatabase = StateDatabase.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavorite(RestaurantElement restaurantElement) async {
    try {
      await databaseHelper.insertFavorite(restaurantElement);
    } catch (e) {
      _stateDatabase = StateDatabase.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoritedRestaurant = await databaseHelper.getFavoriteById(id);
    return favoritedRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorite();
    } catch (e) {
      _stateDatabase = StateDatabase.error;
      _message = 'Error $e';
      notifyListeners();
    }
  }
}
