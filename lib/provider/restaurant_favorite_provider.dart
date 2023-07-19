import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/db/app_database.dart';


enum ResultState { loading, noData, hasData, error }

class RestaurantFavoriteProvider extends ChangeNotifier {
  final AppDatabase appDatabase;

  RestaurantFavoriteProvider({required this.appDatabase}) {
    _getFavoriteRestaurant();
  }

  late List<RestaurantTableData> _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  List<RestaurantTableData> get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> _getFavoriteRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final data = await appDatabase.restaurantDao.getRestaurants();
      if (data.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = data;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'There is unknown error';
    }
  }
}
