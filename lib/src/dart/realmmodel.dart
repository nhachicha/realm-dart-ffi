
import 'dart:ffi';
import 'package:realm/src/dart/bindings/types.dart' as types;
// import "bindings/types.dart";
// import 'package:realm/src/dart/bindings/bindings.dart';
// import 'package:realm/src/dart/realm.dart';

//import 'bindings/types.dart';

class RealmModel {
  bool isManaged = false;
  Pointer<types.RealmObject> objectPointer;
  String tableName;
  String schemaToJson;
  // Schema String should be compatible with JS
  // example:
//    {
//   name: 'Car',
//   properties: {
//     make:  'string',
//     model: 'string',
//     miles: {type: 'int', default: 0},
//   }
// }
  // String schemaToJson() {}

  // String tableName() {}

  void persist<T extends RealmModel>(T obj) {}

  

  // void setNativePointer(Pointer<types.RealmObject> objectPointer) {}
  
}