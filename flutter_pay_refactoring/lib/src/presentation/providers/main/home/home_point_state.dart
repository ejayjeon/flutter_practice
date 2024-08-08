part of '../../provider.dart';

@freezed
abstract class HomePointState with _$HomePointState {
  const factory HomePointState.initial() = HomePointStateInitial;
  const factory HomePointState.loading() = HomePointStateLoading;
  const factory HomePointState.failure(DioException exception) =
      HomePointStateFailure;
  const factory HomePointState.success() = HomePointStateSuccess;
}
