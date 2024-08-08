import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerState {
  final int seconds;
  final bool disable;
  final int resendSeconds;
  TimerState({
    this.seconds = 60 * 3,
    this.disable = false,
    this.resendSeconds = 20,
  });
}

class TimerNotifier extends StateNotifier<TimerState> {
  TimerNotifier() : super(TimerState(disable: false));
  Timer? _timer;
  int sec = 60 * 3;
  int resendSec = 20;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String formatTimer(int seconds) {
    final min = (seconds ~/ 60).toString().padLeft(2, '0');
    final remainingSec = (seconds % 60).toString().padLeft(2, '0');
    return '$min:$remainingSec';
  }

  void startTimer() {
    resetTimer();
    if (_timer != null) return; // 이미 타이머가 실행 중이면 아무것도 하지 않음

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.resendSeconds > 0) {
        state = TimerState(
          seconds: state.seconds - 1,
          disable: true,
          resendSeconds: state.resendSeconds - 1,
        );
      } else if (state.resendSeconds <= 0 && state.seconds > 0) {
        state = TimerState(
          seconds: state.seconds - 1,
          disable: false,
          resendSeconds: 0,
        );
      }
      if (state.seconds <= 0) {
        _timer?.cancel();
        _timer = null;
      }
    });
  }

  void resetTimer() {
    state = TimerState(seconds: sec, disable: false, resendSeconds: resendSec);
    _timer?.cancel();
    _timer = null;
  }
}
