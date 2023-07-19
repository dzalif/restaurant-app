import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/db/app_database.dart';


enum ResultFavoriteState { loading, noData, hasData, error }

class AddRestaurantFavoriteProvider extends ChangeNotifier {
  final AppDatabase appDatabase;

  AddRestaurantFavoriteProvider({required this.appDatabase});

  RestaurantTableData? _restaurantResult;
  ResultFavoriteState? _state;
  String _message = '';

  String get message => _message;

  RestaurantTableData? get result => _restaurantResult;

  ResultFavoriteState? get state => _state;

  Future<dynamic> addRestaurantToFavorite(RestaurantTableData restaurant) async {
    try {
      _state = ResultFavoriteState.loading;
      notifyListeners();
      final data = await appDatabase.restaurantDao.insertRestaurant(restaurant);
      _state = ResultFavoriteState.hasData;
      notifyListeners();
      return _restaurantResult = data;
    } catch (e) {
      _state = ResultFavoriteState.error;
      notifyListeners();
      return _message = 'There is unknown error';
    }
  }
}
