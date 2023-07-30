import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/model/list_restaurant_response.dart';

import 'restaurant_test.mocks.dart';

Future<ListRestaurantResponse> fetchRestaurants(http.Client client) async {
  final response =
      await client.get(Uri.parse('https://restaurant-api.dicoding.dev/list'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return ListRestaurantResponse.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

@GenerateMocks([http.Client])
void main() {
  group('Fetch restaurant', () {
    test('returns restaurants  if the http call success', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response(
              '{"error": false, "message": "success", "count": 20, "restaurants": [{"id": "rqdv5juczeskfw1e867", "name": "Melting Pot", "description": "Lorem ipsum dolor sit amet", "pictureId": "14", "city": "Medan", "rating": 4.2}]}',
              200));

      expect(await fetchRestaurants(client), isA<ListRestaurantResponse>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client
          .get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchRestaurants(client), throwsException);
    });
  });
}
