// annotation 
import 'package:realm/src/dart/realmmodel.dart';

class RealmSchema<T extends RealmModel> {
  final String path;
  final List<T> schema;
  const RealmSchema(this.path, this.schema);
}