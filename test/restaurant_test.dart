
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/detail_restaurant_response.dart';

import 'restaurant_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late MockClient mockClient;
  late ApiService apiService;

  setUp(() {
    mockClient = MockClient();
    apiService = ApiService(mockClient);
  });

  const jsonString =
      '{"error":false,"message":"success","restaurant":{"id":"rqdv5juczeskfw1e867","name":"Melting Pot","description":"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.","city":"Medan","address":"Jln. Pandeglang no 19","pictureId":"14","categories":[{"name":"Italia"},{"name":"Modern"}],"menus":{"foods":[{"name":"Paket rosemary"},{"name":"Toastie salmon"},{"name":"Bebek crepes"},{"name":"Salad lengkeng"}],"drinks":[{"name":"Es krim"},{"name":"Sirup"},{"name":"Jus apel"},{"name":"Jus jeruk"},{"name":"Coklat panas"},{"name":"Air"},{"name":"Es kopi"},{"name":"Jus alpukat"},{"name":"Jus mangga"},{"name":"Teh manis"},{"name":"Kopi espresso"},{"name":"Minuman soda"},{"name":"Jus tomat"}]},"rating":4.2,"customerReviews":[{"name":"Ahmad","review":"Tidak rekomendasi untuk pelajar!","date":"13 November 2019"},{"name":"asdf","review":"asdf","date":"2 Agustus 2023"}]}}';

  final uri = Uri.parse("https://restaurant-api.dicoding.dev/detail/rqdv5juczeskfw1e867");

  List<Category> categories = [Category(name: 'Italia'), Category(name: 'Modern')];
  List<Category> foods = [Category(name: 'Paket rosemary'), Category(name: 'Toastie salmon'), Category(name: 'Bebek crepes'), Category(name: 'Salad lengkeng')];
  List<Category> drinks = [Category(name: 'Es krim'),Category(name: 'Sirup'),Category(name: 'Jus apel'),Category(name: 'Jus jeruk'),Category(name: 'Coklat panas'),Category(name: 'Air'),Category(name: 'Es kopi'),Category(name: 'Jus alpukat'),Category(name: 'Jus mangga'),Category(name: 'Teh manis'),Category(name: 'Kopi espresso'),Category(name: 'Minuman soda'),Category(name: 'Jus tomat')];
  var menus = Menus(foods: foods, drinks: drinks);
  List<CustomerReview> reviews = [CustomerReview(name: 'Ahmad', review: 'Tidak rekomendasi untuk pelajar!', date: '13 November 2019'),CustomerReview(name: 'asdf', review: 'asdf', date: '2 Agustus 2023')];
  var restaurant = DetailRestaurant(id: 'rqdv5juczeskfw1e867', name: 'Melting Pot', description: 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.', city: 'Medan', address: 'Jln. Pandeglang no 19', pictureId: '14', categories: categories, menus: menus, rating: 4.2, customerReviews: reviews);
  var response = DetailRestaurantResponse(error: false, message: "success", restaurant: restaurant);

  test(
      'should return restaurant name, when status code is 200',
      () async {
    when(mockClient.get(uri))
        .thenAnswer((_) async => http.Response(jsonString, 200));

    final result = await apiService.getDetailRestaurant('rqdv5juczeskfw1e867');
    expect(result.restaurant.name, equals(response.restaurant.name));
  });
}
