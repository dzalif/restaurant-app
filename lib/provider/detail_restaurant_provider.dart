import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';

import '../data/api/api_service.dart';

enum ResultState { loading, noData, hasData, error }

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  DetailRestaurantProvider({required this.apiService});

  DetailRestaurantResponse? _restaurantResult;
  ResultState? _state;
  String _message = '';

  String get message => _message;

  DetailRestaurantResponse? get result => _restaurantResult;

  ResultState? get state => _state;

  Future<dynamic> fetchDetailRestaurant(String? id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final data = await apiService.getDetailRestaurant(id);
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
