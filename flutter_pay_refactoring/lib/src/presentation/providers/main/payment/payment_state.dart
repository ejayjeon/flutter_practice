part of '../../provider.dart';

@freezed
class PaymentState with _$PaymentState {
  // factory PaymentState() = _PaymentState;
  const factory PaymentState.initial() = PaymentInitial;
  const factory PaymentState.loading() = PaymentLoading;
  const factory PaymentState.failure() = PaymentFailure;
  const factory PaymentState.success() = PaymentSuccess;

  factory PaymentState.fromJson(Map<String, dynamic> json) =>
      _$PaymentStateFromJson(json);
  // Map<String, dynamic> toJson() => _$PaymentStateToJson(this);
}
