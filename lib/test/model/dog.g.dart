part of 'dog.dart';
// import 'package:realm/src/dart/bindings/bindings.dart';
// import 'package:realm/src/dart/bindings/types.dart';
// export 'package:realm/src/dart/ffi/cstring.dart' show CString;


// import 'package:realm/src/dart/bindings/types.dart';
// import 'package:realm/src/dart/bindings/bindings.dart';
// import 'package:realm/src/dart/bindings/bindings.dart';

class Dog$Realm extends Dog {
  DatabasePointer _databasePointer;
  RealmObjectPointer _objectPointer;
  // // NEED to port Row interface from Java and use it as composition/mixin to access/set properties of this Object/Row
  // @Override
  // @SuppressWarnings("cast")
  // public String realmGet$fieldString() {
  //     proxyState.getRealm$realm().checkIfValid();
  //     return (java.lang.String) proxyState.getRow$realm().getString(columnInfo.fieldStringIndex);
  // }

  // @Override
  // public void realmSet$fieldString(String value) {
  //     if (proxyState.isUnderConstruction()) {
  //         if (!proxyState.getAcceptDefaultValue$realm()) {
  //             return;
  //         }
  //         final Row row = proxyState.getRow$realm();
  //         if (value == null) {
  //             row.getTable().setNull(columnInfo.fieldStringIndex, row.getIndex(), true);
  //             return;
  //         }
  //         row.getTable().setString(columnInfo.fieldStringIndex, row.getIndex(), value, true);
  //         return;
  //     }

  //     proxyState.getRealm$realm().checkIfValid();
  //     if (value == null) {
  //         proxyState.getRow$realm().setNull(columnInfo.fieldStringIndex);
  //         return;
  //     }
  //     proxyState.getRow$realm().setString(columnInfo.fieldStringIndex, value);
  // }

  // String get name  => "<<___${super.name}___>>";
  String get name {
    CString propertyNameC = CString.allocate("name"); //TODO cache to avoid lookup then free when object is finalized 
    CString valueC = bindings.wrapper_object_get_string(_objectPointer, propertyNameC);
    String value = CString.fromUtf8(valueC);
    // valueC.free();
    return value;
  }

  set name(String newName) {
    CString propertyNameC = CString.allocate("name");
    CString valueC = CString.allocate(newName);
    bindings.wrapper_object_set_string(_objectPointer, propertyNameC, valueC);
    valueC.free();
  }

  @override
  String schemaToJson() {
    return '''{
      name: 'Dog',
      properties: {
        name:     'string',
        age: 'int',
        owner: Person
      }
    }''';
  }
  
  @override
  String tableName() {
    return "Dog";
  }

  @override
  void setDatabasePointer(DatabasePointer databasePointer) {
    _databasePointer = databasePointer;

  }

  @override
  void setNativePointer(RealmObjectPointer objectPointer) {
    _objectPointer = objectPointer;
  }
}
