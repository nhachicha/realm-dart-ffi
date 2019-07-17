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
      final test_dir = Directory(realm_test_directory);

      if (test_dir.existsSync()) {
        test_dir.deleteSync(recursive: true);
      }
      test_dir.createSync();
      return realm = await Realm()
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
    }, skip: "TODO: this Realm is not cleaned correctly causing the next query to return 2 dog instances instead of 1");
    
    test("Query Object", () async {
      await realm.beginTransaction();
      Dog dog = await realm.create<Dog>();
      dog.name = "Akamaru";
      await realm.commitTransaction();

      List<Dog> dogs = await realm.objects<Dog>('name beginswith "Akam"');
      expect(dogs.length, 1);
      expect(dogs[0].name, "Akamaru");
    });
  });
}
