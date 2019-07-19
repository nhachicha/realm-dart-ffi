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
      Dog dog = realm.create<Dog>();
      dog.name = "Akamaru";
      await realm.commitTransaction();

      expect(dog.name, "Akamaru");
    });

    test("Persist Object", () async {
      await realm.beginTransaction();
      Dog dog = Dog()
      ..age = 7
      ..name = "Akamaru";

      Dog managedDog = realm.create<Dog>(dog);
      await realm.commitTransaction();

      expect(managedDog.name, "Akamaru");
      expect(managedDog.age, 7);
    });
    
    test("Query Object", () async {
      await realm.beginTransaction();
      Dog dog = realm.create<Dog>();
      dog.name = "Akamaru";
      await realm.commitTransaction();

      List<Dog> dogs = await realm.objects<Dog>('name beginswith "Akam"');
      expect(dogs.length, 1);
      expect(dogs[0].name, "Akamaru");
    });

    test("Delete Object", () async {
      await realm.beginTransaction();
      Dog dog = realm.create<Dog>();
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
      Dog dog = realm.create<Dog>();
      dog.name = "Akamaru";
      Dog dog2 = realm.create<Dog>();
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

    test("Realm Link", () async {
      await realm.beginTransaction();
      Dog dog1 = realm.create<Dog>();
      dog1.name = "Dog1";
      await realm.commitTransaction();

      List<Dog> all_dogs = await realm.objects<Dog>('TRUEPREDICATE SORT(name DESCENDING)');
      expect(all_dogs.length, 1);
      expect(all_dogs[0].other, null);

      Dog dog2 = Dog()..name = "Dog2";

     // setting a managed dog
      await realm.beginTransaction();
      dog2 = realm.create(dog2);
      dog1.other = dog2; 
      await realm.commitTransaction();

      all_dogs = await realm.objects<Dog>('TRUEPREDICATE SORT(name ASCENDING)');
      expect(all_dogs.length, 2);
      expect(all_dogs[0].name, "Dog1");
      expect(all_dogs[0].other.name, "Dog2");
      
      // setting an unmanaged dog
      Dog dog3 = Dog()..name = "Dog3";
      await realm.beginTransaction();
      dog1.other = dog3; 
      await realm.commitTransaction();

      all_dogs = await realm.objects<Dog>('TRUEPREDICATE SORT(name ASCENDING)');
      expect(all_dogs.length, 3);
      expect(all_dogs[0].name, "Dog1");
      expect(all_dogs[0].other.name, "Dog3");
    });

    test("Realm List", () async {
      await realm.beginTransaction();
      Dog dog = realm.create<Dog>();
      dog.name = "Akamaru";
      await realm.commitTransaction();

      List<Dog> dogs = await realm.objects<Dog>('name = "Akamaru" SORT(name DESCENDING)');
      expect(dogs.length, 1);
      expect(dogs[0].name, "Akamaru");
      expect(dogs[0].others.length, 0);

      Dog dog1 = Dog()..name = "Dog1";
      Dog dog2 = Dog()..name = "Dog2";

      // add unmanaged objects
      await realm.beginTransaction();
      dogs[0].others.add(dog1);
      dogs[0].others.add(dog2);
      await realm.commitTransaction();

      expect(dogs[0].others.length, 2);

      dogs = await realm.objects<Dog>('TRUEPREDICATE SORT(name DESCENDING)');
      expect(dogs.length, 3); // unmanaged objects added to a list are now persisted
      expect(dogs[0].name, "Akamaru");
      expect(dogs[0].others.length, 2);
      expect(dogs[0].others[0].name, "Dog1");
      expect(dogs[0].others[1].name, "Dog2");
      expect(dogs[1].name, "Dog1");
      expect(dogs[1].others.length, 0);
      expect(dogs[2].name, "Dog2");
      expect(dogs[2].others.length, 0);

      // insert at arbitrary index
      await realm.beginTransaction();
      dogs[0].others.insert(1, dog); // self reference
      await realm.commitTransaction();

      dogs = await realm.objects<Dog>('TRUEPREDICATE SORT(name DESCENDING)');
      expect(dogs.length, 3);
      expect(dogs[0].name, "Akamaru");
      expect(dogs[0].others.length, 3);
      expect(dogs[0].others[0].name, "Dog1");
      expect(dogs[0].others[1].name, "Akamaru");
      expect(dogs[0].others[2].name, "Dog2");

      // remove from arbitrary position
      await realm.beginTransaction();
      dogs[0].others.removeAt(1);
      await realm.commitTransaction();

      dogs = await realm.objects<Dog>('TRUEPREDICATE SORT(name DESCENDING)');
      expect(dogs.length, 3); // objects still exist, only the list has been modified
      expect(dogs[0].name, "Akamaru");
      expect(dogs[0].others.length, 2);
      expect(dogs[0].others[0].name, "Dog1");
      expect(dogs[0].others[1].name, "Dog2");
      expect(dogs[1].name, "Dog1");
      expect(dogs[1].others.length, 0);
      expect(dogs[2].name, "Dog2");
      expect(dogs[2].others.length, 0);

      // clear list
      await realm.beginTransaction();
      dogs[0].others.clear();
      await realm.commitTransaction();

      dogs = await realm.objects<Dog>('TRUEPREDICATE SORT(name DESCENDING)');
      expect(dogs.length, 3); // objects still exist, only the list has been modified
      expect(dogs[0].name, "Akamaru");
      expect(dogs[0].others.length, 0);
      expect(dogs[1].name, "Dog1");
      expect(dogs[1].others.length, 0);
      expect(dogs[2].name, "Dog2");
      expect(dogs[2].others.length, 0);
    });
  });
}
