import 'package:realm/src/dart/realm.dart';
import 'package:realm/test/model/dog.dart';
import 'package:realm/test/model/realmmodule.dart';
import "package:test/test.dart";

void main() {
  group("Realm", () {
    Realm realm;

    setUp(() async {
      realm = await Realm()
        ..realmConfiguration = RealmModuleGenerated()
        ..open();
    });

    tearDown(() async {
      await realm.close();
    });

    test("Create Object", () async {
      await realm.beginTransaction(); // TODO use then?
      Dog dog = await realm.create<Dog>();
      dog.name = "Akamaru";
      await realm.commitTransaction();

      expect(dog.name, "Akamaru");
    });

  });
}
