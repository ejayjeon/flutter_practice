part of '../api_source.dart';

class HistoryApi implements HistoryApiService {
  final DioService dioService;
  HistoryApi(this.dioService);
  @override
  Future<Either<DioException, ApiResponse<PayHistoryModel>>> payHistory({
    required JSON data,
  }) async {
    final request = await ApiUtil.requestEncodingWighParams(
      args: ['acctCd', 'fromDt', 'toDt', 'pageSize', 'currentPage', 'category'],
      values: [
        data['acctCd'],
        data['fromDt'],
        data['toDt'],
        data['pageSize'],
        data['currentPage'],
        data['category'],
      ],
    );
    final response = await dioService.post('/api/v2/payHistory', data: request);

    return response.fold(
      (left) => Either.left(left),
      (right) => Either.right(
        ApiResponse<PayHistoryModel>(
          meta: right.meta,
          auth: right.auth,
          // data: PayHistoryModel.fromJson(
          //   ApiUtil.responseDecodingFromParams(data: right.data),
          // ) // 이 부분은 이미 적용됨,
          data: PayHistoryModel.fromJson(right.data),
        ),
      ),
    );
  }
}
