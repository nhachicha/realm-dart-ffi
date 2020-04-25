import 'dart:ffi';

import "package:ffi/ffi.dart";

import 'package:realm/src/dart/bindings/types.dart';

typedef wrapper_create_native_t = Pointer<DatabaseType> Function(Pointer<Utf8> filename, Pointer<Utf8> schema);

typedef wrapper_destroy_native_t = Void Function(Pointer<DatabaseType> databasePointer);

typedef wrapper_begin_transaction_native_t = Void Function(Pointer<DatabaseType> databasePointer);

typedef wrapper_commit_transaction_native_t = Void Function(Pointer<DatabaseType> databasePointer);

typedef wrapper_cancel_transaction_native_t = Void Function(Pointer<DatabaseType> databasePointer);

typedef wrapper_add_object_native_t = Pointer<RealmObjectType> Function(Pointer<DatabaseType> databasePointer, Pointer<Utf8> objectType);

typedef wrapper_delete_object_native_t = Void Function(Pointer<DatabaseType> databasePointer, Pointer<RealmObjectType> object);

typedef wrapper_object_get_bool_native_t = Int8 Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName);

typedef wrapper_object_set_bool_native_t = Void Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName, Int8 value);

typedef wrapper_object_get_int64_native_t = Int64 Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName);

typedef wrapper_object_set_int64_native_t = Void Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName, Int64 value);

typedef wrapper_object_get_double_native_t = Double Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName);

typedef wrapper_object_set_double_native_t = Void Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName, Double value);

typedef wrapper_object_get_string_native_t = Pointer<Utf8> Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName);

typedef wrapper_object_set_string_native_t = Void Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName, Pointer<Utf8> value);

typedef wrapper_object_get_object_native_t = Pointer<RealmObjectType> Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName);

typedef wrapper_object_set_object_native_t = Void Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName, Pointer<RealmObjectType> value);

typedef wrapper_object_get_list_native_t = Pointer<RealmListType> Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName);

typedef wrapper_object_get_linkingobjects_native_t = Pointer<RealmResultsType> Function(Pointer<RealmObjectType> objectPointer, Pointer<Utf8> propertyName);

typedef wrapper_query_native_t = Pointer<RealmResultsType> Function(Pointer<DatabaseType> databasePointer, Pointer<Utf8> object_type, Pointer<Utf8> query_string);

typedef wrapper_results_size_native_t = Uint64 Function(Pointer<RealmResultsType> realmresultsPointer);

typedef wrapper_results_delete_native_t = Void Function(Pointer<RealmResultsType> realmresultsPointer);

typedef wrapper_results_get_native_t = Pointer<RealmObjectType> Function(Pointer<RealmResultsType> realmresultsPointer, Pointer<Utf8> object_type, Uint64 index);

typedef wrapper_realmlist_size_native_t = Uint64 Function(Pointer<RealmListType> realmlistPointer);

typedef wrapper_realmlist_clear_native_t = Void Function(Pointer<RealmListType> realmlistPointer);

typedef wrapper_realmlist_insert_native_t = Void Function(Pointer<RealmListType> realmlistPointer, Pointer<RealmObjectType> item, Uint64 index);

typedef wrapper_realmlist_erase_native_t = Void Function(Pointer<RealmListType> realmlistPointer, Uint64 index);

typedef wrapper_realmlist_get_native_t = Pointer<RealmObjectType> Function(Pointer<RealmListType> nativeRealmListPointer, Pointer<Utf8> object_type, Uint64 index);

typedef wrapper_realmlist_set_native_t = Void Function(Pointer<RealmListType> nativeRealmListPointer, Pointer<RealmObjectType> objectPointer, Uint64 index);

typedef SimpleAdditionType = Int32 Function(Int32, Int32);
typedef NativeCallbackTestFn = int Function(Pointer);
typedef NativeCallbackTest = Int32 Function(Pointer);
