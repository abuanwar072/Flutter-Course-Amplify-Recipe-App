// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Recipe extends _Recipe with RealmEntity, RealmObjectBase, RealmObject {
  static var _defaultsSet = false;

  Recipe(
    String id,
    String title,
    String description,
    int serve,
    String duration,
    String category,
    String image,
    bool isFavorited,
    DateTime createdAt, {
    bool isSynced = false,
    Iterable<String> ingredients = const [],
  }) {
    if (!_defaultsSet) {
      _defaultsSet = RealmObjectBase.setDefaults<Recipe>({
        'isSynced': false,
      });
    }
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'serve', serve);
    RealmObjectBase.set(this, 'duration', duration);
    RealmObjectBase.set(this, 'category', category);
    RealmObjectBase.set(this, 'image', image);
    RealmObjectBase.set(this, 'isFavorited', isFavorited);
    RealmObjectBase.set(this, 'createdAt', createdAt);
    RealmObjectBase.set(this, 'isSynced', isSynced);
    RealmObjectBase.set<RealmList<String>>(
        this, 'ingredients', RealmList<String>(ingredients));
  }

  Recipe._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get title => RealmObjectBase.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObjectBase.set(this, 'title', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>
      RealmObjectBase.set(this, 'description', value);

  @override
  int get serve => RealmObjectBase.get<int>(this, 'serve') as int;
  @override
  set serve(int value) => RealmObjectBase.set(this, 'serve', value);

  @override
  String get duration =>
      RealmObjectBase.get<String>(this, 'duration') as String;
  @override
  set duration(String value) => RealmObjectBase.set(this, 'duration', value);

  @override
  String get category =>
      RealmObjectBase.get<String>(this, 'category') as String;
  @override
  set category(String value) => RealmObjectBase.set(this, 'category', value);

  @override
  String get image => RealmObjectBase.get<String>(this, 'image') as String;
  @override
  set image(String value) => RealmObjectBase.set(this, 'image', value);

  @override
  bool get isFavorited =>
      RealmObjectBase.get<bool>(this, 'isFavorited') as bool;
  @override
  set isFavorited(bool value) =>
      RealmObjectBase.set(this, 'isFavorited', value);

  @override
  RealmList<String> get ingredients =>
      RealmObjectBase.get<String>(this, 'ingredients') as RealmList<String>;
  @override
  set ingredients(covariant RealmList<String> value) =>
      throw RealmUnsupportedSetError();

  @override
  DateTime get createdAt =>
      RealmObjectBase.get<DateTime>(this, 'createdAt') as DateTime;
  @override
  set createdAt(DateTime value) =>
      RealmObjectBase.set(this, 'createdAt', value);

  @override
  bool get isSynced => RealmObjectBase.get<bool>(this, 'isSynced') as bool;
  @override
  set isSynced(bool value) => RealmObjectBase.set(this, 'isSynced', value);

  @override
  Stream<RealmObjectChanges<Recipe>> get changes =>
      RealmObjectBase.getChanges<Recipe>(this);

  @override
  Recipe freeze() => RealmObjectBase.freezeObject<Recipe>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Recipe._);
    return const SchemaObject(ObjectType.realmObject, Recipe, 'Recipe', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('serve', RealmPropertyType.int),
      SchemaProperty('duration', RealmPropertyType.string),
      SchemaProperty('category', RealmPropertyType.string),
      SchemaProperty('image', RealmPropertyType.string),
      SchemaProperty('isFavorited', RealmPropertyType.bool),
      SchemaProperty('ingredients', RealmPropertyType.string,
          collectionType: RealmCollectionType.list),
      SchemaProperty('createdAt', RealmPropertyType.timestamp),
      SchemaProperty('isSynced', RealmPropertyType.bool),
    ]);
  }
}
