import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/extensions/widget_extension.dart';
import 'package:sketch_pay/src/shared/routes/router.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/styles/app_theme.dart';
import 'package:sketch_pay/src/shared/styles/layouts/entrance_layout.dart';
import 'package:sketch_pay/src/shared/widgets/button/pin_button.dart';

class PinCheckScreen extends ConsumerStatefulWidget {
  const PinCheckScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PinCheckScreenState();
}

class _PinCheckScreenState extends ConsumerState<PinCheckScreen> {
  late final TextEditingController _pinController;
  final FocusNode _pinFocus = FocusNode();
  final List<String> _keys = [
    '',
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9'
  ];
  List<String> get keys => _keys;

  /// [입력한 핀]
  String pin = "";
  String firstPin = "";

  /// [핀을 입력한 횟수]
  late int inputCount;
  @override
  void initState() {
    super.initState();
    _pinController = TextEditingController(text: "");
    keys.shuffle();
    inputCount = 0;
  }

  @override
  void dispose() {
    // 별도로 remove를 할 필요가 없다.. ?
    // _pinController.dispose();
    // _pinFocus.dispose();
    super.dispose();
  }

  void refreshPin(BuildContext context, String pin) {
    if (inputCount < 1) {
      setState(() {
        firstPin = pin;
        pin = '';
        _pinController.text = pin;
        FocusScope.of(context).requestFocus(_pinFocus);
        keys.shuffle();
        inputCount++;
      });
    } else {
      /// 만약에, 0번째때 입력한 핀과, 지금 입력한 핀이 같으면?
      if (checkPinCorrect(pin)) {
        context.go(AccountRoute.path);
      } else {
        _pinController.text = "";
        firstPin = "";
        FocusScope.of(context).requestFocus(_pinFocus);
        keys.shuffle();
        inputCount = 0;
      }
    }
  }

  /// [이전에 입력한 핀과 지금 입력한 핀이 같은지 여부]
  bool checkPinCorrect(String pin) {
    log(_pinController.text, name: "pinController");
    log(pin, name: "pin");
    return firstPin == pin;
  }

  void removePin(String pin) {
    setState(() {
      // if (pin.isNotEmpty) {
      //   pin = pin.substring(0, pin.length - 1);
      //   _pinController.text = pin;
      // }

      while (_pinController.text.isNotEmpty) {
        _pinController.text = removeCharacters(_pinController.text);
      }
    });
  }

  String removeCharacters(String value) {
    if (value.isEmpty) return value;
    return value.substring(0, value.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return EntranceLayout(
      color: AppColor.backGround,
      child: Column(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              width: context.width,
              child: Column(
                children: <Widget>[
                  _header(
                    context,
                    title: "PIN 번호 입력",
                    onPressed: () => context.canPop()
                        ? context.pop()
                        : context.go(HomeRoute.path),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _upsideTitle(
                          context,
                          title: "6자리 PIN 번호를 입력하세요",
                        ),
                        _pinFormText(
                          context,
                          controller: _pinController,
                          focusNode: _pinFocus,

                          /// [6자리가 전부 입력되었을 때 이 함수가 실행됨]
                          onCompleted: (value) {
                            log(value, name: "onComplete");
                            refreshPin(context, value);
                          },
                        ).paddingSymmetric(size: Size(24.sp, 24.sp)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: context.width,
              color: AppColor.white,
              child: PinButton(
                keys: keys,
                controller: _pinController,
                pin: pin,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(
    BuildContext context, {
    required String title,
    VoidCallback? onPressed,
  }) {
    double fontSize = 24;
    // return Container(
    //   height: kToolbarHeight + 40.9,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.only(
    //       bottomLeft: Radius.circular(64.r),
    //       bottomRight: Radius.circular(64.r),
    //     ),
    //     color: AppColor.black,
    //   ),
    //   child: Row(
    //     children: <Widget>[
    //       IconButton(
    //         onPressed: onPressed,
    //         icon: const Icon(
    //           Icons._ios_new_rounded,
    //           color: AppColor.white,
    //         ),
    //       ),
    //       Expanded(
    //         child: Text(
    //           title,
    //           style: context.headerText?.copyWith(fontSize: 24),
    //         ).center,
    //       ),
    //     ],
    //   ),
    // );
    return AppBar(
      toolbarHeight: kToolbarHeight + fontSize,
      leading: IconButton(
        onPressed: onPressed,
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: AppColor.white,
        ),
      ),
      automaticallyImplyLeading: true,
      title: Text(
        title,
        style: context.headerText?.copyWith(fontSize: fontSize),
      ),
      backgroundColor: AppColor.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(kToolbarHeight.r),
        ),
        side: const BorderSide(
          color: AppColor.black,
          width: 1.0,
        ),
      ),
    );
  }

  Widget _upsideTitle(
    BuildContext context, {
    required String title,
  }) {
    return Text(
      title,
      style: context.titleText?.copyWith(
        color: AppColor.white,
      ),
    ).paddingOnly(bottom: 24.sp);
  }

  Widget _pinFormText(
    BuildContext context, {
    required TextEditingController controller,
    FocusNode? focusNode,
    ValueChanged<String>? onCompleted,
  }) {
    return PinCodeTextField(
      keyboardType: TextInputType.number,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      appContext: context,
      length: 6,
      controller: controller,
      autoFocus: true,
      focusNode: focusNode,
      enabled: true,
      obscureText: true,
      readOnly: false,
      showCursor: false,
      enableActiveFill: true,
      autoDismissKeyboard: true,
      blinkWhenObscuring: true,
      pinTheme: AppTheme.pinTheme,
      obscuringWidget: const Text(
        '✱',
        style: TextStyle(
          color: AppColor.primary,
        ),
      ),
      onCompleted: onCompleted,
      useHapticFeedback: true,
      hapticFeedbackTypes: HapticFeedbackTypes.light,
    );
  }
}
