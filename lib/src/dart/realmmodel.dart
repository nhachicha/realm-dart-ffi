
import 'dart:ffi';
import 'package:realm/src/dart/bindings/types.dart' as types;
import 'package:realm/src/dart/database.dart';


export 'dart:ffi';
export 'package:realm/src/dart/bindings/bindings.dart';
export 'package:realm/src/dart/bindings/types.dart';

class RealmModel {
  bool isManaged = false;
  Realm realm;
  Pointer<types.RealmObjectType> objectPointer;
  String tableName;
  String schemaToJson;

  void persist<T extends RealmModel>(T obj) {}  
}