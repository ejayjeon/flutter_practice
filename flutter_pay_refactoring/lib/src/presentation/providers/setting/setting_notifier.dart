part of '../provider.dart';

@riverpod
class SettingNotifier extends _$SettingNotifier {
  @override
  void build() {
    SettingLanguageState.initial();
  }

  /// [language]
  void toggleLanguageCheckbox(SettingLanguageState newState) {
    // ignore: void_checks
    state = newState;
  }
}
