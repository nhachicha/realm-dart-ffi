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
    });

    test("Persist Object", () async {
      await realm.beginTransaction();
      Dog dog = Dog()
      ..age = 7
      ..name = "Akamaru";

      Dog managedDog = await realm.create<Dog>(dog);
      await realm.commitTransaction();

      expect(managedDog.name, "Akamaru");
      expect(managedDog.age, 7);
    });
    
    test("Query Object", () async {
      await realm.beginTransaction();
      Dog dog = await realm.create<Dog>();
      dog.name = "Akamaru";
      await realm.commitTransaction();

      List<Dog> dogs = await realm.objects<Dog>('name beginswith "Akam"');
      expect(dogs.length, 1);
      expect(dogs[0].name, "Akamaru");
    });

    test("Delete Object", () async {
      await realm.beginTransaction();
      Dog dog = await realm.create<Dog>();
      dog.name = "Akamaru";
      await realm.commitTransaction();

      List<Dog> dogs = await realm.objects<Dog>('name beginswith "Akam"');
      expect(dogs.length, 1);
      expect(dogs[0].name, "Akamaru");

      await realm.beginTransaction();
      realm.delete(dogs[0]);
      await realm.commitTransaction();

      dogs = await realm.objects<Dog>('name beginswith "Akam"');
      expect(dogs.length, 0);
    });

    test("Delete Results", () async {
      await realm.beginTransaction();
      Dog dog = await realm.create<Dog>();
      dog.name = "Akamaru";
      Dog dog2 = await realm.create<Dog>();
      dog2.name = "Charlie";
      await realm.commitTransaction();

      List<Dog> dogs = await realm.objects<Dog>('name beginswith "Akam" or name contains[c] "lie" SORT(name DESCENDING)');
      expect(dogs.length, 2);
      expect(dogs[0].name, "Akamaru");
      expect(dogs[1].name, "Charlie");

      await realm.beginTransaction();
      dogs.clear();
      await realm.commitTransaction();

      dogs = await realm.objects<Dog>('TRUEPREDICATE');
      expect(dogs.length, 0);
    });

    test("Realm List", () async {
      await realm.beginTransaction();
      Dog dog = await realm.create<Dog>();
      dog.name = "Akamaru";
      await realm.commitTransaction();

      List<Dog> dogs = await realm.objects<Dog>('name = "Akamaru"');
      expect(dogs.length, 1);
      Dog dog1 = Dog()..name = "Dog1";
      Dog dog2 = Dog()..name = "Dog2";

      await realm.beginTransaction();
      dogs[0].others.add(dog1);
      dogs[0].others.add(dog2);
      await realm.commitTransaction();

      expect(dogs[0].others.length, 2);//TODO add query by others
    });
  });
}
