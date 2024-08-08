part of '../../provider.dart';

class ResetPinNotifier extends StateNotifier<ResetPinState> {
  ResetPinNotifier() : super(const ResetPinState.initial());

  /// [상태 체크 변수들]
  bool emailVerified = false;
  bool mobileVerified = false;

  /// [이메일 컨트롤러]
  TextEditingController emailController = TextEditingController();

  /// [모바일 컨트롤러]
  TextEditingController mobileController = TextEditingController();

  /// [핀 컨트롤러]
  TextEditingController pinController = TextEditingController();

  /// [Form Key]
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> mobileFormKey = GlobalKey<FormState>();

  /// [이메일 Validator]
  String? emailValidator(String? value) {
    state = const ResetPinState.initial();
    if (value!.isNotEmpty) {
      emailVerified = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
      ).hasMatch(value);
      if (!emailVerified) return "이메일 형식에 맞지 않습니다.";
      if (emailVerified) {
        state = const ResetPinState.success();
        return null;
      }
    }
    return null;
  }

  /// [모바일 Validator]
  String? mobileValidator(PhoneNumber value) {
    state = const ResetPinState.initial();
    final phoneValue = extractPhoneNumber(value);
    if (phoneValue.isNotEmpty) {
      mobileVerified =
          RegExp(r'^(10|11|16|19)\d{3,4}\d{4}$').hasMatch(phoneValue);
      if (!mobileVerified) return "번호를 정확하게 입력해 주세요.";
      if (mobileVerified) {
        return null;
      }
    }
    return null;
  }

  String extractPhoneNumber(PhoneNumber value) {
    final dialCode = value.dialCode.toString();
    final phoneNumber = value.phoneNumber.toString();
    return phoneNumber.substring(dialCode.length);
    // return phoneNumber.split(dialCode)[1];
  }

  bool verifyEmail() {
    /// 이메일 형식에 맞는지 체크
    emailVerified = emailFormKey.currentState!.validate();

    /// 이메일이 실제 유저의 이메일인지 체크
    /// []
    return emailVerified;
  }

  bool verifyMobilePin(String pin) {
    mobileVerified =
        (mobileFormKey.currentState!.validate() && pin.length == 6);
    state = const ResetPinState.success();
    return mobileVerified;
  }
}
