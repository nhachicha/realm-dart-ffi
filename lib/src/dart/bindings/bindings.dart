import "dart:ffi";

import "../ffi/cstring.dart";
import "../ffi/dylib_utils.dart";

import "signatures.dart";
import 'package:realm/src/dart/bindings/types.dart';

class _RealmBindings {
  DynamicLibrary realm;

  DatabasePointer Function(CString filename, CString schema) wrapper_create;
  void Function(DatabasePointer database) wrapper_destroy;
  void Function(DatabasePointer databasePointer) wrapper_begin_transaction;
  void Function(DatabasePointer databasePointer) wrapper_commit_transaction;
  void Function(DatabasePointer databasePointer) wrapper_cancel_transaction;
  RealmObjectPointer Function(DatabasePointer databasePointer, CString objectType) wrapper_add_object;
  int Function(RealmObjectPointer objectPointer, CString propertyName) wrapper_object_get_bool;
  void Function(RealmObjectPointer objectPointer, CString propertyName, int value) wrapper_object_set_bool;
  int Function(RealmObjectPointer objectPointer, CString propertyName) wrapper_object_get_int64;
  void Function(RealmObjectPointer objectPointer, CString propertyName, int value) wrapper_object_set_int64;
  double Function(RealmObjectPointer objectPointer, CString propertyName) wrapper_object_get_double;
  void Function(RealmObjectPointer objectPointer, CString propertyName, double value) wrapper_object_set_double;
  CString Function(RealmObjectPointer objectPointer, CString propertyName) wrapper_object_get_string;
  void Function(RealmObjectPointer objectPointer, CString propertyName, CString value) wrapper_object_set_string;

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
  }
}

_RealmBindings _cachedBindings;
_RealmBindings get bindings => _cachedBindings ??= _RealmBindings();
