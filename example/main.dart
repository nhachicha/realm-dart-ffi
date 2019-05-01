import "../lib/src/dart/realm.dart";

void main() {
  Database d = Database("demo.realm");
  d.put("first name", "Nabil");
  d.put("last name", "Hachicha");
  String firstName = d.get("first name");
  String lastName = d.get("last name");
  print("Hello $firstName $lastName");
  d.close();
}
