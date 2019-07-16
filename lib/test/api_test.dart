import 'dart:io';

import 'package:realm/src/dart/realm.dart';
import 'package:realm/test/constants.dart';
import 'package:realm/test/model/dog.dart';
import 'package:realm/test/model/realmmodule.dart';
import "package:test/test.dart";

void main() {
  group("Realm", () {
    Realm realm;

    setUp(() async {
      final test_dir =  Directory(realm_test_directory);
    
      await test_dir.exists()
      .then((isThere) {
        if (isThere) {
          return test_dir
          .delete(recursive: true)
          .then((_) => test_dir.create());
        } else {
          return test_dir.create();
        }
      });

      realm = await Realm()
        ..realmConfiguration = RealmModuleGenerated()
        ..open();
    });

    tearDown(() async {
      await realm.close();
    });

    test("Create Object", () async {
      await realm.beginTransaction(); 
      Dog dog = await realm.create<Dog>();
      dog.name = "Akamaru";
      await realm.commitTransaction();

      expect(dog.name, "Akamaru");
    });

  });
}
