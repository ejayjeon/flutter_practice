import 'package:extension_methods_test/mixin/json_extension.dart';
import 'package:extension_methods_test/model/model_wrapper.dart';
import 'package:extension_methods_test/model/my_nodel.dart';
import 'package:extension_methods_test/view/home.dart';
import 'package:flutter/material.dart';
import 'package:reflectable/reflectable.dart';
import 'main.reflectable.dart' show initializeReflectable;

void main() {
  // print([100, 200, -123123].sum);
  // print('나는' & '예쁘다');
  // num shouldBeDouble = 1.0.addTen();
  // print(shouldBeDouble.runtimeType);
  initializeReflectable();
  const reflector = Reflector();
  ClassMirror classMirror = reflector.reflectType(MyModel) as ClassMirror;
  classMirror.instanceMembers.forEach((key, value) {
    print('key: $key / value: ${value.simpleName}');
  });

  print(classMirror.instanceMembers.keys);
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: HomeView(),
      ),
    );
  }
}
