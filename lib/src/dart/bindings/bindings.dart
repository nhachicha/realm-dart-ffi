import "dart:ffi";

import "../ffi/cstring.dart";
import "../ffi/dylib_utils.dart";

import "signatures.dart";
import "types.dart";

class _RealmBindings {
  DynamicLibrary realm;

  DatabasePointer Function(CString filename) wrapper_create;

  void Function(DatabasePointer database) wrapper_destroy;

  void Function(DatabasePointer database, CString key, CString value) wrapper_put;

  CString Function(DatabasePointer database, CString key) wrapper_get;

  _RealmBindings({String path = './lib/src/cpp/'}) {
    realm = dlopenPlatformSpecific("realm-dart", path: path);
    wrapper_create = realm
        .lookup<NativeFunction<wrapper_create_native_t>>("wrapper_create")
        .asFunction();
    wrapper_destroy = realm
        .lookup<NativeFunction<wrapper_destroy_native_t>>("wrapper_destroy")
        .asFunction();
    wrapper_put = realm
        .lookup<NativeFunction<wrapper_put_native_t>>("wrapper_put")
        .asFunction();
    wrapper_get = realm
        .lookup<NativeFunction<wrapper_get_native_t>>("wrapper_get")
        .asFunction();
  }
}

_RealmBindings _cachedBindings;
_RealmBindings get bindings => _cachedBindings ??= _RealmBindings();
