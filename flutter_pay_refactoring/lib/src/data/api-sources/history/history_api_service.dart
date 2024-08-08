part of '../api_source.dart';

@RestApi()
abstract class HistoryApiService {
  factory HistoryApiService(Dio dio, {String baseUrl}) = _HistoryApiService;

  @POST('/api/v2/payHistory')
  Future<Either<DioException, ApiResponse<PayHistoryModel>>> payHistory({
    @Body() required JSON data,
  });
}
