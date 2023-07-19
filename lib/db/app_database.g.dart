// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $RestaurantTableTable extends RestaurantTable
    with TableInfo<$RestaurantTableTable, RestaurantTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RestaurantTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _restaurantIdMeta =
      const VerificationMeta('restaurantId');
  @override
  late final GeneratedColumn<String> restaurantId = GeneratedColumn<String>(
      'restaurant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pictureIdMeta =
      const VerificationMeta('pictureId');
  @override
  late final GeneratedColumn<String> pictureId = GeneratedColumn<String>(
      'picture_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<double> rating = GeneratedColumn<double>(
      'rating', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite =
      GeneratedColumn<bool>('is_favorite', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("is_favorite" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  @override
  List<GeneratedColumn> get $columns =>
      [restaurantId, name, description, pictureId, city, rating, isFavorite];
  @override
  String get aliasedName => _alias ?? 'restaurant_table';
  @override
  String get actualTableName => 'restaurant_table';
  @override
  VerificationContext validateIntegrity(
      Insertable<RestaurantTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('restaurant_id')) {
      context.handle(
          _restaurantIdMeta,
          restaurantId.isAcceptableOrUnknown(
              data['restaurant_id']!, _restaurantIdMeta));
    } else if (isInserting) {
      context.missing(_restaurantIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('picture_id')) {
      context.handle(_pictureIdMeta,
          pictureId.isAcceptableOrUnknown(data['picture_id']!, _pictureIdMeta));
    } else if (isInserting) {
      context.missing(_pictureIdMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    } else if (isInserting) {
      context.missing(_isFavoriteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  RestaurantTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RestaurantTableData(
      restaurantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}restaurant_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      pictureId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}picture_id'])!,
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city'])!,
      rating: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}rating'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
    );
  }

  @override
  $RestaurantTableTable createAlias(String alias) {
    return $RestaurantTableTable(attachedDatabase, alias);
  }
}

class RestaurantTableData extends DataClass
    implements Insertable<RestaurantTableData> {
  final String restaurantId;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final bool isFavorite;
  const RestaurantTableData(
      {required this.restaurantId,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.rating,
      required this.isFavorite});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['restaurant_id'] = Variable<String>(restaurantId);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['picture_id'] = Variable<String>(pictureId);
    map['city'] = Variable<String>(city);
    map['rating'] = Variable<double>(rating);
    map['is_favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  RestaurantTableCompanion toCompanion(bool nullToAbsent) {
    return RestaurantTableCompanion(
      restaurantId: Value(restaurantId),
      name: Value(name),
      description: Value(description),
      pictureId: Value(pictureId),
      city: Value(city),
      rating: Value(rating),
      isFavorite: Value(isFavorite),
    );
  }

  factory RestaurantTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RestaurantTableData(
      restaurantId: serializer.fromJson<String>(json['restaurantId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      pictureId: serializer.fromJson<String>(json['pictureId']),
      city: serializer.fromJson<String>(json['city']),
      rating: serializer.fromJson<double>(json['rating']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'restaurantId': serializer.toJson<String>(restaurantId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'pictureId': serializer.toJson<String>(pictureId),
      'city': serializer.toJson<String>(city),
      'rating': serializer.toJson<double>(rating),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  RestaurantTableData copyWith(
          {String? restaurantId,
          String? name,
          String? description,
          String? pictureId,
          String? city,
          double? rating,
          bool? isFavorite}) =>
      RestaurantTableData(
        restaurantId: restaurantId ?? this.restaurantId,
        name: name ?? this.name,
        description: description ?? this.description,
        pictureId: pictureId ?? this.pictureId,
        city: city ?? this.city,
        rating: rating ?? this.rating,
        isFavorite: isFavorite ?? this.isFavorite,
      );
  @override
  String toString() {
    return (StringBuffer('RestaurantTableData(')
          ..write('restaurantId: $restaurantId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('pictureId: $pictureId, ')
          ..write('city: $city, ')
          ..write('rating: $rating, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      restaurantId, name, description, pictureId, city, rating, isFavorite);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RestaurantTableData &&
          other.restaurantId == this.restaurantId &&
          other.name == this.name &&
          other.description == this.description &&
          other.pictureId == this.pictureId &&
          other.city == this.city &&
          other.rating == this.rating &&
          other.isFavorite == this.isFavorite);
}

class RestaurantTableCompanion extends UpdateCompanion<RestaurantTableData> {
  final Value<String> restaurantId;
  final Value<String> name;
  final Value<String> description;
  final Value<String> pictureId;
  final Value<String> city;
  final Value<double> rating;
  final Value<bool> isFavorite;
  final Value<int> rowid;
  const RestaurantTableCompanion({
    this.restaurantId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.pictureId = const Value.absent(),
    this.city = const Value.absent(),
    this.rating = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RestaurantTableCompanion.insert({
    required String restaurantId,
    required String name,
    required String description,
    required String pictureId,
    required String city,
    required double rating,
    required bool isFavorite,
    this.rowid = const Value.absent(),
  })  : restaurantId = Value(restaurantId),
        name = Value(name),
        description = Value(description),
        pictureId = Value(pictureId),
        city = Value(city),
        rating = Value(rating),
        isFavorite = Value(isFavorite);
  static Insertable<RestaurantTableData> custom({
    Expression<String>? restaurantId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? pictureId,
    Expression<String>? city,
    Expression<double>? rating,
    Expression<bool>? isFavorite,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (restaurantId != null) 'restaurant_id': restaurantId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (pictureId != null) 'picture_id': pictureId,
      if (city != null) 'city': city,
      if (rating != null) 'rating': rating,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RestaurantTableCompanion copyWith(
      {Value<String>? restaurantId,
      Value<String>? name,
      Value<String>? description,
      Value<String>? pictureId,
      Value<String>? city,
      Value<double>? rating,
      Value<bool>? isFavorite,
      Value<int>? rowid}) {
    return RestaurantTableCompanion(
      restaurantId: restaurantId ?? this.restaurantId,
      name: name ?? this.name,
      description: description ?? this.description,
      pictureId: pictureId ?? this.pictureId,
      city: city ?? this.city,
      rating: rating ?? this.rating,
      isFavorite: isFavorite ?? this.isFavorite,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (restaurantId.present) {
      map['restaurant_id'] = Variable<String>(restaurantId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (pictureId.present) {
      map['picture_id'] = Variable<String>(pictureId.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (rating.present) {
      map['rating'] = Variable<double>(rating.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RestaurantTableCompanion(')
          ..write('restaurantId: $restaurantId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('pictureId: $pictureId, ')
          ..write('city: $city, ')
          ..write('rating: $rating, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $RestaurantTableTable restaurantTable =
      $RestaurantTableTable(this);
  late final RestaurantDao restaurantDao = RestaurantDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [restaurantTable];
}
