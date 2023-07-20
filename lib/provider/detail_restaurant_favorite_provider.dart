import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/db/app_database.dart';


enum ResultDetailFavoriteState { loading, noData, hasData, error }

class DetailRestaurantFavoriteProvider extends ChangeNotifier {
  final AppDatabase appDatabase;

  DetailRestaurantFavoriteProvider({required this.appDatabase});

  RestaurantTableData? _restaurantResult;
  ResultDetailFavoriteState? _state;
  String _message = '';

  String get message => _message;

  RestaurantTableData? get result => _restaurantResult;

  ResultDetailFavoriteState? get state => _state;

  Future<dynamic> getDetailRestaurantFavorite(String id) async {
    try {
      _state = ResultDetailFavoriteState.loading;
      notifyListeners();
      final data = await appDatabase.restaurantDao.getRestaurantById(id);
      _state = ResultDetailFavoriteState.hasData;
      notifyListeners();
      return _restaurantResult = data;
    } catch (e) {
      _state = ResultDetailFavoriteState.error;
      notifyListeners();
      return _message = 'There is unknown error';
    }
  }
}
