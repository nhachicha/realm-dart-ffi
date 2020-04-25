//@RealmModule
part of 'realm_module.dart';

class RealmModuleGenerated extends RealmModule {
  static final RealmConfiguration _singleton =
      RealmModuleGenerated._internal();

  factory RealmModuleGenerated() {
    return _singleton;
  }

  RealmModuleGenerated._internal();

  @override
  T newProxyInstance<T extends RealmModel>(Type type) {
    if (type == Dog) {
      return Dog$Realm() as T;
    }
    throw Exception("Unsupported type ${type}");
  }

  @override
  RealmResults<T> newRealmResultsInstance<T extends RealmModel>(Type type) {
    if (type == Dog) {
      var realmresults = RealmResults<Dog>() as RealmResults<T>;
      realmresults.tableName = "Dog";
      return realmresults;
    }
    throw Exception("Unsupported type ${type}");
  }
}
