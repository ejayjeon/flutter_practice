part of '../../provider.dart';

@freezed
sealed class HistoryState with _$HistoryState {
  const factory HistoryState.initial() = HistoryStateInitial; // 가장 처음 받아올 때
  const factory HistoryState.loading() = HistoryStateLoading;
  const factory HistoryState.failure() = HistoryStateFailure;
  const factory HistoryState.empty() = HistoryStateEmpty;
  const factory HistoryState.success() = HistoryStateSuccess;
}
