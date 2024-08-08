part of '../repository.dart';

abstract class HistoryRepository {
  Future<Either<DioException, ApiResponse<PayHistoryModel>>> payHistory({
    required JSON data,
  });
}
