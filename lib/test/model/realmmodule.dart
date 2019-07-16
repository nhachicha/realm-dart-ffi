import 'package:realm/src/dart/realmconfiguration.dart';
import 'package:realm/src/dart/realmmodel.dart';
import 'package:realm/test/constants.dart';
// import 'package:realm/src/dart/realmschema.dart';

import 'dog.dart';
part 'realmmodule.g.dart'; 

// @RealmSchema("/Users/Nabil/Dev/realm/realm-dart-ffi/test.realm" , [Dog, Person])//TODO this might be a bug reproduce in an isolated example then create an issue
// class RealmModule {
  
// }

// @RealmSchema
class RealmModule extends RealmConfiguration {
  @override
  String path() {
    return realm_test_directory + "test.realm";
  }

  @override
  List<RealmModel> schema() {
    return [Dog()];
  }

}