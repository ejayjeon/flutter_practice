import 'dart:async';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

abstract class StorageService {
  void init();

  bool get hasInitialized;

  Future<Object?> get(String key);

  Future<bool> set(String key, dynamic data);

  Future<bool> has(String key);

  Future<bool> remove(String key);

  Future<void> clear();
}

class StorageServiceImpl implements StorageService {
  SharedPreferences? sharedPreferences;
  final Completer<SharedPreferences> initCompleter = Completer();

  @override
  void init() {
    initCompleter.complete(SharedPreferences.getInstance());
  }

  @override
  bool get hasInitialized => sharedPreferences != null;

  @override
  Future<Object?> get(String key) async {
    sharedPreferences = await initCompleter.future;
    log(sharedPreferences!.get(key).toString(), name: "GET $key");
    return sharedPreferences!.get(key);
  }

  @override
  Future<bool> set(String key, data) async {
    sharedPreferences = await initCompleter.future;
    log("저장완료", name: "SET $key");
    return await sharedPreferences!.setString(key, data.toString());
  }

  @override
  Future<bool> has(String key) async {
    sharedPreferences = await initCompleter.future;
    return sharedPreferences?.containsKey(key) ?? false;
  }

  @override
  Future<bool> remove(String key) async {
    sharedPreferences = await initCompleter.future;
    log("삭제완료", name: "REMOVE $key");
    return await sharedPreferences!.remove(key);
  }

  @override
  Future<void> clear() async {
    sharedPreferences = await initCompleter.future;
    await sharedPreferences!.clear();
  }
}
