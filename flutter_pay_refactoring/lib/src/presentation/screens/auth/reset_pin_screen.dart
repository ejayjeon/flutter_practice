import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sketch_pay/src/presentation/providers/auth/reset_pin/timer_notifier.dart';
import 'package:sketch_pay/src/presentation/providers/provider.dart';
import 'package:sketch_pay/src/presentation/screens/auth/tabs/check_email_tab.dart';
import 'package:sketch_pay/src/presentation/screens/auth/tabs/check_mobile_tab.dart';
import 'package:sketch_pay/src/shared/extensions/context_extension.dart';
import 'package:sketch_pay/src/shared/extensions/widget_extension.dart';
import 'package:sketch_pay/src/shared/mixins/tab_controller_mixin.dart';
import 'package:sketch_pay/src/shared/styles/app_color.dart';
import 'package:sketch_pay/src/shared/styles/layouts/detail_layout.dart';
import 'package:sketch_pay/src/shared/widgets/button/app_button.dart';
import 'package:sketch_pay/src/shared/widgets/misc/page_progress_bar.dart';

class ResetPinScreen extends ConsumerStatefulWidget {
  const ResetPinScreen({super.key});

  @override
  ConsumerState<ResetPinScreen> createState() => _ResetPinScreenState();
}

class _ResetPinScreenState extends ConsumerState<ResetPinScreen>
    with TabControllerMixin {
  @override
  int get tabLengthInit => 3;

  void onNextIndex() {
    var state = ref.watch(resetPinProvider.notifier);
    setState(() {
      if (tabController.index < tabLengthInit - 1) {
        tabController.index++;
        state.state = const ResetPinState.initial();
        state.emailController.text = "";
      } else {
        tabController.index;
      }
    });
  }

  void onPreviousIndex() {
    var state = ref.watch(resetPinProvider.notifier);
    setState(() {
      if (tabController.index > 0) {
        tabController.index--;
        state.state = const ResetPinState.initial();
        state.emailController.text = "";
        state.pinController.text = "";
        state.mobileController.text = "";
      } else {
        tabController.index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final timerNotifier = ref.watch(timerProvider.notifier);
    final notifier = ref.watch(resetPinProvider.notifier);
    final state = ref.watch(resetPinProvider);
    return DetailLayout(
      appBarTitle: "본인 인증",
      appBarColor: Colors.transparent,
      color: AppColor.backGround,
      onLeadingPressed: () {
        onPreviousIndex();
      },
      fab: FloatingActionButton(
        foregroundColor: AppColor.black,
        backgroundColor: AppColor.black,
        onPressed: () {
          timerNotifier.resetTimer();
          setState(
            () {},
          );
        },
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => ConstrainedBox(
          constraints: constraints,
          child: Column(
            children: <Widget>[
              PageProgressBar(
                currentIndex: tabController.index,
                maxLength: tabLengthInit,
                height: 10.h,
                width: constraints.maxWidth - 24,
                type: ProgressType.line,
                onPageChanged: (int index) {
                  setState(() {
                    tabController.index = index;
                    log(index.toString(), name: "reset");
                  });
                },
              ).paddingSymmetric(size: const Size(0, 12)),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _tab(
                      context,
                      child: CheckEmailTab(controller: tabController),
                      state: state,
                      onPressed: () {
                        final verified = notifier.verifyEmail();
                        if (verified) {
                          onNextIndex();
                        }
                        notifier.verifyEmail();
                      },
                    ),
                    _tab(
                      context,
                      child: CheckMobileTab(controller: tabController),
                      state: state,
                      onPressed: () {
                        final verified = notifier
                            .verifyMobilePin(notifier.pinController.text);
                        if (verified) {
                          onNextIndex();
                        }
                        notifier.verifyMobilePin(notifier.pinController.text);
                      },
                    ),
                    _tab(
                      context,
                      child: Container(),
                      state: state,
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tab(
    BuildContext context, {
    required Widget child,
    required ResetPinState state,
    VoidCallback? onPressed,
  }) {
    return Container(
      // color: AppColor.white,
      padding: context.gap(size: const Size(12, 8)),
      child: Column(
        children: [
          Expanded(child: child),
          AppButton(
            label: "확인",
            labelColor: AppColor.black,
            disabled: state.disabled,
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
