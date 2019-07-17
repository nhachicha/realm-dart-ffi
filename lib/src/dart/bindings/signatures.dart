import "dart:ffi";

import 'package:realm/src/dart/ffi/utf8.dart';

import 'package:realm/src/dart/bindings/types.dart';

typedef wrapper_create_native_t = Pointer<Database> Function(Pointer<Utf8> filename, Pointer<Utf8> schema);

typedef wrapper_destroy_native_t = Void Function(Pointer<Database> databasePointer);

typedef wrapper_begin_transaction_native_t = Void Function(Pointer<Database> databasePointer);

typedef wrapper_commit_transaction_native_t = Void Function(Pointer<Database> databasePointer);

typedef wrapper_cancel_transaction_native_t = Void Function(Pointer<Database> databasePointer);

typedef wrapper_add_object_native_t = Pointer<RealmObject> Function(Pointer<Database> databasePointer, Pointer<Utf8> objectType);

typedef wrapper_object_get_bool_native_t = Int8 Function(Pointer<RealmObject> objectPointer, Pointer<Utf8> propertyName);

typedef wrapper_object_set_bool_native_t = Void Function(Pointer<RealmObject> objectPointer, Pointer<Utf8> propertyName, Int8 value);

typedef wrapper_object_get_int64_native_t = Int64 Function(Pointer<RealmObject> objectPointer, Pointer<Utf8> propertyName);

typedef wrapper_object_set_int64_native_t = Void Function(Pointer<RealmObject> objectPointer, Pointer<Utf8> propertyName, Int64 value);

typedef wrapper_object_get_double_native_t = Double Function(Pointer<RealmObject> objectPointer, Pointer<Utf8> propertyName);

typedef wrapper_object_set_double_native_t = Void Function(Pointer<RealmObject> objectPointer, Pointer<Utf8> propertyName, Double value);

typedef wrapper_object_get_string_native_t = Pointer<Utf8> Function(Pointer<RealmObject> objectPointer, Pointer<Utf8> propertyName);

typedef wrapper_object_set_string_native_t = Void Function(Pointer<RealmObject> objectPointer, Pointer<Utf8> propertyName, Pointer<Utf8> value);

typedef wrapper_query_native_t = Pointer<RealmResults> Function(Pointer<Database> databasePointer, Pointer<Utf8> object_type, Pointer<Utf8> query_string);

typedef wrapper_query_size_native_t = Uint64 Function(Pointer<RealmResults> realmresultsPointer);

typedef wrapper_query_get_native_t = Pointer<RealmObject> Function(Pointer<RealmResults> realmresultsPointer, Pointer<Utf8> object_type, Uint64 index);

typedef wrapper_realmlist_size_native_t = Uint64 Function(Pointer<RealmList> realmresultsPointer);

typedef wrapper_realmlist_get_native_t = Pointer<RealmObject> Function(Pointer<RealmList> nativeRealmListPointer, Pointer<Utf8> object_type, Uint64 index);

typedef wrapper_realmlist_set_native_t = Void Function(Pointer<RealmList> nativeRealmListPointer, Pointer<RealmObject> objectPointer, Uint64 index);
