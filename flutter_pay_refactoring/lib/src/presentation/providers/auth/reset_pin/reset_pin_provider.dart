part of '../../provider.dart';

final resetPinProvider =
    StateNotifierProvider<ResetPinNotifier, ResetPinState>((ref) {
  return ResetPinNotifier();
});

final timerProvider =
    StateNotifierProvider<TimerNotifier, TimerState>((ref) => TimerNotifier());
