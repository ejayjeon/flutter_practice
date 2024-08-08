# extension_methods_test


### 1. 다운로드
```shell
flutter pub add reflectable dev:build_runner
```

<br>

### 2. lib build
```shell
flutter pub run build_runner build lib
```

<br>

### 3. main.dart에 init 설정하기
```dart
import 'package:reflectable/reflectable.dart';
import 'main.reflectable.dart' show 

void main() {
  initializeReflectable();  
}

```

<br>

### 4. 사용하기
```dart
  const reflector = Reflector();
  ClassMirror classMirror = reflector.reflectType(MyModel) as ClassMirror;
  classMirror.instanceMembers.forEach((key, value) {
    print('key: $key / value: ${value.simpleName}');
  });

```