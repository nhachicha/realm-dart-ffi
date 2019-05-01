import "dart:ffi";

import "../ffi/cstring.dart";

import "types.dart";

typedef wrapper_create_native_t = DatabasePointer Function(CString filename);

typedef wrapper_destroy_native_t = Void Function(DatabasePointer database);

typedef wrapper_put_native_t = Void Function(DatabasePointer database, CString key, CString value);

typedef wrapper_get_native_t = CString Function(DatabasePointer database, CString key);
