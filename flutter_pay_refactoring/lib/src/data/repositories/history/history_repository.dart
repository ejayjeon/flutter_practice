part of '../repository.dart';

class HistoryReposiroryImpl extends HistoryRepository {
  final HistoryApi api;

  HistoryReposiroryImpl(this.api);
  @override
  Future<Either<DioException, ApiResponse<PayHistoryModel>>> payHistory(
      {required JSON data}) {
    return api.payHistory(data: data);
  }
}
