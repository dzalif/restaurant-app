import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/review/add_review_request.dart';
import 'package:restaurant_app/data/model/review/add_review_response.dart';

import '../data/api/api_service.dart';

enum ResultReviewState { loading, noData, hasData, error }

class AddReviewProvider extends ChangeNotifier {
  final ApiService apiService;

  AddReviewProvider({required this.apiService});

  AddReviewResponse? _reviewResult;
  ResultReviewState? _state;
  String _message = '';

  String get message => _message;

  AddReviewResponse? get result => _reviewResult;

  ResultReviewState? get state => _state;

  Future<dynamic> addReview(AddReviewRequest request) async {
    try {
      _state = ResultReviewState.loading;
      notifyListeners();
      final data = await apiService.addReview(request);
      _state = ResultReviewState.hasData;
      notifyListeners();
      return _reviewResult = data;
    } catch (e) {
      _state = ResultReviewState.error;
      notifyListeners();
      return _message = 'There is unknown error';
    }
  }
}
