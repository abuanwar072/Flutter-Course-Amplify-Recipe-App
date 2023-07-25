// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_item.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class SearchItem extends _SearchItem
    with RealmEntity, RealmObjectBase, RealmObject {
  SearchItem(
    String id,
    String searchItem,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'searchItem', searchItem);
  }

  SearchItem._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get searchItem =>
      RealmObjectBase.get<String>(this, 'searchItem') as String;
  @override
  set searchItem(String value) =>
      RealmObjectBase.set(this, 'searchItem', value);

  @override
  Stream<RealmObjectChanges<SearchItem>> get changes =>
      RealmObjectBase.getChanges<SearchItem>(this);

  @override
  SearchItem freeze() => RealmObjectBase.freezeObject<SearchItem>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(SearchItem._);
    return const SchemaObject(
        ObjectType.realmObject, SearchItem, 'SearchItem', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('searchItem', RealmPropertyType.string),
    ]);
  }
}
