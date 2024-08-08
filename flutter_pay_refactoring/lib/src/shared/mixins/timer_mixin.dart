import 'dart:async';

import 'package:flutter/material.dart';

mixin TimerMixin<T extends StatefulWidget> on State<T> {
  Timer? _timer;
  int seconds = 0;
  int duration = 1;
  bool shouldMilliSec = false;

  /// [Pause 기능]
  int _elapsedTime = 0;
  bool _isPaused = false;

  /// [Lap Time 기능]
  List<int> _laps = [];

  /// [Getter]
  // int get duration;
  bool get isPaused => _isPaused;
  List<int> get laps => _laps;
  // int get seconds;

  /// [Method]
  void startTimer() {
    stopTimer();
    _laps.clear(); // stop할때 지워버리면, 타이머가 다 되고 나서 lap 한 기록이 사라짐
    if (_timer != null) return;
    _timer = Timer.periodic(
        shouldMilliSec
            ? Duration(milliseconds: duration)
            : Duration(seconds: duration), (timer) {
      if (!_isPaused) {
        onTimerTick();
      }
    });
  }

  setSeconds(int seconds) {
    this.seconds = seconds;
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    _elapsedTime = 0;
    _isPaused = false;
  }

  void pauseTimer() {
    _isPaused = true;
    _elapsedTime = seconds; // 현재 누른 시각의 seconds
    setState(() {});
  }

  void resumeTimer() {
    _isPaused = false;
    seconds = _elapsedTime;
    setState(() {});
  }

  void lapTimer() {
    if (!_isPaused) {
      setState(() {
        _elapsedTime = seconds;
        _laps.add(_elapsedTime);
      });
    }
  }

  String formatTimer(int milliseconds) {
    int seconds = milliseconds ~/ 1000;
    int hours = (seconds ~/ 3600);
    int minutes = ((seconds % 3600) ~/ 60);

    /// 위의 seconds와 다른 점은, 전체 초를 기준으로 하는 것이 아니라, 60초 단위로 나눈 초!
    int secs = (seconds % 60);

    int millis = (milliseconds % 1000);

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${secs.toString().padLeft(2, '0')}';
    } else {
      return '${hours.toString().padLeft(2, '0')}:'
          '${minutes.toString().padLeft(2, '0')}:'
          '${secs.toString().padLeft(2, '0')}';
    }
  }

  /// [Implement on widget]
  void onTimerTick() {}

  /// sec -> milliSec
  /// milliSec -> sec
  void switchPeriod(bool shouldMilliSec) {
    if (shouldMilliSec) {
      seconds *= 1000;
    } else {
      seconds = seconds;
    }
  }

  @override
  void dispose() {
    stopTimer();
    super.dispose();
  }
}

///  5 * 60 * 1000
formatTime(int milliseconds) {
  int sec = milliseconds ~/ 1000;

  /// 1초단위 3600초 시간으로 나눈 나머지
  int min = ((sec % 3600) ~/ 60);
  int hours = sec ~/ 3600;

  int millies = milliseconds % 1000;

  /// 분이 지나면 분에 시간을 줘버림
  int secs = sec % 60;

  return '$hours:$min:$secs.$millies';
}
