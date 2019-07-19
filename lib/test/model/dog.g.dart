part of 'dog.dart';
// import 'package:realm/src/dart/bindings/bindings.dart';
// import 'package:realm/src/dart/bindings/types.dart';
// export 'package:realm/src/dart/ffi/cstring.dart' show CString;

// import 'package:realm/src/dart/bindings/types.dart';
// import 'package:realm/src/dart/bindings/bindings.dart';
// import 'package:realm/src/dart/bindings/bindings.dart';

class Dog$Realm extends Dog {

  String get name {
    final Pointer<Utf8> propertyNameC = Utf8.allocate(
        "name"); //TODO cache to avoid lookup then free when object is finalized
    final Pointer<Utf8> valueC =
        bindings.wrapper_object_get_string(objectPointer, propertyNameC);
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
      // we do know the type of the object from the parent class, thx to the code gen
      final Pointer<Utf8> propertyNameC = Utf8.allocate("other");
      final Pointer<types.RealmObject> pointerRealmObject =
          bindings.wrapper_object_get_object(objectPointer, propertyNameC);
      if (pointerRealmObject.address != 0) { //TODO cache this lookup so we want call the C++ to check the 
                                                  // link nullability each time? how about the use case where a transaction set a new link,
                                                  // we need to invalidate all proxy caches after a commit. 
        super.other = Dog$Realm();
        super.other.objectPointer = pointerRealmObject;
      } // else link is null
      propertyNameC.free();
    }
    return super.other;
  }


  set other (Dog dog) {
    Pointer<types.RealmObject> nativePointer;
    if (dog.isManaged) {
      nativePointer = dog.objectPointer;
    } else {
      Dog$Realm managedDog = realm.create<Dog>(dog);
      nativePointer = managedDog.objectPointer;
    }

    final Pointer<Utf8> propertyNameC = Utf8.allocate("other");
    bindings.wrapper_object_set_object(objectPointer, propertyNameC, nativePointer);
  }

  RealmList<Dog> get others {
    if (super.others == null) {
      super.others = RealmList();
      super.others.tableName = "Dog";
      final Pointer<Utf8> propertyNameC = Utf8.allocate(
          "others"); //TODO cache to avoid lookup then free when object is finalized
      final Pointer<types.RealmList> pointerRealmList =
          bindings.wrapper_object_get_list(objectPointer, propertyNameC);
      propertyNameC.free();
      super.others.realm = realm;
      super.others.nativeRealmListPointer = pointerRealmList;
    }
    return super.others;
  }

  set others(RealmList<Dog> newList) {
    throw Exception("Not supported in managed mode"); //TODO add test case
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

  void persist<T extends RealmModel>(T obj) {
    this.name = (obj as Dog).name;
    this.age = (obj as Dog).age;
  }
}
