import 'package:drift/drift.dart';

class RestaurantTable extends Table {
  TextColumn get restaurantId => text()();
  TextColumn get name => text()();
  TextColumn get description => text()();
  TextColumn get pictureId => text()();
  TextColumn get city => text()();
  RealColumn get rating => real()();
  BoolColumn get isFavorite => boolean()();
}