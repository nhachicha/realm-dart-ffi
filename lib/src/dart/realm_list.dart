import 'dart:collection';
import 'dart:ffi';
import 'package:realm/src/dart/bindings/bindings.dart';
import 'package:realm/src/dart/bindings/types.dart';
import 'package:realm/src/dart/realm.dart';
import 'package:realm/src/dart/realm_model.dart';
import 'package:realm/test/model/dog.dart';
import "package:ffi/ffi.dart";
import 'dart:ffi';

 class RealmList<T extends RealmModel> extends ListBase<T> {
   //final RealmReusltsPointer _nativePointer to be passed with ctor
   // we also need wrapper pointer to make native calls 
   String tableName;
   Pointer<RealmListType> nativeRealmListPointer;
   Realm realm;

  @override
  int get length {
    return bindings.wrapper_realmlist_size(nativeRealmListPointer);
  }

  @override
  void add(T value) {
    Pointer<RealmObjectType> nativePointer;
    if (value.isManaged) {
      nativePointer = value.objectPointer;
    } else {
      // persist recursively the object
      T persisted = realm.create<T>(value);
      // persist values
      nativePointer = persisted.objectPointer;
    }
    bindings.wrapper_realmlist_insert(nativeRealmListPointer, nativePointer, length);
  }

  @override
  void insert(int index, T item) {
    ArgumentError.checkNotNull(index, "index");
    RangeError.checkValueInInterval(index, 0, length, "index");
    bindings.wrapper_realmlist_insert(nativeRealmListPointer, item.objectPointer, index);
  }

  @override
  T removeAt(int index) {
    ArgumentError.checkNotNull(index, "index");
    RangeError.checkValueInInterval(index, 0, length - 1, "index");
    T removed = this[index];
    bindings.wrapper_realmlist_erase(nativeRealmListPointer, index);
    return removed;
  }

  @override
  void clear() {
    if (length == 0) {
      return;
    }
    bindings.wrapper_realmlist_clear(nativeRealmListPointer);
  }

  @override
  T operator [](int index) {
    // get native pointer & invoke the wrapper 
    final tableNameC = Utf8.toUtf8(tableName);
    Pointer<RealmObjectType> realmObjectPointer = bindings.wrapper_realmlist_get(nativeRealmListPointer, tableNameC, index);
    free(tableNameC);

    // T proxyInstance = realmConfiguration.newProxyInstance<T>(T); TODO use this 
    Dog$Realm dog = Dog$Realm();
    dog.objectPointer = realmObjectPointer;

    return dog as T;
  }

  @override
  void operator []=(int index, T value) {
    Pointer<RealmObjectType> nativePointer;
    if (value.isManaged) {
      nativePointer = value.objectPointer;
    } else {
      // persist recursively the object 
      T persisted = realm.create<T>(value);
      // persiste values
      nativePointer = persisted.objectPointer;
    }
    final tableNameC = Utf8.toUtf8(tableName);
    bindings.wrapper_realmlist_set(nativeRealmListPointer, nativePointer, index);
    free(tableNameC);
    //us the object pointer to set the list at the index position 
    // should be in a transaction either assign the pointer to the list or persist it first 

  }

  @override
  set length(int newLength) {
    throw Exception("Modifying length is not supported"); // Realm list items cannot be null
    
  }
}