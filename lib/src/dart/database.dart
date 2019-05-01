import "bindings/bindings.dart";
import "bindings/types.dart";
import "ffi/cstring.dart";

class Database {
  DatabasePointer _database;

  Database(String path) {
    CString pathC = CString.allocate(path);
    _database = bindings.wrapper_create(pathC);
    pathC.free();
  }

  void close() {
    bindings.wrapper_destroy(_database);
  }

  void put(String key, String value) {
    CString keyC = CString.allocate(key);
    CString valueC = CString.allocate(value);
    
    bindings.wrapper_put(_database, keyC, valueC);

    keyC.free();
    valueC.free();
  }

  String get(String key) {
    CString keyC = CString.allocate(key);
    String value = CString.fromUtf8(bindings.wrapper_get(_database, keyC));
    keyC.free();
    return value;
  }
}