part of '../../provider.dart';

@freezed
class ResetPinState with _$ResetPinState {
  const factory ResetPinState.initial([@Default(true) bool disabled]) =
      ResetPinStateInitial;
  const factory ResetPinState.loading([@Default(true) bool disabled]) =
      ResetPinStateLoading;
  const factory ResetPinState.failure([@Default(false) bool disabled]) =
      ResetPinStateFailure;
  const factory ResetPinState.success([@Default(false) bool disabled]) =
      ResetPinStateSuccess;

  factory ResetPinState.fromJson(Map<String, dynamic> json) =>
      _$ResetPinStateFromJson(json);
}
