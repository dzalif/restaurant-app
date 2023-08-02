import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/db/app_database.dart';


enum ResultFavoriteState { loading, noData, hasData, error }

class RestaurantFavoriteProvider extends ChangeNotifier {
  final AppDatabase appDatabase;

  RestaurantFavoriteProvider({required this.appDatabase}) {
    getFavoriteRestaurant();
  }

  late List<RestaurantTableData> _restaurantResult;
  late ResultFavoriteState _state;
  String _message = '';

  String get message => _message;

  List<RestaurantTableData> get result => _restaurantResult;

  ResultFavoriteState get state => _state;

  Future<dynamic> getFavoriteRestaurant() async {
    try {
      _state = ResultFavoriteState.loading;
      notifyListeners();
      final data = await appDatabase.restaurantDao.getRestaurants();
      if (data.isEmpty) {
        _state = ResultFavoriteState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultFavoriteState.hasData;
        notifyListeners();
        return _restaurantResult = data;
      }
    } catch (e) {
      _state = ResultFavoriteState.error;
      notifyListeners();
      return _message = 'There is unknown error';
    }
  }
}
