import 'package:realm/src/dart/realmmodel.dart';

import 'dog.dart';

part 'person.g.dart'; 

class Person extends RealmModel {
  String name;
  Dog dog;
  
}