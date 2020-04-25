
import 'package:realm/src/dart/realmlist.dart';
import 'package:realm/src/dart/realmmodel.dart';
import 'package:realm/src/dart/realmresults.dart';
import "package:ffi/ffi.dart";
part 'dog.g.dart'; 

class Dog extends RealmModel {
  String name;
  int age;
  RealmList<Dog> others;
  Dog mother;
  //FIXME: @annotate LinkingObjects(mother)
  RealmResults<Dog> litter;
}