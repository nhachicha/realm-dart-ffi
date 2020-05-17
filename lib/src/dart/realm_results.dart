import 'dart:collection';
import 'dart:ffi';
import 'package:ffi/ffi.dart';

import 'package:realm/src/dart/bindings/bindings.dart';
import 'package:realm/src/dart/bindings/types.dart' as types;
import 'package:realm/src/dart/realm_model.dart';
import 'package:realm/test/model/dog.dart';
import 'database.dart';

class RealmResults<T extends RealmModel> extends ListBase<T> {
  //final RealmReusltsPointer _nativePointer to be passed with ctor
  // we also need wrapper pointer to make native calls
  String tableName;
  Pointer<types.RealmResultsType> nativePointer;
  Realm realm;

  @override
  int get length {
    return bindings.wrapper_realmresults_size(nativePointer);
  }

  @override
  void clear() {
    bindings.wrapper_realmresults_delete(nativePointer);
  }

  @override
  T operator [](int index) {
    // get native pointer & invoke the wrapper
    final tableNameC = Utf8.toUtf8(tableName);
    var realmObjectPointer =
        bindings.wrapper_realmresults_get(nativePointer, tableNameC, index);
    free(tableNameC);

    // T proxyInstance = realmConfiguration.newProxyInstance<T>(T); TODO use this
    var dog = Dog$Realm();
    dog.objectPointer = realmObjectPointer;
    dog.realm = realm;
    return dog as T;
  }

  @override
  void operator []=(int index, T value) {
    throw Exception('Modifying a RealmResults is not supported.');
  }

  @override
  set length(int newLength) {
    throw Exception('Modifying a RealmResults is not supported');
  }
}
