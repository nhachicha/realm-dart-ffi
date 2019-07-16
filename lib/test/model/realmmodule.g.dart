
//@RealmModule
part of 'realmmodule.dart';


class RealmModuleGenerated extends RealmModule {
  static final RealmConfiguration _singleton = new RealmModuleGenerated._internal();

  factory RealmModuleGenerated() {
    return _singleton;
  }

  RealmModuleGenerated._internal() {
  }

  @override
  T newProxyInstance<T extends RealmModel> (Type type) {
    if (type == Dog) {
      return Dog$Realm() as T;
    }
    throw Exception("Unsupported type ${type}");
  }
}