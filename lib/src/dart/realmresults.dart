import 'dart:collection';
import 'package:realm/src/dart/bindings/bindings.dart';
import 'package:realm/src/dart/bindings/types.dart' as types;
//import 'package:realm/src/dart/ffi/cstring.dart';
import 'package:realm/src/dart/realmmodel.dart';
import 'package:realm/test/model/dog.dart';
import "ffi/utf8.dart";
import 'dart:ffi';

 class RealmResults<T extends RealmModel> extends ListBase<T> {
   //final RealmReusltsPointer _nativePointer to be passed with ctor
   // we also need wrapper pointer to make native calls 
   String tableName;
   Pointer<types.RealmResults> nativePointer;

  @override
  int get length {
    return bindings.wrapper_realmresults_size(nativePointer);
  }

  @override
  T operator [](int index) {
    // get native pointer & invoke the wrapper 
    final Pointer<Utf8> tableNameC = Utf8.allocate(tableName);
    Pointer<types.RealmObject> realmObjectPointer = bindings.wrapper_realmresults_get(nativePointer, tableNameC, index);
    tableNameC.free();

    // T proxyInstance = realmConfiguration.newProxyInstance<T>(T); TODO use this 
    Dog$Realm dog = new Dog$Realm();
    dog.setNativePointer(realmObjectPointer);

    return dog as T;
  }

  @override
  void operator []=(int index, T value) {
    throw Exception("Modifying a RealmResults is not supported");
  }

  @override
  void set length(int newLength) {
    throw Exception("Modifying a RealmResults is not supported");
  }

  
  
}