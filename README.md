# _This repo is archived, please follow progress on https://github.com/blagoev/realm-dart for a preview release soon._

# realm-dart-ffi
Experimental Realm binding using `dart:ffi` [preview support](https://github.com/dart-lang/sdk/issues/34452#issuecomment-482136759). 

This demo wraps the [Realm](https://realm.io/) database [engine](https://github.com/realm/realm-object-store/) (C++) using a C like interface in order to build a simple Key/Value store, and expose it to dart.

## Building 

- Build the Shared Object library containing Realm with a C wrapper

```
git clone https://github.com/nhachicha/realm-dart-ffi
cd realm-dart-ffi
git submodule update --init --recursive
cd lib/src/cpp
cmake .
make
```

## Running 

- [Example](./example/main.dart):
```Dart
  Database d = Database("demo.realm");
  d.put("first name", "Nabil");
  String firstName = d.get("first name");
```

- Run the example (from the root directory `realm-dart-ffi`)
```
realm-dart-ffi> pub get
realm-dart-ffi> pub run example/main
```

This should persist two keys, then retrieve them.

```
Creating database demo.realm
Put key: first name value: Nabil
Put key: last name value: Hachicha
Get key: first name
Get key: last name
Hello Nabil Hachicha
Closing database 
```

You can also inspect the generated Realm database using [Realm Studio](https://realm.io/products/realm-studio/)
![](./art/screenshot.png)
