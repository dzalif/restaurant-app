import 'package:drift/drift.dart';
import 'package:restaurant_app/db/app_database.dart';

import '../table/restaurant_table.dart';

part 'restaurant_dao.g.dart';

@DriftAccessor(tables: [RestaurantTable])
class RestaurantDao extends DatabaseAccessor<AppDatabase> with _$RestaurantDaoMixin {
  RestaurantDao(AppDatabase db) : super(db);

  Future insertRestaurant(RestaurantTableData data) => into(restaurantTable).insert(data, mode: InsertMode.insertOrReplace);

  Future<List<RestaurantTableData>> getRestaurants() => select(restaurantTable).get();

  Future<RestaurantTableData> getRestaurantById(String id) => (select(restaurantTable)..where((restaurant) => restaurant.id.equals(id))).getSingle();

  Future deleteRestaurantById(String id) => (delete(restaurantTable)..where((t) => t.id.equals(id))..where((t) =>  t.id.equals(id))).go();
}


