import 'package:extension_methods_test/model/my_nodel.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:reflectable/reflectable.dart';

typedef JSON = Map<String, dynamic>;

extension JsonExtension<T extends Object> on T {
  // fromJson(JSON json) => T();
}

abstract class TestJson<T> {}

extension Test<T> on T {
  fromJson(JSON json) => T;
}

// 더하기 기능
extension Sum on List<int> {
  int get sum => fold(0, (a, b) => a + b);
}

extension NumberParsing on String {
  int parseInt() => int.parse(this);
  double parseDouble() => double.parse(this);
}

extension StringExtensions on String {
  String concatWithSpace(String other) => '$this $other';

  String operator &(String other) => '$this $other';
}

extension NumGenericExtension<T extends num> on T {
  num addTen() => this + 10;
}

class Reflector extends Reflectable {
  const Reflector()
      : super(invokingCapability, typingCapability, reflectedTypeCapability);
}

const reflector = Reflector();

@reflector
class FormDeclaration {
  @DynamicFieldAttribute(label: 'Name and Surname', order: 1)
  String? name;
  @DynamicFieldAttribute(label: 'Age', order: 2)
  int? age;
  @DynamicFieldAttribute(label: 'Are you married?', order: 3)
  bool? isMarried;
}

@reflector
class DynamicFieldAttribute {
  final String label;
  final int order;
  const DynamicFieldAttribute({
    required this.order,
    required this.label,
  });
}

@reflector
class MyModel {
  final String name;
  final String age;

  MyModel({
    required this.name,
    required this.age,
  });
}
