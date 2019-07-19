part of 'dog.dart';
// import 'package:realm/src/dart/bindings/bindings.dart';
// import 'package:realm/src/dart/bindings/types.dart';
// export 'package:realm/src/dart/ffi/cstring.dart' show CString;


// import 'package:realm/src/dart/bindings/types.dart';
// import 'package:realm/src/dart/bindings/bindings.dart';
// import 'package:realm/src/dart/bindings/bindings.dart';

class Dog$Realm extends Dog {
  Pointer<types.RealmObject> _otherRealmLinkPointer;
  Realm realm;  
  // Pointer<types.RealmObject> _objectPointer;
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
    final Pointer<Utf8> propertyNameC = Utf8.allocate("name"); //TODO cache to avoid lookup then free when object is finalized
    final Pointer<Utf8> valueC = bindings.wrapper_object_get_string(objectPointer, propertyNameC);
    String value = valueC.load<Utf8>().toString();
    valueC.free();
    return value;
  }

  set name(String newName) {
    final Pointer<Utf8> propertyNameC = Utf8.allocate("name");
    final Pointer<Utf8> valueC = Utf8.allocate(newName);
    bindings.wrapper_object_set_string(objectPointer, propertyNameC, valueC);
    valueC.free();
  }

  Dog get other {
    if (super.other == null) {
      super.other = Dog$Realm();
      super.other.objectPointer = _otherRealmLinkPointer;
    }
    return super.other;
  }

  RealmList<Dog> get others {
    if (super.others == null) {
      super.others = RealmList();
      super.others.tableName = "Dog";
      final Pointer<Utf8> propertyNameC = Utf8.allocate("others"); //TODO cache to avoid lookup then free when object is finalized
      final Pointer<types.RealmList> valueC = bindings.wrapper_object_get_list(objectPointer, propertyNameC);
      propertyNameC.free();
      super.others.nativeRealmListPointer = valueC;
    }
    return super.others;
  }

  @override
  String get schemaToJson {
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
  String get tableName => "Dog";

  @override
  bool get isManaged => true;
  // @override
  // void setNativePointer(Pointer<types.RealmObject> objectPointer) {
  //   _objectPointer = objectPointer;
  // }

  void persist<T extends RealmModel>(T obj) {
    this.name = (obj as Dog).name;
    this.age = (obj as Dog).age;
  }
}
