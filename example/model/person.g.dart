part of 'person.dart';

class Person$Realm extends Person {
   @override
   String schemaToJson() {
    return '''{
      name: 'Person',
      properties: {
        name:     'string',
        dog: Dog
      }
    }''';
  }  
}

