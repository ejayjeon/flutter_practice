part of '../../provider.dart';

class SettingLanguageState {
  final Locale currentLanguage;
  final bool isEnabled;

  SettingLanguageState({
    required this.currentLanguage,
    required this.isEnabled,
  });

  SettingLanguageState copyWith({
    Locale? currentLanguage,
    bool? isCustomLanguageEnabled,
  }) {
    return SettingLanguageState(
      currentLanguage: currentLanguage ?? this.currentLanguage,
      isEnabled: isCustomLanguageEnabled ?? this.isEnabled,
    );
  }

  factory SettingLanguageState.initial() {
    return SettingLanguageState(
      currentLanguage: getCurrentLocationLanguage(), // 현재 위치 기반 언어 가져오기
      isEnabled: true,
    );
  }

  static Locale getCurrentLocationLanguage() {
    String locale = Platform.localeName;

    return Locale(locale);
  }
}
