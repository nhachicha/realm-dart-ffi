// import 'package:realm/src/dart/realmmodel.dart';

import 'package:realm/src/dart/realmresults.dart';

import 'realmmodel.dart';

abstract class RealmConfiguration {
  // String _path;
  //List<RealmModel> schema;
  // List<Type> _schema;

  String path();

  List<RealmModel> schema();
  
  String getSchemaAsJSON() {
    var jsonSchema = new StringBuffer();
    jsonSchema.write("[\n");
    for (var s in schema()) {
      RealmModel model = newProxyInstance(s.runtimeType);
      jsonSchema.write(model.schemaToJson);
      jsonSchema.write(",");
    }
    jsonSchema.write("]\n");
    // return jsonSchema.toString();
    return '''
    [
    {
        "name": "Dog",
        "properties": {
            "name": "string",
            "age": "int",
            "owner": "Person",
            "mother": "Dog",
            "others": "Dog[]",
            "litter": { "type": "linkingObjects", "objectType": "Dog", "property": "mother" }
        }
    },
    {
        "name": "Person",
        "properties": {
            "name": "string",
            "dog": "Dog"
        }
    },
    {
      "name": "AllTypes",
      "primaryKey": "simpleString",
      "properties": {
          "simpleBool": "bool",
          "simpleString": "string",
          "simpleInt": "int",
          "simpleDouble": "double",
          "simpleFloat": "float",
          "simpleTimestamp": "date",
          "simpleData": "data",

          "optionalBool": "bool?",
          "optionalString": "string?",
          "optionalInt": "int?",
          "optionalDouble": "double?",
          "optionalFloat": "float?",
          "optionalTimestamp": "date?",
          "optionalData": "data?",

          "listBool": "bool[]",
          "listString": "string[]",
          "listInt": "int[]",
          "listDouble": "double[]",
          "listFloat": "float[]",
          "listTimestamp": "date[]",
          "listData": "data[]",

          "constructedBool": {"type": "bool"},
          "constructedString": {"type": "string"},
          "constructedInt": {"type": "int"},
          "constructedDouble": {"type": "double"},
          "constructedFloat": {"type": "float"},
          "constructedTimestamp": {"type": "date"},
          "constructedData": {"type": "data"},

          "constructedOptionalBool": {"type": "bool", "optional": "true"},
          "constructedOptionalString": {"type": "string", "optional": "true"},
          "constructedOptionalInt": {"type": "int", "optional": "true"},
          "constructedOptionalDouble": {"type": "double", "optional": "true"},
          "constructedOptionalFloat": {"type": "float", "optional": "true"},
          "constructedOptionalTimestamp": {"type": "date", "optional": "true"},
          "constructedOptionalData": {"type": "data", "optional": "true"},

          "constructedIndexedBool": {"type": "bool", "indexed": "true"},
          "constructedIndexedString": {"type": "string", "indexed": "true"},
          "constructedIndexedInt": {"type": "int", "indexed": "true"},
          "constructedIndexedTimestamp": {"type": "date", "indexed": "true"},

          "constructedLink": {"type": "AllTypes"},
          "constructedList": {"type": "list", "objectType":"AllTypes" },
          "parents": {"type": "linkingObjects", "objectType": "AllTypes", "property": "constructedLink" }
      }

    }
]
    ''';
  }

  // will return the code generated instance of the given class
  T newProxyInstance<T extends RealmModel>(Type type) {
    throw Exception(
        "This should not be invoked as is, only overrided by code generated instance that extends RealmConfiguration");
  } //THIS will be implemented by the generated RealmConfiguration instance

  RealmResults<T> newRealmResultsInstance<T extends RealmModel>(Type type) {
    throw Exception(
        "This should not be invoked as is, only overrided by code generated instance that extends RealmConfiguration");
  }
}
