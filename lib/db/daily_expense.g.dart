// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_expense.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class DailyExpense extends $DailyExpense
    with RealmEntity, RealmObjectBase, RealmObject {
  DailyExpense(
    ObjectId id,
    int amount,
    String name,
    String createDate,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'amount', amount);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'createDate', createDate);
  }

  DailyExpense._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, 'id') as ObjectId;
  @override
  set id(ObjectId value) => RealmObjectBase.set(this, 'id', value);

  @override
  int get amount => RealmObjectBase.get<int>(this, 'amount') as int;
  @override
  set amount(int value) => RealmObjectBase.set(this, 'amount', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get createDate =>
      RealmObjectBase.get<String>(this, 'createDate') as String;
  @override
  set createDate(String value) =>
      RealmObjectBase.set(this, 'createDate', value);

  @override
  Stream<RealmObjectChanges<DailyExpense>> get changes =>
      RealmObjectBase.getChanges<DailyExpense>(this);

  @override
  DailyExpense freeze() => RealmObjectBase.freezeObject<DailyExpense>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(DailyExpense._);
    return const SchemaObject(
        ObjectType.realmObject, DailyExpense, 'DailyExpense', [
      SchemaProperty('id', RealmPropertyType.objectid, primaryKey: true),
      SchemaProperty('amount', RealmPropertyType.int),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('createDate', RealmPropertyType.string),
    ]);
  }
}
