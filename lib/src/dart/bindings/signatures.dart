import "dart:ffi";

import "../ffi/cstring.dart";

import 'package:realm/src/dart/bindings/types.dart';

typedef wrapper_create_native_t = DatabasePointer Function(CString filename, CString schema);

typedef wrapper_destroy_native_t = Void Function(DatabasePointer databasePointer);

typedef wrapper_begin_transaction_native_t = Void Function(DatabasePointer databasePointer);

typedef wrapper_commit_transaction_native_t = Void Function(DatabasePointer databasePointer);

typedef wrapper_cancel_transaction_native_t = Void Function(DatabasePointer databasePointer);

typedef wrapper_add_object_native_t = RealmObjectPointer Function(DatabasePointer databasePointer, CString objectType);

typedef wrapper_object_get_bool_native_t = Int8 Function(RealmObjectPointer objectPointer, CString propertyName);

typedef wrapper_object_set_bool_native_t = Void Function(RealmObjectPointer objectPointer, CString propertyName, Int8 value);

typedef wrapper_object_get_int64_native_t = Int64 Function(RealmObjectPointer objectPointer, CString propertyName);

typedef wrapper_object_set_int64_native_t = Void Function(RealmObjectPointer objectPointer, CString propertyName, Int64 value);

typedef wrapper_object_get_double_native_t = Double Function(RealmObjectPointer objectPointer, CString propertyName);

typedef wrapper_object_set_double_native_t = Void Function(RealmObjectPointer objectPointer, CString propertyName, Double value);

typedef wrapper_object_get_string_native_t = CString Function(RealmObjectPointer objectPointer, CString propertyName);

typedef wrapper_object_set_string_native_t = Void Function(RealmObjectPointer objectPointer, CString propertyName, CString value);