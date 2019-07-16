import 'package:realm/src/dart/bindings/types.dart';
import 'package:realm/src/dart/realmmodel.dart';
import 'package:realm/src/dart/realmconfiguration.dart';

import "bindings/bindings.dart";
import "ffi/cstring.dart";

class Realm {
  RealmConfiguration realmConfiguration; // to be injected with the one generated at compile time
  DatabasePointer _databasePointer;

  Future<void> open() async {
    CString pathC = CString.allocate(realmConfiguration.path());
    CString schemaC = CString.allocate(realmConfiguration.getSchemaAsJSON());

    _databasePointer = bindings.wrapper_create(pathC, schemaC);
    
    pathC.free();
    schemaC.free();
  }

  Future<void> close() async {
    bindings.wrapper_destroy(_databasePointer);
  }

  Future<void> beginTransaction() async {
    bindings.wrapper_begin_transaction(_databasePointer);
  }

  Future<void> commitTransaction() async {
    bindings.wrapper_commit_transaction(_databasePointer);
  }

  Future<void> cancelTransaction() async {
    bindings.wrapper_cancel_transaction(_databasePointer);
  }

  Future<T> create<T extends RealmModel>(T obj) async {
    T proxyInstance = realmConfiguration.newProxyInstance(obj);
    
    CString objectTypeC = CString.allocate(obj.runtimeType.toString());
    RealmObjectPointer objectPointer = bindings.wrapper_add_object(_databasePointer, objectTypeC);
    objectTypeC.free();

    proxyInstance.setDatabasePointer(_databasePointer);
    proxyInstance.setNativePointer(objectPointer);
    
    return proxyInstance;
  }

}