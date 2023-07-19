import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';
import 'package:restaurant_app/db/app_database.dart';


enum ResultState { loading, noData, hasData, error }

class DetailRestaurantFavoriteProvider extends ChangeNotifier {
  final AppDatabase appDatabase;

  DetailRestaurantFavoriteProvider({required this.appDatabase});

  DetailRestaurantResponse? _restaurantResult;
  ResultState? _state;
  String _message = '';

  String get message => _message;

  DetailRestaurantResponse? get result => _restaurantResult;

  ResultState? get state => _state;

  Future<dynamic> addRestaurantToFavorite(RestaurantTableData restaurant) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final data = await appDatabase.restaurantDao.insertRestaurant(restaurant);
      _state = ResultState.hasData;
      notifyListeners();
      return _restaurantResult = data;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'There is unknown error';
    }
  }
}
