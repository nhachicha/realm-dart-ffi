// import 'package:realm/src/dart/realm_configuration.dart';
// import 'package:realm/src/dart/realm_model.dart';

// import "../lib/src/dart/realm.dart";
// import 'model/dog.dart';
// import 'model/person.dart';
// import 'model/realm_module.dart';

// void main() async {
//   var realm = await Realm()
//   ..realmConfiguration = RealmModuleGenerated()
//   ..open();
  
//   Dog dog = Dog();
//   dog.name = "Akamaru";
//   await realm.beginTransaction();// TODO use then?
//   Dog managedDog = await realm.create<Dog>();//TODO replace with dog reference
//   managedDog.name = "Hello Zepp!";
//   await realm.commitTransaction();

//   print("Dog name ${managedDog.name}");
//   await realm.close();
// }
