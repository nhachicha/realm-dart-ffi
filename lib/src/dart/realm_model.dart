
import 'dart:ffi';
import 'package:realm/src/dart/bindings/types.dart' as types;
import 'package:realm/src/dart/database.dart';
// import "bindings/types.dart";
// import 'package:realm/src/dart/bindings/bindings.dart';
// import 'package:realm/src/dart/realm.dart';

//import 'bindings/types.dart';

class RealmModel {
  bool isManaged = false;
  Realm realm;
  Pointer<types.RealmObject> objectPointer;
  String tableName;
  String schemaToJson;

  void persist<T extends RealmModel>(T obj) {}  
}