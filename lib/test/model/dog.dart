
import 'package:realm/src/dart/realm_list.dart';
import 'package:realm/src/dart/realm_model.dart';
import 'package:realm/src/dart/realm_results.dart';
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