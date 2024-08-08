import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:sketch_pay/src/presentation/providers/provider.dart';
import 'package:sketch_pay/src/presentation/screens/auth/widgets/auth_pin_field.dart';
import 'package:sketch_pay/src/presentation/screens/auth/widgets/custom_mobile_field.dart';
import 'package:sketch_pay/src/presentation/screens/auth/widgets/info_text_widget.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/extensions/widget_extension.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/widgets/button/app_button.dart';

class CheckMobileTab extends ConsumerStatefulWidget {
  final TabController controller;
  final String? hintText, labelText;
  final bool autofocus, enabled;
  final Color focusedColor;
  final VoidCallback? onPressed;
  const CheckMobileTab({
    super.key,
    required this.controller,
    this.hintText,
    this.labelText,
    this.autofocus = false,
    this.enabled = true,
    this.focusedColor = AppColor.primary,
    this.onPressed,
  });

  @override
  ConsumerState<CheckMobileTab> createState() => _CheckMobileTabState();
}

class _CheckMobileTabState extends ConsumerState<CheckMobileTab> {
  bool showAuthPinField = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ConstrainedBox(
        constraints: constraints,
        child: Column(
          children: <Widget>[
            const InfoTextWidget(
              info: "회원님이 *등록하신 휴대폰 번호* 을(를) 입력해 주세요",
            ).paddingOnly(bottom: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "휴대폰 번호",
                    textAlign: TextAlign.start,
                    style: context.bodyText?.copyWith(
                      height: 0.5,
                      color: AppColor.white,
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      final notifier = ref.watch(resetPinProvider.notifier);
                      return Form(
                        key: notifier.mobileFormKey,
                        child: CustomMobileField(
                          controller: notifier.mobileController,
                          hintText: "' - ' 없이 숫자만 입력해 주세요",
                          onInputChanged: (PhoneNumber phoneNumber) =>
                              notifier.mobileValidator(phoneNumber),
                          countries: ["KR", "US", "JP", "CN"],
                        ),
                      );
                    },
                  ),

                  /// [인증번호 전송 버튼을 누르는 순간 pin번호 입력화면이 등장]
                  /// [Timer도 함께 등장]
                  /// 타이머가 사라지면 pin번호 입력화면도 사라짐
                  if (showAuthPinField) ...[
                    Consumer(
                      builder: (context, ref, child) {
                        final state = ref.watch(timerProvider);
                        final timerNotifier = ref.watch(timerProvider.notifier);
                        final notifier = ref.watch(resetPinProvider.notifier);

                        return AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          curve: Curves.linear,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                flex: 4,
                                child: AuthPinField(
                                  controller: notifier.pinController,
                                  // onCompleted: (String pin) {
                                  //   /// [서버에 보내기]
                                  //   /// 6자리 핀이 맞으면 state.disable = false (Success)
                                  // },
                                  onCompleted: (String pin) =>
                                      notifier.verifyMobilePin(pin),
                                ),
                              ),
                              Flexible(
                                flex: 1,
                                child: _textTimerWidget(
                                  context,
                                  timer: timerNotifier.formatTimer(
                                    state.seconds,
                                  ),
                                ).intrinsitHeight,
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],

                  /// [인증번호 전송]
                  /// 올바른 길이의 번호를 입력하면 disabled 해지
                  Consumer(
                    builder: (context, ref, child) {
                      final state = ref.watch(timerProvider);
                      final notifier = ref.watch(timerProvider.notifier);
                      return AppButton(
                        width: constraints.maxWidth / 3,
                        disabled: state.disable,
                        label:
                            "${_resentString(state.disable)} ${notifier.formatTimer(state.resendSeconds)}",
                        labelColor: AppColor.black,
                        onPressed: () {
                          notifier.startTimer();
                          setState(() {
                            showAuthPinField = true;
                          });
                        },
                      ).center;
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _textTimerWidget(BuildContext context, {required String timer}) {
    return Text(
      timer,
      style: context.bodyText?.copyWith(color: AppColor.yellow),
    ).paddingSymmetric(size: const Size(14, 0));
  }

  String _resentString(bool disabled) {
    return disabled ? "재발송" : "인증번호";
  }
}
