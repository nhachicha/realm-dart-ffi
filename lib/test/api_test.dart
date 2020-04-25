import 'dart:io';

import 'package:realm/src/dart/bindings/bindings.dart';
import 'package:realm/src/dart/realm.dart';
import 'package:realm/src/dart/realmresults.dart';
import 'package:realm/test/constants.dart';
import 'package:realm/test/model/dog.dart';
import 'package:realm/test/model/realmmodule.dart';
import "package:test/test.dart";

import 'dart:ffi';
import 'dart:isolate';
import 'package:realm/src/dart/ffi/dylib_utils.dart';

// Lookup additional function for callback tests
final dl = dlopenPlatformSpecific("realm-dart", path: "./lib/src/cpp/");

// perform an addition in C and invoke a Dart callback from the same isolate (no need to use a ReceivePort)
final addition_from_same_isolate = dl.lookupFunction<
        Void Function(Int64 a, Int64 b,
            Pointer<NativeFunction<Void Function(IntPtr)>> functionPointer),
        void Function(int a, int b,
            Pointer<NativeFunction<Void Function(IntPtr)>> functionPointer)>(
    'addition_from_same_isolate');

List<int> invoked;
void additionCallback(int a) {
  invoked[0] = a;
}
// start a pthread to perform an addition asynchrounously then invoke the main isolate (using a 'RecivePort') to deliver the result
final async_pthread_addition = dl.lookupFunction<
    Void Function(Int64 a, Int64 b, Int64 sendPort),
    void Function(int a, int b, int sendPort)>('async_pthread_addition');

final registerDart_PostCObject = dl.lookupFunction<
    Void Function(
        Pointer<NativeFunction<Int8 Function(Int64, Pointer<Dart_CObject>)>>
            functionPointer),
    void Function(
        Pointer<NativeFunction<Int8 Function(Int64, Pointer<Dart_CObject>)>>
            functionPointer)>('RegisterDart_PostCObject');

Future asyncSleep(int ms) {
  return new Future.delayed(Duration(milliseconds: ms));
}

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

      List<Dog> dogs = await realm.objects<Dog>(
          'name beginswith "Akam" or name contains[c] "lie" SORT(name DESCENDING)');
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

      List<Dog> all_dogs =
          await realm.objects<Dog>('TRUEPREDICATE SORT(name DESCENDING)');
      expect(all_dogs.length, 1);
      expect(all_dogs[0].mother, null);

      Dog dog2 = Dog()..name = "Dog2";

      // setting a managed dog
      await realm.beginTransaction();
      dog2 = realm.create(dog2);
      dog1.mother = dog2;
      await realm.commitTransaction();

      all_dogs = await realm.objects<Dog>('TRUEPREDICATE SORT(name ASCENDING)');
      expect(all_dogs.length, 2);
      expect(all_dogs[0].name, "Dog1");
      expect(all_dogs[0].mother.name, "Dog2");

      // setting an unmanaged dog
      Dog dog3 = Dog()..name = "Dog3";
      await realm.beginTransaction();
      dog1.mother = dog3;
      await realm.commitTransaction();

      all_dogs = await realm.objects<Dog>('TRUEPREDICATE SORT(name ASCENDING)');
      expect(all_dogs.length, 3);
      expect(all_dogs[0].name, "Dog1");
      expect(all_dogs[0].mother.name, "Dog3");
    });

    test("Realm List", () async {
      await realm.beginTransaction();
      Dog dog = realm.create<Dog>();
      dog.name = "Akamaru";
      await realm.commitTransaction();

      List<Dog> dogs =
          await realm.objects<Dog>('name = "Akamaru" SORT(name DESCENDING)');
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
      expect(dogs.length,
          3); // unmanaged objects added to a list are now persisted
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
      expect(dogs.length,
          3); // objects still exist, only the list has been modified
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
      expect(dogs.length,
          3); // objects still exist, only the list has been modified
      expect(dogs[0].name, "Akamaru");
      expect(dogs[0].others.length, 0);
      expect(dogs[1].name, "Dog1");
      expect(dogs[1].others.length, 0);
      expect(dogs[2].name, "Dog2");
      expect(dogs[2].others.length, 0);
    });

    test("Realm linkingObjects", () async {
      await realm.beginTransaction();
      Dog dog1 = realm.create<Dog>();
      dog1.name = "Dog1";
      await realm.commitTransaction();

      List<Dog> all_dogs =
          await realm.objects<Dog>('TRUEPREDICATE SORT(name DESCENDING)');
      expect(all_dogs.length, 1);
      expect(all_dogs[0].mother, null);
      expect(all_dogs[0].litter.length, 0);

      Dog dog2 = Dog()..name = "Dog2";
      Dog dog3 = Dog()..name = "Dog3";

      await realm.beginTransaction();
      dog2 = realm.create(dog2);
      dog3 = realm.create(dog3);
      dog1.mother = dog2;
      dog3.mother = dog2;
      await realm.commitTransaction();

      all_dogs = await realm.objects<Dog>('TRUEPREDICATE SORT(name ASCENDING)');
      expect(all_dogs.length, 3);
      expect(all_dogs[0].name, "Dog1");
      expect(all_dogs[0].mother.name, "Dog2");
      expect(all_dogs[0].litter.length, 0);
      expect(all_dogs[1].name, "Dog2");
      expect(all_dogs[1].mother, null);
      expect(all_dogs[1].litter.length, 2);
      expect(all_dogs[1].litter[0].name, "Dog1");
      expect(all_dogs[1].litter[1].name, "Dog3");
      expect(all_dogs[2].name, "Dog3");
      expect(all_dogs[2].mother.name, "Dog2");
      expect(all_dogs[2].litter.length, 0);

      // removing a linked object updates linking objects
      await realm.beginTransaction();
      realm.delete(dog3);
      await realm.commitTransaction();

      all_dogs = await realm.objects<Dog>('TRUEPREDICATE SORT(name ASCENDING)');
      expect(all_dogs.length, 2);
      expect(all_dogs[0].name, "Dog1");
      expect(all_dogs[0].mother.name, "Dog2");
      expect(all_dogs[0].litter.length, 0);
      expect(all_dogs[1].name, "Dog2");
      expect(all_dogs[1].mother, null);
      expect(all_dogs[1].litter.length, 1);
      expect(all_dogs[1].litter[0].name, "Dog1");

      // queries know about linkingObjects
      RealmResults<Dog> dogsWithChildren =
          await realm.objects<Dog>('litter.@count > 0');
      expect(dogsWithChildren.length, 1);
      expect(dogsWithChildren[0].name, "Dog2");
      expect(dogsWithChildren[0].litter.length, 1);
      expect(dogsWithChildren[0].litter[0].name, "Dog1");
    });

    // This test demonstrates that you can invoke a Dart callback from C, as long as we're in the same Isolate
    test("callback from C same Isolate", () async {
      invoked = []..add(0);

      final callback =
          Pointer.fromFunction<Void Function(IntPtr)>(additionCallback);
      addition_from_same_isolate(40, 2, callback);
      expect(invoked[0], 42);
    });

    // This test demonstrates that you can invoke a callback from a pthread using ReceivePort
    test("async callback from pthread", () async {
      registerDart_PostCObject(NativeApi.postCObject);
      bool callbackInvoked = false;
      final resultsPort = ReceivePort()
        ..listen((dynamic message) {
          callbackInvoked = true;
          expect(message as int, 42);
        });
      async_pthread_addition(40, 2, resultsPort.sendPort.nativePort);
      await asyncSleep(500);
      expect(callbackInvoked, true);
    });
  });
}
