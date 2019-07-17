import 'dart:ffi';

import 'package:realm/src/dart/bindings/types.dart' as types;
import 'package:realm/src/dart/realmmodel.dart';
import 'package:realm/src/dart/realmconfiguration.dart';
import 'package:realm/src/dart/realmresults.dart';
import 'package:realm/src/dart/bindings/bindings.dart';
import 'package:realm/src/dart/ffi/utf8.dart';

class Realm {
  RealmConfiguration realmConfiguration; // to be injected with the one generated at compile time
  Pointer<types.Database> _databasePointer;

  Future<void> open() async {
    final Pointer<Utf8> pathC = Utf8.allocate(realmConfiguration.path());
    final Pointer<Utf8> schemaC = Utf8.allocate(realmConfiguration.getSchemaAsJSON());

    _databasePointer = bindings.wrapper_create(pathC, schemaC);
    
    pathC.free();
    schemaC.free();
  }

  Future<void> close() async {
    bindings.wrapper_destroy(_databasePointer);
  }

  Future<Realm> beginTransaction() async {
    bindings.wrapper_begin_transaction(_databasePointer);
    return this;
  }

  Future<Realm> commitTransaction() async {
    bindings.wrapper_commit_transaction(_databasePointer);
    return this;
  }

  Future<Realm> cancelTransaction() async {
    bindings.wrapper_cancel_transaction(_databasePointer);
    return this;
  }

  Future<T> create<T extends RealmModel>() async {
    T proxyInstance = realmConfiguration.newProxyInstance<T>(T);

    final Pointer<Utf8> objectTypeC = Utf8.allocate(proxyInstance.tableName());
    Pointer<types.RealmObject> objectPointer = bindings.wrapper_add_object(_databasePointer, objectTypeC);
    objectTypeC.free();

    proxyInstance.setNativePointer(objectPointer);
    return proxyInstance;
  }

  Future<RealmResults<T>> objects<T extends RealmModel>(String query) async {
    // create RealmResults which holds the query results
    RealmResults<T> realmresultsInstance = realmConfiguration.newRealmResultsInstance<T>(T);

    final Pointer<Utf8> objectTypeC = Utf8.allocate(realmresultsInstance.tableName);
    final Pointer<Utf8> queryC = Utf8.allocate(query);
    realmresultsInstance.nativePointer = bindings.wrapper_query(_databasePointer, objectTypeC, queryC);
    objectTypeC.free();
    queryC.free();

    return realmresultsInstance;
  }
}