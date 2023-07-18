// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Notification extends _Notification
    with RealmEntity, RealmObjectBase, RealmObject {
  Notification(
    String id,
    String title,
    String description,
    bool isSeen, {
    String? deepLink,
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'title', title);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'deepLink', deepLink);
    RealmObjectBase.set(this, 'isSeen', isSeen);
  }

  Notification._();

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
  String? get deepLink =>
      RealmObjectBase.get<String>(this, 'deepLink') as String?;
  @override
  set deepLink(String? value) => RealmObjectBase.set(this, 'deepLink', value);

  @override
  bool get isSeen => RealmObjectBase.get<bool>(this, 'isSeen') as bool;
  @override
  set isSeen(bool value) => RealmObjectBase.set(this, 'isSeen', value);

  @override
  Stream<RealmObjectChanges<Notification>> get changes =>
      RealmObjectBase.getChanges<Notification>(this);

  @override
  Notification freeze() => RealmObjectBase.freezeObject<Notification>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Notification._);
    return const SchemaObject(
        ObjectType.realmObject, Notification, 'Notification', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('deepLink', RealmPropertyType.string, optional: true),
      SchemaProperty('isSeen', RealmPropertyType.bool),
    ]);
  }
}
