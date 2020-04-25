import 'dart:ffi';

import 'package:realm/src/dart/ffi/dylib_utils.dart';

import 'package:realm/src/dart/bindings/signatures.dart';
import 'package:realm/src/dart/bindings/types.dart';
import "package:ffi/ffi.dart";

class _RealmBindings {
  DynamicLibrary realm;

  Pointer<DatabaseType> Function(Pointer<Utf8> filename, Pointer<Utf8> schema) wrapper_create;
  void Function(Pointer<DatabaseType> database) wrapper_destroy;
  void Function(Pointer<DatabaseType> databasePointer) wrapper_begin_transaction;
  void Function(Pointer<DatabaseType> databasePointer) wrapper_commit_transaction;
  void Function(Pointer<DatabaseType> databasePointer) wrapper_cancel_transaction;
  Pointer<RealmObjectType> Function(Pointer<DatabaseType> databasePointer, Pointer<Utf8> objectType) wrapper_add_object;
  void Function(Pointer<DatabaseType> databasePointer, Pointer<RealmObjectType>) wrapper_delete_object;
  int Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName) wrapper_object_get_bool;
  void Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName, int value) wrapper_object_set_bool;
  int Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName) wrapper_object_get_int64;
  void Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName, int value) wrapper_object_set_int64;
  double Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName) wrapper_object_get_double;
  void Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName, double value) wrapper_object_set_double;
  Pointer<Utf8> Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName) wrapper_object_get_string;
  void Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName, Pointer<RealmObjectType> value) wrapper_object_set_object;
  Pointer<RealmObjectType> Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName) wrapper_object_get_object;
  Pointer<RealmListType> Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName) wrapper_object_get_list;
  Pointer<RealmResultsType> Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName) wrapper_object_get_linkingobjects;
  void Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName, Pointer<Utf8> value) wrapper_object_set_string;
  Pointer<RealmResultsType> Function(Pointer<DatabaseType> databasePointer, Pointer<Utf8> object_type, Pointer<Utf8> query_string) wrapper_query;
  int Function(Pointer<RealmResultsType> realmresultsPointer) wrapper_realmresults_size;
  void Function(Pointer<RealmResultsType> realmresultsPointer) wrapper_realmresults_delete;
  Pointer<RealmObjectType> Function(Pointer<RealmResultsType> realmresultsPointer, Pointer<Utf8> object_type, int index) wrapper_realmresults_get;  
  int Function(Pointer<RealmListType> realmlistPointer) wrapper_realmlist_size;
  void Function(Pointer<RealmListType> realmlistPointer, Pointer<RealmObjectType> objectPointer, int index) wrapper_realmlist_insert;
  void Function(Pointer<RealmListType> realmlistPointer, int index) wrapper_realmlist_erase;
  void Function(Pointer<RealmListType> realmlistPointer) wrapper_realmlist_clear;
  Pointer<RealmObjectType> Function(Pointer<RealmListType> nativeRealmListPointer, Pointer<Utf8> object_type, int index) wrapper_realmlist_get;
  void Function(Pointer<RealmListType> nativeRealmListPointer, Pointer<RealmObjectType> objectPointer, int index) wrapper_realmlist_set; 

  
  static int simpleAddition(int x, int y) => x + y;

  _RealmBindings({String path = './lib/src/cpp/'}) {
    realm = dlopenPlatformSpecific("realm-dart", path: path);
    wrapper_create = realm
        .lookup<NativeFunction<wrapper_create_native_t>>("create")
        .asFunction();
    wrapper_destroy = realm
        .lookup<NativeFunction<wrapper_destroy_native_t>>("destroy")
        .asFunction();
    wrapper_begin_transaction = realm
        .lookup<NativeFunction<wrapper_begin_transaction_native_t>>("begin_transaction")
        .asFunction();
    wrapper_commit_transaction = realm
        .lookup<NativeFunction<wrapper_commit_transaction_native_t>>("commit_transaction")
        .asFunction();
    wrapper_cancel_transaction = realm
        .lookup<NativeFunction<wrapper_cancel_transaction_native_t>>("cancel_transaction")
        .asFunction();
    wrapper_add_object = realm
        .lookup<NativeFunction<wrapper_add_object_native_t>>("add_object")
        .asFunction();
    wrapper_delete_object = realm
        .lookup<NativeFunction<wrapper_delete_object_native_t>>("delete_object")
        .asFunction();
    wrapper_object_get_bool = realm
        .lookup<NativeFunction<wrapper_object_get_bool_native_t>>("object_get_bool")
        .asFunction();
    wrapper_object_set_bool = realm
        .lookup<NativeFunction<wrapper_object_set_bool_native_t>>("object_set_bool")
        .asFunction();
    wrapper_object_get_int64 = realm
        .lookup<NativeFunction<wrapper_object_get_int64_native_t>>("object_get_int64")
        .asFunction();
    wrapper_object_set_int64 = realm
        .lookup<NativeFunction<wrapper_object_set_int64_native_t>>("object_set_int64")
        .asFunction();
    wrapper_object_get_double = realm
        .lookup<NativeFunction<wrapper_object_get_double_native_t>>("object_get_double")
        .asFunction();
    wrapper_object_set_double = realm
        .lookup<NativeFunction<wrapper_object_set_double_native_t>>("object_set_double")
        .asFunction();
    wrapper_object_get_string = realm
        .lookup<NativeFunction<wrapper_object_get_string_native_t>>("object_get_string")
        .asFunction();
    wrapper_object_set_string = realm
        .lookup<NativeFunction<wrapper_object_set_string_native_t>>("object_set_string")
        .asFunction();
  wrapper_object_get_object = realm
        .lookup<NativeFunction<wrapper_object_get_object_native_t>>("object_get_object")
        .asFunction();
  wrapper_object_set_object = realm
        .lookup<NativeFunction<wrapper_object_set_object_native_t>>("object_set_object")
        .asFunction();
    wrapper_object_get_list = realm
        .lookup<NativeFunction<wrapper_object_get_list_native_t>>("object_get_list")
        .asFunction();
    wrapper_object_get_linkingobjects = realm
        .lookup<NativeFunction<wrapper_object_get_linkingobjects_native_t>>("object_get_linkingobjects")
        .asFunction();
    wrapper_query = realm
        .lookup<NativeFunction<wrapper_query_native_t>>("query")
        .asFunction();
    wrapper_realmresults_size = realm
        .lookup<NativeFunction<wrapper_results_size_native_t>>("realmresults_size")
        .asFunction();
    wrapper_realmresults_delete = realm
        .lookup<NativeFunction<wrapper_results_delete_native_t>>("realmresults_delete")
        .asFunction();
    wrapper_realmresults_get = realm
        .lookup<NativeFunction<wrapper_results_get_native_t>>("realmresults_get")
        .asFunction();
    wrapper_realmlist_size = realm
        .lookup<NativeFunction<wrapper_realmlist_size_native_t>>("realmlist_size")
        .asFunction();
    wrapper_realmlist_clear = realm
        .lookup<NativeFunction<wrapper_realmlist_clear_native_t>>("realmlist_clear")
        .asFunction();
    wrapper_realmlist_insert = realm
        .lookup<NativeFunction<wrapper_realmlist_insert_native_t>>("realmlist_insert")
        .asFunction();
    wrapper_realmlist_erase = realm
        .lookup<NativeFunction<wrapper_realmlist_erase_native_t>>("realmlist_erase")
        .asFunction();
    wrapper_realmlist_get = realm
        .lookup<NativeFunction<wrapper_realmlist_get_native_t>>("realmlist_get")
        .asFunction();
    wrapper_realmlist_set = realm
        .lookup<NativeFunction<wrapper_realmlist_set_native_t>>("realmlist_set")
        .asFunction();    
  }
}

_RealmBindings _cachedBindings;
_RealmBindings get bindings => _cachedBindings ??= _RealmBindings();
