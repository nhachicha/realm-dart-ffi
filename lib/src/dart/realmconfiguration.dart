// import 'package:realm/src/dart/realmmodel.dart';

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
      RealmModel model = newProxyInstance(s);
      jsonSchema.write(model.schemaToJson());
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
            "owner": "Person"
        }
    },
    {
        "name": "Person",
        "properties": {
            "name": "string",
            "dog": "Dog"
        }
    }
]
    ''';
  }

  // will return the code generated instance of the given class
  T newProxyInstance<T extends RealmModel>(T obj) {
    throw Exception(
        "This should not be invoked as is, only overrided by code generated instance that extends RealmConfiguration");
  } //THIS will be implemented by the generated RealmConfiguration instance
}
