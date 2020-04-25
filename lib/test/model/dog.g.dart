part of 'dog.dart';

class Dog$Realm extends Dog {

  String get name {
    final propertyNameC = Utf8.toUtf8(
        "name"); //TODO cache to avoid lookup then free when object is finalized
    final valueC =
        bindings.wrapper_object_get_string(objectPointer, propertyNameC);
    //String value = valueC.load<Utf8>().toString();
    String value = valueC.ref.toString();
    free(valueC);
    return value;
  }

  set name(String newName) {
    final propertyNameC = Utf8.toUtf8("name");
    final valueC = Utf8.toUtf8(newName);
    bindings.wrapper_object_set_string(objectPointer, propertyNameC, valueC);
    free(valueC);
  }

  Dog get mother {
    if (super.mother == null) {
      // we do know the type of the object from the parent class, thx to the code gen
      final propertyNameC = Utf8.toUtf8("mother");
      final Pointer<RealmObjectType> pointerRealmObject =
          bindings.wrapper_object_get_object(objectPointer, propertyNameC);
      if (pointerRealmObject.address != 0) { //TODO cache this lookup so we want call the C++ to check the 
                                                  // link nullability each time? how about the use case where a transaction set a new link,
                                                  // we need to invalidate all proxy caches after a commit. 
        super.mother = Dog$Realm();
        super.mother.objectPointer = pointerRealmObject;
      } // else link is null
      free(propertyNameC);
    }
    return super.mother;
  }

  set mother (Dog dog) {
    if (dog == null) {
      // TODO set property to null
      return;
    }
    Pointer<RealmObjectType> nativePointer;
    if (dog.isManaged) {
      nativePointer = dog.objectPointer;
    } else {
      Dog$Realm managedDog = realm.create<Dog>(dog);
      nativePointer = managedDog.objectPointer;
    }

    final propertyNameC = Utf8.toUtf8("mother");
    bindings.wrapper_object_set_object(objectPointer, propertyNameC, nativePointer);
  }

  RealmList<Dog> get others {
    if (super.others == null) {
      super.others = RealmList();
      super.others.tableName = "Dog";
      final propertyNameC = Utf8.toUtf8(
          "others"); //TODO cache to avoid lookup then free when object is finalized
      final Pointer<RealmListType> pointerRealmList =
          bindings.wrapper_object_get_list(objectPointer, propertyNameC);
      free(propertyNameC);
      super.others.realm = realm;
      super.others.nativeRealmListPointer = pointerRealmList;
    }
    return super.others;
  }

  set others(RealmList<Dog> dogs) {
    // clear & add all elements
    bindings.wrapper_realmlist_clear(this.others.nativeRealmListPointer);
    if (dogs != null) {
      this.others.addAll(dogs);
    }
  }

  RealmResults<Dog> get litter {
    if (super.litter == null) {
      super.litter = RealmResults();
      super.litter.tableName = "Dog";
      final propertyNameC = Utf8.toUtf8("litter");
      final Pointer<RealmResultsType> pointerRealmResults =
          bindings.wrapper_object_get_linkingobjects(objectPointer, propertyNameC);
      free(propertyNameC);
      super.litter.realm = realm;
      super.litter.nativePointer = pointerRealmResults;
    }
    return super.litter;
  }

  set litter(RealmResults<Dog> items) {
    throw Exception("Setting a linkingObjects property ('litter') is not supported");
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
    this.mother = (obj as Dog).mother;
    this.others = (obj as Dog).others;
  }
}
