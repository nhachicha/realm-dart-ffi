import 'dart:collection';
import 'package:realm/src/dart/bindings/bindings.dart';
import 'package:realm/src/dart/bindings/types.dart' as types;
import 'package:realm/src/dart/realm.dart';
import 'package:realm/src/dart/realmmodel.dart';
import 'package:realm/test/model/dog.dart';
import "ffi/utf8.dart";
import 'dart:ffi';

 class RealmList<T extends RealmModel> extends ListBase<T> {
   //final RealmReusltsPointer _nativePointer to be passed with ctor
   // we also need wrapper pointer to make native calls 
   String tableName;
   Pointer<types.RealmList> nativeRealmListPointer;
   Realm realm;
     
  @override
  int get length {
    return bindings.wrapper_realmlist_size(nativeRealmListPointer);
  }

  @override
  T operator [](int index) {
    // get native pointer & invoke the wrapper 
    final Pointer<Utf8> tableNameC = Utf8.allocate(tableName);
    Pointer<types.RealmObject> realmObjectPointer = bindings.wrapper_realmlist_get(nativeRealmListPointer, tableNameC, index);
    tableNameC.free();

    // T proxyInstance = realmConfiguration.newProxyInstance<T>(T); TODO use this 
    Dog$Realm dog = new Dog$Realm();
    dog.objectPointer = realmObjectPointer;

    return dog as T;
  }

  @override
  void operator []=(int index, T value) {
    Pointer<types.RealmObject> nativePointer;
    if (value.isManaged) {
      nativePointer = value.objectPointer;
    } else {
      // persist recursively the object 
      T persisted = realm.create<T>(value) as T;
      // persiste values
      nativePointer = persisted.objectPointer;
    }
    final Pointer<Utf8> tableNameC = Utf8.allocate(tableName);
    bindings.wrapper_realmlist_set(nativeRealmListPointer, nativePointer, index);
    tableNameC.free();
    //us the object pointer to set the list at the index position 
    // should be in a transaction either assign the pointer to the list or persist it first 

  }

  @override
  void set length(int newLength) {
    throw Exception("Modifying length is not supported");// THIS could also be a no-op
    
  }


  
  
}