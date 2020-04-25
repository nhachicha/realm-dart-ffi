import 'dart:ffi';

import 'package:realm/src/dart/bindings/types.dart' as types;
import 'package:realm/src/dart/realm_model.dart';
import 'package:realm/src/dart/realm_configuration.dart';
import 'package:realm/src/dart/realm_results.dart';
import 'package:realm/src/dart/bindings/bindings.dart';
import "package:ffi/ffi.dart";

class Realm {
  RealmConfiguration realmConfiguration; // to be injected with the one generated at compile time
  Pointer<types.DatabaseType> _databasePointer;

  Future<void> open() async {
    final pathC = Utf8.toUtf8(realmConfiguration.path());
    final schemaC = Utf8.toUtf8(realmConfiguration.getSchemaAsJSON());

    _databasePointer = bindings.wrapper_create(pathC, schemaC);

    free(pathC);
    free(schemaC);
  }

  Future<void> close() async {
    bindings.wrapper_destroy(_databasePointer);
    _databasePointer = null;
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

  T create<T extends RealmModel>([T obj]) {
    T proxyInstance = realmConfiguration.newProxyInstance<T>(T);

    final Pointer<Utf8> objectTypeC = Utf8.toUtf8(proxyInstance.tableName);
    Pointer<types.RealmObjectType> objectPointer = bindings.wrapper_add_object(_databasePointer, objectTypeC);
    free(objectTypeC);

    proxyInstance.objectPointer = objectPointer;
    proxyInstance.realm = this;
    
    if(obj != null) {
      proxyInstance.persist(obj);
    }
    return proxyInstance;
  }

  Future<void> delete<T extends RealmModel>(T objectInstance) async {
    bindings.wrapper_delete_object(_databasePointer, objectInstance.objectPointer);
  }

  Future<RealmResults<T>> objects<T extends RealmModel>(String query) async {//TODO make query optional, so passing nothing ie equivalent to findAll
    // create RealmResults which holds the query results
    RealmResults<T> realmresultsInstance = realmConfiguration.newRealmResultsInstance<T>(T);

    final objectTypeC = Utf8.toUtf8(realmresultsInstance.tableName);
    final queryC = Utf8.toUtf8(query);
    realmresultsInstance.nativePointer = bindings.wrapper_query(_databasePointer, objectTypeC, queryC);
    realmresultsInstance.realm = this;
    free(objectTypeC);
    free(queryC);

    return realmresultsInstance;
  }
}