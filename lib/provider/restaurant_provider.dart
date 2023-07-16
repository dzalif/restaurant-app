import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/list_restaurant_response.dart';

import '../data/api/api_service.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchListRestaurant();
  }

  late ListRestaurantResponse _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  ListRestaurantResponse get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> _fetchListRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final data = await apiService.getListRestaurant();
      if (data.restaurants.isEmpty) {
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
