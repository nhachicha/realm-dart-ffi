// annotation 
import 'package:realm/src/dart/realmmodel.dart';

class RealmSchema<T extends RealmModel> {
  final String path;
  final List<T> schema;//FIXME this should be List<RealmModel> but compiler is not happy 
  const RealmSchema(this.path, this.schema);
}