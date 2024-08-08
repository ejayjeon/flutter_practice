import 'dart:async';

import 'package:flutter/material.dart';

class Time {
  final int? hour;
  final int? minute;
  final int? second;
  final int? millisecond;

  Time({
    this.hour,
    this.minute,
    this.second,
    this.millisecond,
  });
}

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
  bool get isPaused => _isPaused;
  List<int> get laps => _laps;

  /// [Method]
  /// [타이머 시작]
  void startTimer() {
    stopTimer();
    _laps.clear(); // stop할때 지워버리면, 타이머가 다 되고 나서 lap 한 기록이 사라짐
    switchPeriod(shouldMilliSec);
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

  /// [타이머 삭제]
  void stopTimer() {
    _timer?.cancel();
    _timer = null;
    _elapsedTime = 0;
    _isPaused = false;
  }

  /// [타이머 멈추기]
  void pauseTimer() {
    _isPaused = true;
    _elapsedTime = seconds; // 현재 누른 시각의 seconds
    setState(() {});
  }

  /// [타이머 다시 재생]
  void resumeTimer() {
    _isPaused = false;
    seconds = _elapsedTime;
    setState(() {});
  }

  /// [타임래핑]
  void lapTimer() {
    if (!_isPaused) {
      setState(() {
        _elapsedTime = seconds;
        _laps.add(_elapsedTime);
      });
    }
  }

  /// [랩 리스트 비우기]
  void clearLaps() {
    if (_laps.isNotEmpty) {
      setState(() {
        _laps.clear();
      });
    }
  }

  Time formatTime(int second) {
    int seconds = second ~/ 1000;
    int hours = (seconds ~/ 3600);
    int minutes = ((seconds % 3600) ~/ 60);

    /// 위의 seconds와 다른 점은, 전체 초를 기준으로 하는 것이 아니라, 60초 단위로 나눈 초!
    int secs = (seconds % 60);

    int millis = (second % 1000);
    return Time(
      hour: hours,
      minute: minutes,
      second: secs,
      millisecond: millis,
    );
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
