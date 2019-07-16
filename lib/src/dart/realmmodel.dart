
// import 'package:realm/src/dart/bindings/types.dart';
// import "bindings/types.dart";
// import 'package:realm/src/dart/bindings/bindings.dart';
// import 'package:realm/src/dart/realm.dart';

import 'bindings/types.dart';

class RealmModel {
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
  String schemaToJson() {}

  String tableName() {}

  void setDatabasePointer(DatabasePointer databasePointer) {}
  void setNativePointer(RealmObjectPointer objectPointer) {}
  
}